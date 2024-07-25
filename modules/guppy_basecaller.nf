//guppy_basecaller.nf

nextflow.enable.dsl=2

def currDir = System.getProperty("user.dir");

def default_guppy_basecaller_path = "${params.guppy_dir}/bin/guppy_basecaller"
def default_guppy_model_path = "${params.guppy_dir}/data"

def isGuppyBasecallerAvailable() {
  def process = ['/bin/bash', '-c', 'source ~/.bashrc && echo $GUPPY_BASECALLER'].execute()
  process.waitFor()
  def output = process.text.trim()
  return output ? output : null
  }

def isGuppyModelAvailable() {
  def process = ['/bin/bash', '-c', 'source ~/.bashrc && echo $GUPPY_MODEL'].execute()
  process.waitFor()
  def output = process.text.trim()
  return output ? output : null
  }

def guppy_basecaller_executable = isGuppyBasecallerAvailable() ?: default_guppy_basecaller_path
def guppy_model_dir = isGuppyModelAvailable() ?: default_guppy_model_path

process GUPPY_BASECALLER {

	label "guppy_basecaller"

	publishDir "${currDir}/${params.output_dir}", mode: 'copy'

	input:
	path fast5_dir

	output:
	path "guppy_basecaller"

	script:
	"""
	${guppy_basecaller_executable} --recursive \
		-c ${guppy_model_dir}/${params.guppy_config} \
		-i ${fast5_dir} \
		-s "guppy_basecaller" \
		-x ${params.guppy_run_mode}
	"""
}

