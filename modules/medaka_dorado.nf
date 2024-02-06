//medaka.nf

nextflow.enable.dsl=2

def currDir = System.getProperty("user.dir")

//checking if medaka dir exists
def medaka_dir = new File("${currDir}/${params.output_dir}/medaka")
if (!medaka_dir.exists()) {
        medaka_dir.mkdirs()
}

meta_file = "$currDir/${params.meta_file}";

def hash = [:].withDefault { [] }

new File(meta_file).eachLine { line ->
    def (key, values) = line.split(',', 2)
    hash[key] << values
}

process MEDAKA_DORADO{

	publishDir "${currDir}/${params.output_dir}", mode: 'copy'

	input:
	val input_dir
	tuple val(sampleId), val(item), val(scheme), val(version)

	output:
	val "medaka/${sampleId}", emit: consensus
	val "medaka/${sampleId}.sorted.bam", emit: bam
 
	script:
	"""
	artic minion --medaka \
		--medaka-model ${params.medaka_model} \
		--normalise ${params.medaka_normalise} \
		--threads ${params.threads} \
		--scheme-directory ${params.primer_schema} \
		--no-frameshifts	\
		--no-indels	\
		--read-file ${currDir}/${params.fastq_dir}/${sampleId}_${item}${params.fq_extension} \
		${scheme}/${version} ${currDir}/${params.output_dir}/medaka/${sampleId}
	"""
	// {params.scheme} medaka/{wildcards.sample}
}
