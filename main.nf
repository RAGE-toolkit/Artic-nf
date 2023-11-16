//main.nf

def currDir = System.getProperty("user.dir");

include { guppy_basecaller } from './modules/guppy_basecaller.nf'
include { guppy_barcoder } from './modules/guppy_barcode.nf'
include {guppy_plex} from './modules/guppy_plex.nf'
//include {medaka} from 'modules/medaka.nf'
//include {concat} from 'modules/concat.nf'
//include {mafft_aln} from 'modules/mafft.nf'


fq_extension = ".fastq"
// listing all the dirs inside fastq folder
def barcode_lists() {
	def barcodes = [];
	def currDir = System.getProperty("user.dir");
	def folder = "${currDir}/${params.output_dir}/fastq"
	def baseDir = new File(folder);
	files = baseDir.listFiles();
	println(files "${currDir}")
	def pattern = /barcode\d+/

	for (item in files) {
		if (item.toString().find(pattern)) {
			barcodes.add(item)
		}
	}
	println(barcodes)
	return barcodes

}

workflow {

        basecaller_ch = Channel.fromPath("${currDir}/${params.fast5_dir}")

        guppy_basecaller_out = guppy_basecaller(fast5_dir=basecaller_ch)
	guppy_basecaller_out.view()

	barcoder_output = guppy_barcoder(input_dir=guppy_basecaller_out.view())
	barcoder_output.view()

	def barcods = barcode_lists()
	println(barcods)
	guppyplex_output = guppy_plex(barcods, fq_extension, output_partial_dir=barcoder_output.view())


	//def mylist = barcode_lists()
	//guppy_plex(mylist, fq_extension)
	
}
