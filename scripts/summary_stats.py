import os
import subprocess
from argparse import ArgumentParser
from datetime import datetime
from collections import defaultdict
from os.path import join as join

def run_shell_command(command):
    return subprocess.check_output(command, shell=True).decode().strip()

# Find .sorted.bam files excluding *rg.sorted.bam

def process(args):
	dup_list = []
	write_file = open(args.output_file, 'w')
	header = ['sample_id', 'total_reads', 'mapped_reads', 'meanReads', \
						'sd_reads', 'median_reads', 'min_reads', 'max_reads', 'basesCovered_1', \
						'basesCovered_5', 'basesCovered_20', 'basesCovered_100', 'basesCovered_200', \
						'nonMaskedConsensusCov', 'filepath']

	write_file.write('\t'.join(header) + '\n')
	for each_sample in os.listdir(args.input_dir):
		sample_name = each_sample.split('.')[0]
		if sample_name not in dup_list:
			bam_file = sample_name + ".sorted.bam"
			consesus_file = sample_name + '.consensus.fasta'
			if os.path.exists(join(args.input_dir, bam_file)) and os.path.exists(join(args.input_dir, consesus_file)):
				dup_list.append(sample_name)

				tmp_bam = join(args.input_dir, bam_file)
				tmp_cons = join(args.input_dir, consesus_file)

				reads = run_shell_command(f"samtools view " + tmp_bam + " | cut -f 1 | wc -l")
				mapped = run_shell_command(f"samtools view -F 4 " + tmp_bam + " | cut -f 1 | sort | uniq | wc -l")
				mean = run_shell_command(f"samtools depth -d 500000 -a " + tmp_bam + " | datamash mean 3 sstdev 3 median 3 min 3 max 3")
				count = run_shell_command(f"fgrep -o N " + tmp_cons + " | wc -l")
				if count == "0":
					count = "11923"
				nonMaskedConsensusCov = str(11923 - int(count))
				basesCovered = run_shell_command(f"samtools depth " + tmp_bam + " | awk '($3>0)' | wc -l")
				basesCoveredx5 = run_shell_command(f"samtools depth " + tmp_bam + " | awk '($3>=5)' | wc -l")
				basesCoveredx20 = run_shell_command(f"samtools depth " + tmp_bam + " | awk '($3>=20)' | wc -l")
				basesCoveredx100 = run_shell_command(f"samtools depth " + tmp_bam + " | awk '($3>=100)' | wc -l")
				basesCoveredx200 = run_shell_command(f"samtools depth " + tmp_bam + " | awk '($3>=200)' | wc -l")

				contents = [sample_name, reads, mapped, mean, basesCovered, basesCoveredx5, \
									basesCoveredx20, basesCoveredx100, basesCoveredx200, nonMaskedConsensusCov, \
									join(args.input_dir, bam_file)]

				write_file.write('\t'.join(contents) + '\n')

	write_file.close()
			
if __name__ == "__main__":
  print ("Plexing ..................\n")
  parser = ArgumentParser(description='Summary stat generation for sorted (BAM) files')
  parser.add_argument('-i', '--input_dir', help='input directory', required=True)
  parser.add_argument('-o', '--output_file', help='output file name', required=True)
  args = parser.parse_args()
  process(args)

