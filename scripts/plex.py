import sys
from Bio import SeqIO
import tempfile
import os
import glob
import gzip
import fnmatch
import shutil
import pandas as pd
import pyarrow
from collections import defaultdict
from mimetypes import guess_type
from functools import partial
from math import log10
from random import random

def get_read_mean_quality(record):
    return -10 * log10((10 ** (pd.Series(record.letter_annotations["phred_quality"]) / -10)).mean())

def run(args):
	outfh = open(args.output_file, "w")
	dups = set()
	fastq_files = [args.input_file]
	for fn in fastq_files:
		encoding = guess_type(fn)[1]
		_open = open
		if encoding == "gzip":
			_open = partial(gzip.open, mode="rt")
			with _open(fn) as f:
				try:
					for rec in SeqIO.parse(f, "fastq"):
						if args.max_length and len(rec) > args.max_length:
							continue
						if args.min_length and len(rec) < args.min_length:
							continue
						if not args.skip_quality_check and get_read_mean_quality(rec) < args.quality:
							continue
						if args.sample < 1:
								r = random()
						if r >= args.sample:
							continue
						if rec.id not in dups:
							SeqIO.write([rec], outfh, "fastq")
							dups.add(rec.id)
				except ValueError:
					pass
	outfh.close()
	print(f"{fastq_outfn}\t{len(dups)}")

if __name__ == "__main__":
	print ("Plexing ..................\n")
	parser = ArgumentParser(description='Plex')
	parser.add_argument('-m', '--input_dir', help='input directory', required=True)
	parser.add_argument('-o', '--output_file', help='output file name', required=True)
	args = parser.parse_args()
	run(args)
