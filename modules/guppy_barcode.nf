//guppu_barcoder.nf

nextflow.enable.dsl=2

def currDir = System.getProperty("user.dir")

process guppy_barcoder {

	publishDir "${currDir}/${params.output_dir}"
	input:
	path input_dir

	output:
	path "fastq", emit: summ

	script:
	"""
	$currDir/${params.guppy_dir}/guppy_barcoder --recursive \
		--require_barcodes_both_ends \
		-i ${input_dir}\
		-s "fastq" \
		--barcode_kits EXP-NBD104
	"""
}

/*
workflow {
	guppy_barcoder()
}
*/
