//guppy_plex.nf

nextflow.enable.dsl=2

def currDir = System.getProperty("user.dir");

script_path = "${currDir}/scripts/directory_plex.py"
process PLEX_DIRS {

	conda 'envs/biopython.yml'

	label 'plex_dirs'

	publishDir "${currDir}/${params.fastq_dir}", mode: 'copy'

	input:
	val input_dir
	tuple val(sample_id), val(item), val(scheme), val(version)
	
	output:
	val "${params.fastq_dir}", emit: fastq

	script:

	"""
	python $script_path \
		--skip_quality_check \
		-min ${params.seq_len} \
		-d ${input_dir}/${item} \
		-o "${currDir}/${params.fastq_dir}/${sample_id}_${item}${params.fq_extension}"
	"""
}
