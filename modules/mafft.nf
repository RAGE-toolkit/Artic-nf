nextflow.enable.dsl=2

def currDir = System.getProperty("user.dir")

//checking if output dir exists
def res_dir = new File("${currDir}/${params.output_dir}/mafft")
if (!res_dir.exists()) {
        res_dir.mkdirs()
}

process MAFFT {

	conda 'envs/mafft.yml'

	publishDir "${currDir}/${params.output_dir}/mafft/", mode: 'copy'
	
	input:
	val concat_fa
	
	output:
	val "genome-aln.fasta", emit: mafft_fa

	script:
	"""
	mafft ${currDir}/${params.output_dir}/concatenate/*.fasta \
	> ${currDir}/${params.output_dir}/mafft/genome-aln.fasta
	"""
}
