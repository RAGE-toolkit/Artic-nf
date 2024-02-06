nextflow.enable.dsl=2

def currDir = System.getProperty("user.dir")

//checking if output dir exists
def res_dir = new File("${currDir}/${params.output_dir}/summary_stats")
if (!res_dir.exists()) {
        res_dir.mkdirs()
}

weeSAM_path = "${params.weeSAM}/weeSAM"

process SUMMARY_STATS {

	label "dorado_basecaller"

	publishDir "${currDir}/${params.output_dir}/summary_stats/", mode: 'copy'
	
	input:
	val item

	output:
	val "${item}.summary.txt", emit: summary 
	val "${currDir}/${params.output_dir}/medaka", emit: summary_dir

	script:
	"""
	$weeSAM_path --overwrite --bam ${currDir}/${params.output_dir}/${item} --out "${currDir}/${params.output_dir}/${item}.summary.txt"   
	"""
}


