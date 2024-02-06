//guppy_basecaller.nf

nextflow.enable.dsl=2

def currDir = System.getProperty("user.dir");

meta_file = "$currDir/${params.meta_file}";

def hash = [:].withDefault { [] }

new File(meta_file).eachLine { line ->
    def (key, values) = line.split(',', 2)
    hash[key] << values
}

def dorado_path = "${params.dorado_dir}/bin/dorado"
def model_dir 	= "${params.dorado_dir}/model"

process CREATE_EMPTY_FQ_DIR {

	label "create_empty_fq_dir"

	publishDir "${currDir}/${params.output_dir}/dorado_barcoder/", mode: 'copy'

	input:
	path barcode_dir
	tuple val(sample_id), val(item), val(scheme), val(version)	

	output:
	val "${item}", emit: move

	script:
	"""

	if [ ! -d "${currDir}/${params.output_dir}/dorado_barcoder/${item}" ]; then
		mkdir -p "${currDir}/${params.output_dir}/dorado_barcoder/${item}"

	fi
	"""
}

//   if [ ! -d "${barcode_dir}/${item}" ]; then
//    mkdir -p "${barcode_dir}/${item}"

//cp "${currDir}/${params.output_dir}/dorado_barcoder/${params.kit_name}_${item}.fastq" "${barcode_dir}/${item}"
//mv ${currDir}/${params.output_dir}/dorado_barcoder/${params.kit_name}_${item}.fastq ${barcode_dir}/${item}/
