//guppy_basecaller.nf

nextflow.enable.dsl=2

def currDir = System.getProperty("user.dir");
println(currDir);

process guppy_basecaller {

	publishDir "${currDir}/${params.output_dir}"

	input:
	path fast5_dir

	output:
	path "guppy_basecaller"

	script:
	"""
	$currDir/${params.guppy_dir}/guppy_basecaller --recursive \
		-c dna_r9.4.1_450bps_fast.cfg \
		-i ${fast5_dir}\
		-s "guppy_basecaller"
	"""
}

/*
workflow {

	chnl = Channel.fromPath("${currDir}/${params.fast5_dir}")
	guppy_basecaller(chnl)
	guppy_basecaller.out.view()
	
}
*/
