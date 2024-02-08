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

	write_file.write('\t'.join(header) + '\ni')
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

'''
for bam in bam_files:
    dirname = os.path.dirname(bam)
    runnametest = os.path.dirname(dirname)
    path = run_shell_command(f"realpath {bam} | sed 's/ //g'")
    runname = run_shell_command(f"echo {runnametest} | sed -e 's/NB..//' -e 's/\///g' -e 's/\.//g'")
    if not runname:
        runname = os.path.basename(os.path.normpath(run_shell_command(f"cd {dirname} && pwd")))
    stub = os.path.basename(bam).replace('.sorted.bam', '')
    fasta = run_shell_command(f"find . -name '{stub}*.consensus.fasta'")
    # Create depthFiles directory
    os.makedirs(f"{os.path.basename(os.getcwd())}_depthFiles", exist_ok=True)
    # Summary of mapped reads
    reads = run_shell_command(f"samtools view {bam} | cut -f 1 | sort | uniq | wc -l")
    mapped = run_shell_command(f"samtools view -F 4 {bam} | cut -f 1 | sort | uniq | wc -l")
    mean = run_shell_command(f"samtools depth -d 500000 -a {bam} | datamash mean 3 sstdev 3 median 3 min 3 max 3")
    basesCovered = run_shell_command(f"samtools depth {bam} | awk '($3>0)' | wc -l")
    basesCoveredx5 = run_shell_command(f"samtools depth {bam} | awk '($3>=5)' | wc -l")
    basesCoveredx20 = run_shell_command(f"samtools depth {bam} | awk '($3>=20)' | wc -l")
    basesCoveredx100 = run_shell_command(f"samtools depth {bam} | awk '($3>=100)' | wc -l")
    basesCoveredx200 = run_shell_command(f"samtools depth {bam} | awk '($3>=200)' | wc -l")
    count = run_shell_command(f"fgrep -o N {fasta} | wc -l")
    if count == "0":
        count = "11923"
    nonMaskedConsensusCov = str(11923 - int(count))
    # Append to temp.txt, later to create and modify _mappingStats.txt
    with open('temp.txt', 'a') as file:
        file.write(f"{runname} {stub} {reads} {mapped} {mean} {basesCovered} {basesCoveredx5} {basesCoveredx20} {basesCoveredx100} {basesCoveredx200} {nonMaskedConsensusCov} {path}\n")
    # Create _mappingStats.txt and modify it
    with open(f'{runname}_mappingStats.txt', 'w') as stats_file:
        header = 'runname sample_id total_reads mapped_reads meanReads sd_reads median_reads min_reads max_reads basesCovered_1 basesCovered_5 basesCovered_20 basesCovered_100 basesCovered_200 nonMaskedConsensusCov filepath\n'
        with open('temp.txt', 'r') as temp_file:
            stats_content = temp_file.read()
        stats_file.write(header + stats_content)
    run_shell_command(f"sed -i -e 's/ /\t/g' {runname}_mappingStats.txt")
    # Depth of cov per base
    depth_file_path = f"{os.path.basename(os.getcwd())}_depthFiles/{stub}_{runname}_depth.txt"
    if not os.path.exists(depth_file_path):
        run_shell_command(f"samtools depth -a {bam} -d 500000 > {depth_file_path}")

os.remove('temp.txt')
'''
