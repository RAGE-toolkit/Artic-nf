nextflow.enable.dsl=2

def currDir = System.getProperty("user.dir")

process medaka {

	input:
	path item
 
	script:
	"""
	medaka_consensus -i ${currDir}/${params.output_dir}/guppyplex/${item} \
		-d ${currDir}/${params.medaka_schema} \
		-m ${params.model} \
		-o ${currDir}/${params.output_dir}/${params.medaka_outputdir}/${item}
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

