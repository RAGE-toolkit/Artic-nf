//guppy_basecaller.nf

nextflow.enable.dsl=2

def currDir = System.getProperty("user.dir");

def dorado_path = "${params.dorado_dir}/bin/dorado"
def model_dir 	= "${params.dorado_dir}/model"

process DORADO_BARCODER {

	label "dorado_basecaller"

	publishDir "${currDir}/${params.output_dir}/", mode: 'copy'

	input:
	path fastq_file

	output:
	path "dorado_barcoder", emit: barcoding 

	script:
	"""
	${dorado_path} demux --kit-name ${params.kit_name} --emit-fastq --output-dir "dorado_barcoder" ${fastq_file}
	"""
}
