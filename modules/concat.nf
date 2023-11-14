
nextflow.enable.dsl=2

def currDir = System.getProperty("user.dir")

res_dirs = []

def folder = "${currDir}/${params.output_dir}/medaka/";
def baseDir = new File(folder);
files = baseDir.listFiles();
def cons = "consensus.fasta"

// creating a empty concatinate dir
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

        script:
        """
	cat ${cons_files} > ${concat_res_dir}/genome.fasta
        """
}



workflow {
        concat()
}
