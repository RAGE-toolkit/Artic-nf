//guppy_plex.nf

nextflow.enable.dsl=2

import java.io.File

def currDir = System.getProperty("user.dir")

// checking if the guppyplex directory exist or not
def guppyDir = "guppyplex"

if (!new File("$currDir/${params.output_dir}/$guppyDir").exists()) {
  new File("$currDir/${params.output_dir}/$guppyDir").mkdirs()
}

/*

// listing all the dirs inside fastq folder
def barcodes = []; // all the barcode dirs stored here
def folder = "${currDir}/${params.output_dir}/fastq"
def baseDir = new File(folder);
files = baseDir.listFiles();
def pattern = /barcode\d+/

for (item in files) {
	if (item.toString().find(pattern)){
			barcodes.add(item)
		}
	}

print (barcodes)

*/

process guppy_plex {

	input:
	path item
	val extension
	
	script:
	"""
	artic guppyplex --skip-quality-check \
		--min-length 350 \
		--directory $currDir/${params.output_dir}/fastq/$item \
		--output $currDir/${params.output_dir}/"guppyplex"/$item${extension}
	"""
}

/*
barcode_ch = Channel.fromPath(barcodes)
workflow {
	extension = ".fastq"
	guppy_plex(barcode_ch, extension)
}
*/
