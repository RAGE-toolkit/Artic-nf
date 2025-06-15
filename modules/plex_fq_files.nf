//plex_fq_files.nf

nextflow.enable.dsl=2

def currDir = System.getProperty("user.dir");

script_path = "${currDir}/scripts/single_fastq_plex.py"
process PLEX_FQ_FILES {

	//conda 'envs/biopython.yml'

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
		-i ${input_dir}/${params.kit_name}_${item}${params.fq_extension} \
		-o "${currDir}/${params.fastq_dir}/${sample_id}_${item}${params.fq_extension}"
	"""
}
