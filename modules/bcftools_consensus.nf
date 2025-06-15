//bcftools_consensus.nf

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

def osName = System.getProperty("os.name").toLowerCase()

process BCFTOOLS_CONSENSUS {

	errorStrategy 'ignore'
	
	if (osName.contains("linux")) {
			//conda 'envs/medaka.yml'
		}

	publishDir "${currDir}/${params.output_dir}", mode: 'copy'

	input:
	val input_vcf
	tuple val(sampleId), val(item), val(scheme), val(version)

	output:
	val "medaka/${sampleId}.consensus.fasta", emit: consensus_fa
	
	script:
	"""
	set -e
	(
		bcftools consensus -f ${currDir}/${params.output_dir}/medaka/${sampleId}.preconsensus.fasta \
		${currDir}/${params.output_dir}/medaka/${sampleId}.pass.vcf.gz \
		-m ${currDir}/${params.output_dir}/medaka/${sampleId}.coverage_mask.txt \
		-o ${currDir}/${params.output_dir}/medaka/${sampleId}.consensus.fasta ) || echo "bcftools-consensus" "${sampleId}" >> ${currDir}/${params.output_dir}/medaka/failed_samples.txt
	"""
	}
