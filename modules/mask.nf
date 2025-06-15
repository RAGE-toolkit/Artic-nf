//mask.nf

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

mask = "${currDir}/scripts/mask.py"

process MASK {

	errorStrategy 'ignore'
	//conda 'envs/pyvcf.yml'

	publishDir "${currDir}/${params.output_dir}", mode: 'copy'

	input:
	val input_vcf
	tuple val(sampleId), val(item), val(scheme), val(version)

	output:
	val "medaka/${sampleId}.preconsensus.fasta", emit: preconsensus
	
	script:
	"""
	set -e
	(
		python ${mask} ${params.primer_schema}/${scheme}/${version}/${scheme}.reference.fasta \
		${currDir}/${params.output_dir}/medaka/${sampleId}.coverage_mask.txt \
		${currDir}/${params.output_dir}/medaka/${sampleId}.fail.vcf \
		${currDir}/${params.output_dir}/medaka/${sampleId}.preconsensus.fasta ) || echo "mask" "${sampleId}" >> ${currDir}/${params.output_dir}/medaka/failed_samples.txt
	"""
	}
