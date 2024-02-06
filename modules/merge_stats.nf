nextflow.enable.dsl=2

def currDir = System.getProperty("user.dir")

//checking if output dir exists
def res_dir = new File("${currDir}/${params.output_dir}/summary_stats")
if (!res_dir.exists()) {
        res_dir.mkdirs()
}

script_path = "${currDir}/scripts/summary_stat.py"

process MERGE_SUMMARY_STATS {

	label "merge_summary_stats"

	publishDir "${currDir}/${params.output_dir}/summary_stats/", mode: 'copy'
	
	input:
	val item

	output:
	path "summary_stats.txt", emit: stats 

	script:
	"""
	python $script_path -i ${item} -o "summary_stats.txt"   
	"""
}


