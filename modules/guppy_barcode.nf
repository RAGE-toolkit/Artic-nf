nextflow.enable.dsl=2

def currDir = System.getProperty("user.dir")

process guppy_barcoder {
	script:
	"""
	$currDir/${params.guppy_dir}/guppy_barcoder --recursive \
		--require_barcodes_both_ends \
		-i $currDir/${params.output_dir}/"guppy_basecaller" \
		-s $currDir/${params.output_dir}/"fastq" \
		--barcode_kits EXP-NBD104
	"""
}

/*
workflow {
	guppy_barcoder()
}
*/
