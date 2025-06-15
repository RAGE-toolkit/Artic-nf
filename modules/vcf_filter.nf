//vcf_filter.nf

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

vcf_filter = "${currDir}/scripts/vcf_filter.py"

process VCF_FILTER {

	errorStrategy 'ignore'

	//conda 'envs/tabix.yml'

	publishDir "${currDir}/${params.output_dir}", mode: 'copy'

	input:
	val input_vcf
	tuple val(sampleId), val(item), val(scheme), val(version)

	output:
	val "medaka/${sampleId}.pass.vcf", emit: pass_vcf
	val "medaka/${sampleId}.fail.vcf", emit: fail_vcf
	
	script:
	"""
	set -e
	(
		python ${vcf_filter} \
		--medaka \
		${currDir}/${params.output_dir}/medaka/${sampleId}.merged.vcf \
		${currDir}/${params.output_dir}/medaka/${sampleId}.pass.vcf \
		${currDir}/${params.output_dir}/medaka/${sampleId}.fail.vcf \
		&& bgzip -f ${currDir}/${params.output_dir}/medaka/${sampleId}.pass.vcf \
		&& tabix -p vcf ${currDir}/${params.output_dir}/medaka/${sampleId}.pass.vcf.gz ) || echo "vcf_filter" "${sampleId}" >> ${currDir}/${params.output_dir}/medaka/failed_samples.txt
	"""
	}
