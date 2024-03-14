//summary_stats.nf

nextflow.enable.dsl=2

def currDir = System.getProperty("user.dir")

//checking if output dir exists
def res_dir = new File("${currDir}/${params.output_dir}/summary_stats")
if (!res_dir.exists()) {
        res_dir.mkdirs()
}

summary_stat_path = "${currDir}/scripts/summary_stats.py"

process SUMMARY_STATS {

	conda 'envs/datamash.yml'

	label "summary_stats"

	publishDir "${currDir}/${params.output_dir}/summary_stats/", mode: 'copy'
	
	input:
	val item

	output:
	val "summary_stats.txt", emit: summary 

	script:
	"""
	python ${summary_stat_path} -i ${currDir}/${params.output_dir}/medaka -o "${currDir}/${params.output_dir}/summary_stats/summary_stats.txt"   
	"""
}


