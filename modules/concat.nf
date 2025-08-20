
nextflow.enable.dsl=2

def currDir = System.getProperty("user.dir")

def res_dir = new File("${currDir}/${params.output_dir}/concatenate")
if (!res_dir.exists()) {
        res_dir.mkdirs()
}
script_path = "${currDir}/scripts/consensus_combiner.py"

process CONCAT {

	//conda 'envs/pyvcf.yml'

	publishDir "${currDir}/${params.output_dir}/concatenate"

	input:
	val "consensus_seqs"

	output:
	val "concat_genome.fasta", emit: genome_fa

	script:
	"""
	python ${script_path}  ${currDir}/${params.output_dir}/medaka/ -o ${currDir}/${params.output_dir}/concatenate/concat_genome.fasta 
	#cat ${currDir}/${params.output_dir}/medaka/*.consensus.fasta >> "${currDir}/${params.output_dir}/concatenate/concat_genome.fasta"
	"""	
}
