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

process DORADO_DEMUX {

	label "dorado_basecaller"

	publishDir "${currDir}/${params.fastq_dir}/", mode: 'copy'

	input:
	path barcode_dir
	tuple val(sample_id), val(item), val(scheme), val(version)	

	output:
	path "${sample_id}_${item}.fastq", emit: rename

	script:
	"""
	cp ${barcode_dir}/${params.kit_name}_${item}.fastq ${sample_id}_${item}.fastq
	"""
}
