//main.nf

def currDir = System.getProperty("user.dir");

//checking if output dir exists
def res_dir = new File("${currDir}/${params.output_dir}")
if (!res_dir.exists()) {
        res_dir.mkdirs()
}

//checking raw_file dir exists
def raw_dir = new File("${currDir}/raw_files")
if (!raw_dir.exists()) {
  raw_dir.mkdir()
}

//checking if fastq dir exists
def fq_dir = new File("${currDir}/${params.fastq_dir}")
if (!fq_dir.exists()) {
  fq_dir.mkdir()
}

include { GUPPY_BASECALLER        } from './modules/guppy_basecaller.nf'
include { GUPPY_BARCODER          } from './modules/guppy_barcode.nf'
include { GUPPY_PLEX              } from './modules/guppy_plex.nf'
include { MEDAKA                  } from './modules/medaka.nf'
include { CONCAT                  } from './modules/concat.nf'
include { MAFFT                   } from './modules/mafft.nf'
include { DORADO_BASECALLER       } from './modules/dorado_basecaller.nf'
include { DORADO_BARCODER         } from './modules/dorado_barcoder.nf'
include { DORADO_DEMUX            } from './modules/dorado_demux.nf'
include { DORADO_PLEX             } from './modules/dorado_plex.nf'
include { MEDAKA_DORADO           } from './modules/medaka_dorado.nf'
include { SUMMARY_STATS           } from './modules/summary_stats.nf'
//include { MERGE_SUMMARY_STATS     } from './modules/merge_stats.nf'
include	{ SUMMARY_STATS2		} from './modules/summary_stats2.nf'

meta_file = "$currDir/${params.meta_file}";
extension = ".fastq"

fq_channel = channel
        .fromPath(meta_file)
        .splitCsv(header: true, sep: ",")
  .map { row -> tuple(row.sampleId, row.barcode, row.schema, row.version) }

println(" ");
println("Output file		:" + "${currDir}/${params.output_dir}");
println("Meta file		:" + meta_file);
println("Basecaller		:" + "${params.basecaller}");
println("Rawfile directory	:" + "${params.rawfile_dir}");
println("Rawfile type		:" + "${params.rawfile_type}");
println("Output base dir	:" + "${params.output_dir}");

if ("${params.basecaller}" == "Guppy") {
  println("Basecaller path	:" + "${params.guppy_dir}");
}
else {
  println("Basecaller path	:" +  "${params.dorado_dir}");
}

rawfile_ch = Channel.fromPath("${params.rawfile_dir}")

workflow {

	if (params.rawfile_type == "fastq") {
		DORADO_PLEX(input_dir="${params.rawfile_dir}", fq_channel)
		MEDAKA_DORADO(input_dir=DORADO_PLEX.out, fq_channel)
		CONCAT(medaka_dir=MEDAKA_DORADO.out.consensus)
    		////CONCAT.out.collect().view()
    		MAFFT(concat_file=CONCAT.out)
    		SUMMARY_STATS(item=MEDAKA_DORADO.out.bam)
    		//MERGE_SUMMARY_STATS(item=SUMMARY_STATS.out.summary_dir)
		SUMMARY_STATS2(item=MEDAKA_DORADO.out.consensus)
		}
	else {
		if (params.basecaller == "Guppy") {
		GUPPY_BASECALLER(fast5_dir=rawfile_ch)
		GUPPY_BARCODER(fast5_dir=GUPPY_BASECALLER.out)
		GUPPY_PLEX(input_dir=GUPPY_BARCODER.out.collect(), fq_channel)
		MEDAKA(input_dir=GUPPY_PLEX.out.view(), fq_channel)
		CONCAT(medaka_dir=MEDAKA.out)
		MAFFT(concat_file=CONCAT.out)
		SUMMARY_STATS(item=MEDAKA.out)
		MERGE_SUMMARY_STATS(item=SUMMARY_STATS.out.summary_dir)
    		}
    		else 	{
		DORADO_BASECALLER(fast5_or_pod5_dir="${params.rawfile_dir}")
		DORADO_BARCODER(fastq_file=DORADO_BASECALLER.out)
		DORADO_DEMUX(barcode_dir=DORADO_BARCODER.out.collect(), fq_channel)
    		MEDAKA_DORADO(input_dir=DORADO_DEMUX.out, fq_channel)
    		CONCAT(medaka_dir=MEDAKA_DORADO.out)
    		MAFFT(item=CONCAT.out)
    		SUMMARY_STATS(item=MEDAKA_DORADO.out)
    		MERGE_SUMMARY_STATS(item=SUMMARY_STATS.out.summary_dir)
		SUMMARY_STATS2(item=MEDAKA_DORADO.out)
    		}
  	}
}
