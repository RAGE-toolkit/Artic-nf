//guppy_basecaller.nf

nextflow.enable.dsl=2

def currDir = System.getProperty("user.dir");

def guppy_path = "${params.guppy_dir}/bin/guppy_basecaller"

process GUPPY_BASECALLER {

	label "guppy_basecaller"

	publishDir "${currDir}/${params.output_dir}", mode: 'copy'

	input:
	path fast5_dir

	output:
	path "guppy_basecaller"

	script:
	"""
	${guppy_path} --recursive \
		-c ${params.guppy_config} \
		-i ${fast5_dir} \
		-s "guppy_basecaller"
	"""
//-x ${params.guppy_run_mode}
}
