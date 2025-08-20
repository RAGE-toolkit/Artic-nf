//fasta_header.nf

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

fasta_header = "${currDir}/scripts/fasta_header.py"

process FASTA_HEADER {

	errorStrategy 'ignore'

	//conda 'envs/pyvcf.yml'

	publishDir "${currDir}/${params.output_dir}", mode: 'copy'

	input:
	val input_vcf
	tuple val(sampleId), val(item), val(scheme), val(version)

	output:
	val "medaka/${sampleId}.consensus.fasta", emit: fasta
	
	script:
	"""
	set -e
	(
		python ${fasta_header} ${currDir}/${params.output_dir}/medaka/${params.run_name}_${sampleId}.consensus.fasta ${sampleId} ) || echo "fasta-header" "${sampleId}" >> ${currDir}/${params.output_dir}/medaka/failed_samples.txt
	"""
	}
