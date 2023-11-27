//medaka.nf

nextflow.enable.dsl=2

def currDir = System.getProperty("user.dir")

//checking if medaka dir exists
def medaka_dir = new File("${currDir}/${params.output_dir}/medaka")
if (!medaka_dir.exists()) {
        medaka_dir.mkdirs()
}


process MEDAKA {

	publishDir "${currDir}/${params.output_dir}", mode: 'copy'

	input:
	val input_dir
	tuple val(sampleId), val(item), val(scheme), val(version)

	output:
	val "medaka/${sampleId}", emit: consensus
 
	script:
	"""
	artic minion --medaka \
		--medaka-model ${params.medaka_model} \
		--normalise ${params.medaka_normalise} \
		--threads ${params.threads} \
		--scheme-directory ${params.primer_schema} \
		--read-file ${currDir}/${input_dir}/${sampleId}_${item}${params.fq_extension} \
		${scheme}/${version} ${currDir}/${params.output_dir}/medaka/${sampleId}
	"""
	// {params.scheme} medaka/{wildcards.sample}
}
