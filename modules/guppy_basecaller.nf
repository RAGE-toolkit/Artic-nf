nextflow.enable.dsl=2

def currDir = System.getProperty("user.dir");
println(currDir);

process guppy_basecaller {

	input:
	path fast5_dir	

	script:
	"""
	$currDir/${params.guppy_dir}/guppy_basecaller --recursive \
		-c dna_r9.4.1_450bps_fast.cfg \
		-i ${fast5_dir}\
		-s $currDir/${params.output_dir}/"guppy_basecaller"
	"""
}

/*
workflow {

	chnl = Channel.fromPath("${currDir}/${params.fast5_dir}")
	guppy_basecaller(chnl)
}
*/
