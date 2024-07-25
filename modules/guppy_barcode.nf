//guppu_barcoder.nf

nextflow.enable.dsl=2

def currDir = System.getProperty("user.dir")

def default_guppy_barcoder_path = "${params.guppy_dir}/bin/guppy_barcoder"

def isGuppyBarcoderAvailable() {
  def process = ['/bin/bash', '-c', 'source ~/.bashrc && echo $GUPPY_BARCODER'].execute()
  process.waitFor()
  def output = process.text.trim()
  return output ? output : null
  }

def guppy_barcoder_executable = isGuppyBarcoderAvailable() ?: default_guppy_barcoder_path

process GUPPY_BARCODER {

	label 'guppy_barcoder'

	publishDir "${currDir}/${params.output_dir}", mode : 'copy'

	input:
	path input_dir

	output:
	path "guppy_barcoder", emit: barcodes

	script:
	"""
	${guppy_barcoder_executable} --recursive \
		--require_barcodes_both_ends \
		-i ${input_dir} \
		-s "guppy_barcoder" \
		--barcode_kits ${params.kit_name} \
		-x ${params.guppy_run_mode}
	"""
}

