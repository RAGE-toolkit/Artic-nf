//guppy_basecaller.nf

nextflow.enable.dsl=2

def currDir = System.getProperty("user.dir");

def res_dir = new File("${currDir}/${params.output_dir}/dorado_basecaller")
if (!res_dir.exists()) {
        res_dir.mkdirs()
}

def dorado_path = "${params.dorado_dir}/bin/dorado"
def model_dir 	= "${params.dorado_dir}/model"

process DORADO_BASECALLER {

	label "dorado_basecaller"

	publishDir "${currDir}/${params.output_dir}/dorado_basecaller/", mode: 'copy'

	input:
	path fast5_or_pod5_dir

	output:
	path "calls.fastq", emit: fastq

	script:
	"""
	${dorado_path} basecaller -r \
		${model_dir}/${params.dorado_config} \
		-x ${params.dorado_run_mode} \
		--emit-fastq \
		${fast5_or_pod5_dir} \
		 > "calls.fastq"
	"""
}
