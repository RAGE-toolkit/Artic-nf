
nextflow.enable.dsl=2

def currDir = System.getProperty("user.dir")

/*
res_dirs = []

def folder = "${currDir}/${params.output_dir}/medaka/";
def baseDir = new File(folder);
files = baseDir.listFiles().name;
def cons = "consensus.fasta"
println(files);

// creating an empty concat dir
def concat_dir = "${currDir}/${params.output_dir}/concat/"
def concat_res_dir = new File(concat_dir)
concat_res_dir.mkdirs()

for (item in files) {
	tmp_var = "${item}/${cons}"
	res_dirs.add(tmp_var)
        }

def cons_files = res_dirs.join(' ')
println(cons_files)

process concat {

		
	output:
	path "genome.fasta", emit: conses

        script:
        """
	echo "${cons_files}"
	cat ${cons_files} > ${concat_res_dir}/genome.fasta
        """
}
*/

process concat {

	publishDir "${currDir}/${params.output_dir}/concatinate"

	input:
	path "medaka_dir"

	output:
	path "concatinate/genome.fasta", emit: consens

	script:
	"""
	python ${params.scripts}/concat_seq.py -i medaka_dir -m consensus.fasta -o "${currDir}/${params.output_dir}/concatinate/genome.fasta"
	"""
	

/*
workflow {
        concat().out.view()
}
*/
