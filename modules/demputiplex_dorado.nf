//guppy_plex.nf

nextflow.enable.dsl=2

def currDir = System.getProperty("user.dir");

process DEMULTIPLEX_DORADO {

	label 'guppyplex'

	publishDir "${currDir}/${params.fastq_dir}", mode: 'copy'

	input:
	val input_dir
	tuple val(sample_id), val(item), val(scheme), val(version)
	
	output:
	val "${params.fastq_dir}", emit: fastq

	script:
	"""
	artic guppyplex \
		--skip-quality-check \
		--min-length ${params.guppy_seq_len} \
		--directory ${input_dir}/ \
		--output "${currDir}/${params.fastq_dir}/${sample_id}_${item}${params.fq_extension}"
	"""
}
