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

//__________________________________________________________________________________________
// load modules
////include { GUPPY_BASECALLER        } from './modules/guppy_basecaller.nf'
////include { GUPPY_BARCODER          } from './modules/guppy_barcode.nf'
////include { GUPPY_PLEX              } from './modules/guppy_plex.nf'
include { DORADO_BASECALLER			} from './modules/dorado_basecaller.nf'
include { DORADO_BARCODER       } from './modules/dorado_barcoder.nf'
include { PLEX_FQ_FILES         } from './modules/plex_fq_files.nf'
include { PLEX_DIRS							} from './modules/plex_dirs.nf'
include { MINIMAP2							} from './modules/minimap2.nf'
include { ALIGN_TRIM_1					} from './modules/align_trim-1.nf'
include { ALIGN_TRIM_2					} from './modules/align_trim-2.nf'
include { MEDAKA_1							} from './modules/medaka-1.nf'
include { MEDAKA_2							} from './modules/medaka-2.nf'
include { MEDAKA_SNP_1					} from './modules/medaka_snp-1.nf'
include { MEDAKA_SNP_2					} from './modules/medaka_snp-2.nf'
include	{ VCF_MERGE							} from './modules/vcf_merge.nf'
include { LONGSHOT							} from './modules/longshot.nf'
include	{ VCF_FILTER						} from './modules/vcf_filter.nf'
include { MAKE_DEPTH_MASK				} from './modules/make_depth_mask.nf'
include { MASK									} from './modules/mask.nf'
include	{ BCFTOOLS_CONSENSUS		} from './modules/bcftools_consensus.nf'
include { FASTA_HEADER					} from './modules/fasta_header.nf'
include	{ CONCAT_FOR_MUSCLE			} from './modules/concat_for_muscle.nf'
include	{ MUSCLE								} from './modules/muscle.nf'
include { CONCAT								} from './modules/concat.nf'
include { MAFFT									} from './modules/mafft.nf'
include	{ SUMMARY_STATS					} from './modules/summary_stats.nf'
//__________________________________________________________________________________________
// load meta data
meta_file = "$currDir/${params.meta_file}";
extension = ".fastq"

fq_channel = channel
        .fromPath(meta_file)
        .splitCsv(header: true, sep: ",")
  .map { row -> tuple(row.sampleId, row.barcode, row.schema, row.version) }

//__________________________________________________________________________________________
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

rawfile_dir = "${params.rawfile_dir}"

//__________________________________________________________________________________________
workflow
{
	if (params.rawfile_type == "fastq") {
	PLEX_DIRS(input_dir=rawfile_dir, fq_channel)
	MINIMAP2(input_dir=PLEX_DIRS.out.collect(), fq_channel)
	ALIGN_TRIM_1(input_bam=MINIMAP2.out.sorted_bam.collect(), fq_channel)
	ALIGN_TRIM_2(input_bam=ALIGN_TRIM_1.out.trimmed_bam.collect(), fq_channel)
	MEDAKA_1(input_bam=ALIGN_TRIM_2.out.primertrimmed_bam.collect(), fq_channel)
	MEDAKA_2(input_hdf=MEDAKA_1.out.hdf.collect(), fq_channel)
	MEDAKA_SNP_1(input_hdf=MEDAKA_2.out.hdf.collect(), fq_channel)
	MEDAKA_SNP_2(input_hdf=MEDAKA_SNP_1.out.vcf.collect(), fq_channel)
	VCF_MERGE(input_vcf=MEDAKA_SNP_2.out.vcf.collect(), fq_channel)
	LONGSHOT(input_vcf=VCF_MERGE.out.vcf.collect(), fq_channel)
	VCF_FILTER(input_vcf=LONGSHOT.out.vcf.collect(), fq_channel)
	MAKE_DEPTH_MASK(input_vcf=VCF_FILTER.out.pass_vcf.collect(), fq_channel)
	MASK(input_vcf=MAKE_DEPTH_MASK.out.coverage_mask.collect(), fq_channel)
	BCFTOOLS_CONSENSUS(input_vcf=MASK.out.preconsensus.collect(), fq_channel)
	FASTA_HEADER(input_vcf=BCFTOOLS_CONSENSUS.out.consensus_fa.collect(), fq_channel)
	CONCAT_FOR_MUSCLE(input_vcf=FASTA_HEADER.out.fasta.collect(), fq_channel)
	MUSCLE(input_vcf=CONCAT_FOR_MUSCLE.out.muscle_fa.collect(), fq_channel)
	CONCAT(input_fasta=MUSCLE.out.muscle_op_fasta.collect())
	MAFFT(concat_fa=CONCAT.out.genome_fa.collect())
	SUMMARY_STATS(item=MAFFT.out.mafft_fa.collect())
	}
	else {
	if (params.basecaller == "Dorado") {
		DORADO_BASECALLER(fast5_or_pod5_dir="${params.rawfile_dir}")
		DORADO_BARCODER(fastq_file=DORADO_BASECALLER.out)
		PLEX_FQ_FILES(DORADO_BARCODER.out, fq_channel)
		MINIMAP2(input_dir=PLEX_FQ_FILES.out.collect(), fq_channel)
		ALIGN_TRIM_1(input_bam=MINIMAP2.out.sorted_bam.collect(), fq_channel)
		ALIGN_TRIM_2(input_bam=ALIGN_TRIM_1.out.trimmed_bam.collect(), fq_channel)
		MEDAKA_1(input_bam=ALIGN_TRIM_2.out.primertrimmed_bam.collect(), fq_channel)
		MEDAKA_2(input_hdf=MEDAKA_1.out.hdf.collect(), fq_channel)
		MEDAKA_SNP_1(input_hdf=MEDAKA_2.out.hdf.collect(), fq_channel)
		MEDAKA_SNP_2(input_hdf=MEDAKA_SNP_1.out.vcf.collect(), fq_channel)
		VCF_MERGE(input_vcf=MEDAKA_SNP_2.out.vcf.collect(), fq_channel)
		LONGSHOT(input_vcf=VCF_MERGE.out.vcf.collect(), fq_channel)
		VCF_FILTER(input_vcf=LONGSHOT.out.vcf.collect(), fq_channel)
		MAKE_DEPTH_MASK(input_vcf=VCF_FILTER.out.pass_vcf.collect(), fq_channel)
		MASK(input_vcf=MAKE_DEPTH_MASK.out.coverage_mask.collect(), fq_channel)
		BCFTOOLS_CONSENSUS(input_vcf=MASK.out.preconsensus.collect(), fq_channel)
		FASTA_HEADER(input_vcf=BCFTOOLS_CONSENSUS.out.consensus_fa.collect(), fq_channel)
		CONCAT_FOR_MUSCLE(input_vcf=FASTA_HEADER.out.fasta.collect(), fq_channel)
		MUSCLE(input_vcf=CONCAT_FOR_MUSCLE.out.muscle_fa.collect(), fq_channel)
		CONCAT(input_fasta=MUSCLE.out.muscle_op_fasta.collect())
		MAFFT(concat_fa=CONCAT.out.genome_fa.collect())
		SUMMARY_STATS(item=MAFFT.out.mafft_fa.collect())
		}
	else {
	// Guppy rule here, still under development
	}
}
/*
workflow {

	if (params.rawfile_type == "fastq"){
		DORADO_PLEX(input_dir="${params.rawfile_dir}", fq_channel)
		MEDAKA_DORADO(input_dir=DORADO_PLEX.out, fq_channel)
		//CONCAT(medaka_dir=MEDAKA_DORADO.out.consensus)
		//CONCAT.out.collect().view()
		//MAFFT(concat_file=CONCAT.out)
		//SUMMARY_STATS(item=MEDAKA_DORADO.out.bam)
		//MERGE_SUMMARY_STATS(item=SUMMARY_STATS.out.summary_dir)
		//SUMMARY_STATS2(item=MEDAKA_DORADO.out.consensus)
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
*/
