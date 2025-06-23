//summary_stats.nf

nextflow.enable.dsl=2

def currDir = System.getProperty("user.dir")

//checking if output dir exists
def res_dir = new File("${currDir}/${params.output_dir}/report")
if (!res_dir.exists()) {
        res_dir.mkdirs()
}

report_path = "${currDir}/scripts/report.py"

process REPORT {

	//conda 'envs/datamash.yml'

	label "report"

	publishDir "${currDir}/${params.output_dir}/report/", mode: 'copy'
	
	input:
	path summary_file 

	output:
	val "combined_summary_report.html", emit: report 

	script:
	"""
	python ${report_path} --alignreport_dir ${currDir}/${params.output_dir}/medaka --summary_stats_file $summary_file --output_dir ${currDir}/${params.output_dir}/report    """
}


