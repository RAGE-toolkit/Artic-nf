//guppy_plex.nf

nextflow.enable.dsl=2

import java.io.File

def currDir = System.getProperty("user.dir");

meta_file = "$currDir/${params.meta_file}";

/*
fq_channel = channel
        .fromPath(meta_file)
        .splitCsv(header: true, sep: "\t")
        .map { row -> tuple(row.sampleId, row.barcode, row.scheme) }
*/
process guppy_plex {

	publishDir "${currDir}/${params.output_dir}/guppyplex/"

	input:
	path input_dir
	tuple val(sample_id), val(item)
	val extension
	
	output:
	path "${item}${extension}", emit: fastq

	script:
	"""
	artic guppyplex \
		--skip-quality-check \
		--min-length 350 \
		--directory $input_dir/$item \
		--output "${item}${extension}"
	"""
//--output "${item}${extension}"
}

/*
workflow {
	guppy_plex("/export/home4/sk312p/projects/artic_nf_combine/results/fastq", fq_channel, ".fastq")
}
*/




