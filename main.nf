//main.nf

def currDir = System.getProperty("user.dir");

//checking if output dir exists
def res_dir = new File("${currDir}/${params.output_dir}")
if (!res_dir.exists()) {
        res_dir.mkdirs()
}

//checking if fastq dir exists
def fq_dir = new File("${currDir}/${params.fastq_dir}")
if (!fq_dir.exists()) {
	fq_dir.mkdir()
}

include { GUPPY_BASECALLER 	} from './modules/guppy_basecaller.nf'
include { GUPPY_BARCODER 	} from './modules/guppy_barcode.nf'
include { GUPPY_PLEX 		} from './modules/guppy_plex.nf'
include { MEDAKA		} from './modules/medaka.nf'
include { CONCAT 		} from './modules/concat.nf'
include { MAFFT 		} from './modules/mafft.nf'

meta_file = "$currDir/${params.meta_file}";
extension = ".fastq"
println(meta_file);

fq_channel = channel
        .fromPath(meta_file)
        .splitCsv(header: true, sep: "\t")
	.map { row -> tuple(row.sampleId, row.barcode, row.schema, row.version) }

println(fq_channel)	

fast5_ch = Channel.fromPath("${params.fast5_dir}")

workflow {

	GUPPY_BASECALLER(fast5_dir=fast5_ch)
	GUPPY_BARCODER(fast5_dir=GUPPY_BASECALLER.out)
	GUPPY_PLEX(input_dir=GUPPY_BARCODER.out.collect(), fq_channel)
	MEDAKA(input_dir=GUPPY_PLEX.out.view(), fq_channel)
	MEDAKA.out.view()
	CONCAT(medaka_dir=MEDAKA.out)
	CONCAT.out.collect().view()
	MAFFT(concat_file=CONCAT.out)	
}
/*
        basecaller_ch = Channel.fromPath("${currDir}/${params.fast5_dir}")

        guppy_basecaller_out = guppy_basecaller(fast5_dir=basecaller_ch)

	barcoder_output = guppy_barcoder(fast5_dir=guppy_basecaller_out)
	
	guppyplex_output = guppy_plex(guppy_barcoder.out.summ.collect(), fq_channel, extension=extension)
	
	medaka_output = medaka(input_dir=guppyplex_output, fq_channel, extension)  

	GUPPY_PLEX.out.view()

	concat(medaka_dir=medaka_output)

	concat.out.view()
	mafft_aln(concat_file=concat.out.view())

} */
