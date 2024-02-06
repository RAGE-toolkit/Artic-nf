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

process MOVE_FQ {

	label "move_fq_file_to_dir"

	publishDir "${currDir}/${params.output_dir}/dorado_barcoder/", mode: 'copy'

	input:
	val fq_dir
	tuple val(sample_id), val(item), val(scheme), val(version)	

	output:
	val "${currDir}/${params.output_dir}/dorado_barcoder", emit: move

	script:
	"""
	cp "${currDir}/${params.output_dir}/dorado_barcoder/${params.kit_name}_${item}.fastq" "${currDir}/${params.output_dir}/dorado_barcoder/${item}/"
	"""
}

//mv ${currDir}/${params.output_dir}/dorado_barcoder/${params.kit_name}_${item}.fastq ${barcode_dir}/${item}/
