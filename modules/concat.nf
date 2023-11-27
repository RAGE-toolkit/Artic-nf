
nextflow.enable.dsl=2

def currDir = System.getProperty("user.dir")

def res_dir = new File("${currDir}/${params.output_dir}/concatenate")
if (!res_dir.exists()) {
        res_dir.mkdirs()
}

process CONCAT {

	publishDir "${currDir}/${params.output_dir}/concatenate"

	input:
	val "medaka_dir"

	output:
	val "concat_genome.fasta", emit: genome_fa

	script:
	"""
	cat ${currDir}/${params.output_dir}/${medaka_dir}.consensus.fasta >> "${currDir}/${params.output_dir}/concatenate/concat_genome.fasta"
	"""	

/*	"""
	python ${currDir}/${params.script}/concat_seq.py \
		-d ${currDir}/${params.output_dir}/${medaka_dir} \
		-o ${currDir}/${params.output_dir}/concatenate/ -f "genome.fasta"
	"""
*/
}
