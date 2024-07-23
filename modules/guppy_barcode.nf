//guppu_barcoder.nf

nextflow.enable.dsl=2

def currDir = System.getProperty("user.dir")

def guppy_path = "${params.guppy_dir}/bin/guppy_barcoder"

process GUPPY_BARCODER {

	label 'guppy_barcoder'

	publishDir "${currDir}/${params.output_dir}", mode : 'copy'

	input:
	path input_dir

	output:
	path "guppy_barcoder", emit: barcodes

	script:
	"""
	${guppy_path} --recursive \
		--require_barcodes_both_ends \
		-i ${input_dir} \
		-s "guppy_barcoder" \
		--barcode_kits ${params.kit_name} \
		-x ${params.guppy_run_mode}
	"""
}

//${guppy_path} --recursive \
//    --require_barcodes_both_ends \
//    -i ${input_dir} \
//    -s "guppy_barcoder" \
//    --barcode_kits ${params.kit_name}
//    -x {params.guppy_run_mode} | tee guppy_barcoder.log 2>&1
