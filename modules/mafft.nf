nextflow.enable.dsl=2

def currDir = System.getProperty("user.dir")

// creating mafft output dir
def mafft_dir = "${currDir}/${params.output_dir}/mafft/"
def mafft_res_dir = new File(mafft_dir)
mafft_res_dir.mkdirs()

process MAFFT {
	
	input:
	val item
	script:
	"""
	mafft ${currDir}/${params.output_dir}/concatenate/${item} > ${mafft_res_dir}/genome-aln.fasta
	"""
}

/*
fa_channel = Channel.fromPath("${currDir}/${params.output_dir}/concat/genome.fasta")
workflow {
	mafft_aln(fa_channel)
}
*/

