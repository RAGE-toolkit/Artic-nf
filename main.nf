//main.nf

def currDir = System.getProperty("user.dir");

include { guppy_basecaller } from './modules/guppy_basecaller.nf'
include { guppy_barcoder } from './modules/guppy_barcode.nf'
include {guppy_plex} from './modules/guppy_plex.nf'
include {medaka} from './modules/medaka.nf'
include {concat} from './modules/concat.nf'
include {mafft_aln} from './modules/mafft.nf'

meta_file = "$currDir/${params.meta_file}";
extension = ".fastq"
println(meta_file);

fq_channel = channel
        .fromPath(meta_file)
        .splitCsv(header: true, sep: "\t")
	.map { row -> tuple(row.sampleId, row.barcode) }
/*
workflow {
        guppy_plex("/export/home4/sk312p/projects/artic_nf_combine/results/fastq", fq_channel, ".fastq")
}
*/

workflow {

        basecaller_ch = Channel.fromPath("${currDir}/${params.fast5_dir}")

        guppy_basecaller_out = guppy_basecaller(fast5_dir=basecaller_ch)

	barcoder_output = guppy_barcoder(fast5_dir=guppy_basecaller_out)
	
	guppyplex_output = guppy_plex(guppy_barcoder.out.summ.collect(), fq_channel, extension=extension)
	
	medaka_output = medaka(input_dir=guppyplex_output, fq_channel, extension)  

	concat(medaka_dir=medaka_output)

	concat.out.view()
	mafft_aln(concat_file=concat.out.view())
}
