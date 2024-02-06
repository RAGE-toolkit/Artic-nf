nextflow.enable.dsl=2

def currDir = System.getProperty("user.dir")

//checking if output dir exists
def res_dir = new File("${currDir}/${params.output_dir}/mafft")
if (!res_dir.exists()) {
        res_dir.mkdirs()
}

// creating mafft output dir
def mafft_dir = "${currDir}/${params.output_dir}/mafft/"
def mafft_res_dir = new File(mafft_dir)
mafft_res_dir.mkdirs()

process MAFFT {
	
	input:
	val item

	script:
	"""
	echo "mafft ${currDir}/${params.output_dir}/concatenate/${item} > ${mafft_res_dir}/genome-aln.fasta"
	mafft ${currDir}/${params.output_dir}/concatenate/${item} > ${mafft_res_dir}/genome-aln.fasta
	"""
}

/*
fa_channel = Channel.fromPath("${currDir}/${params.output_dir}/concat/genome.fasta")
workflow {
	mafft_aln(fa_channel)
}
*/

