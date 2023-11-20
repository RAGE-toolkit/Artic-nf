
nextflow.enable.dsl=2

def currDir = System.getProperty("user.dir")

def res_dir = new File("${currDir}/${params.output_dir}/concatenate")
if (!res_dir.exists()) {
        res_dir.mkdirs()
}

process concat {

	publishDir "${currDir}/${params.output_dir}/concatenate"

	input:
	val "medaka_dir"

	output:
	val "genome.fasta", emit: genome_fa

	script:
	"""
	python ${currDir}/${params.script}/concat_seq.py \
		-d ${currDir}/${params.output_dir}/${medaka_dir} \
		-m consensus.fasta \
		-o ${currDir}/${params.output_dir}/concatenate/ -f "genome.fasta"
	"""
}
