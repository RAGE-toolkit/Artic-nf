//muscle.nf

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

process MUSCLE {

	maxForks 1

	conda 'envs/muscle.yml'

	publishDir "${currDir}/${params.output_dir}", mode: 'copy'

	input:
	val input_vcf
	tuple val(sampleId), val(item), val(scheme), val(version)

	output:
	val "medaka/${sampleId}.muscle.out.fasta", emit: muscle_op_fasta
	
	script:
	"""
	muscle -align ${currDir}/${params.output_dir}/medaka/${sampleId}.muscle.in.fasta \
-output ${currDir}/${params.output_dir}/medaka/${sampleId}.muscle.out.fasta
	"""
	}
