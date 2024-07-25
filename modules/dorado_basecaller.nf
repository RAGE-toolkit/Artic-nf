//dorado_basecaller.nf

nextflow.enable.dsl=2

def currDir = System.getProperty("user.dir");

def res_dir = new File("${currDir}/${params.output_dir}/dorado_basecaller")
if (!res_dir.exists()) {
        res_dir.mkdirs()
}

def default_dorado_path	= "${params.dorado_dir}/bin/dorado"
def default_model_dir	= "${params.dorado_dir}/model"
 
def isDoradoAvailable() {
	def process = 'which dorado'.execute()
	process.waitFor()
	return process.exitValue() == 0
	}

def isDoradoModelAvailable() {
	def process = ['/bin/bash', '-c', 'source ~/.bashrc && echo $dorado_model'].execute()
	process.waitFor()
	def output = process.text.trim()
	return output ? output : null
	}

def dorado_executable = isDoradoAvailable() ? 'dorado' : default_dorado_path
def model_dir = isDoradoModelAvailable() ?: default_model_dir

process DORADO_BASECALLER {

	label "dorado_basecaller"

	publishDir "${currDir}/${params.output_dir}/dorado_basecaller/", mode: 'copy'

	input:
	path fast5_or_pod5_dir

	output:
	path "calls.fastq", emit: fastq

	script:
	"""
	${dorado_executable} basecaller -r \
		${model_dir}/${params.dorado_config} \
		-x ${params.dorado_run_mode} \
		--emit-fastq \
		${fast5_or_pod5_dir} \
		 > "calls.fastq"
	"""
}
