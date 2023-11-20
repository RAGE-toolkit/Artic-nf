nextflow.enable.dsl=2

def currDir = System.getProperty("user.dir")

process medaka {

	publishDir "${currDir}/${params.output_dir}/${params.medaka_outputdir}"

	input:
	path input_dir
	tuple val(sampleid), val(item)
	val extension

	output:
	val "${params.medaka_outputdir}"
 
	script:
	"""
	medaka_consensus -i "${currDir}/${params.output_dir}/guppyplex/${item}${extension}" \
		-d ${currDir}/${params.medaka_schema} \
		-m ${params.model} \
		-o "${currDir}/${params.output_dir}/${params.medaka_outputdir}/${item}"
	"""
}

//--normalise ${params.normalize} \
//--threads ${params} \

//fq_channel = Channel.fromPath("${currDir}/${params.output_dir}/guppyplex/barcode*.fastq")

/*
workflow {
	medaka(fq_channel)
}
*/

