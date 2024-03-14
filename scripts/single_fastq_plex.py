'''The code has been refered and modified from fieldbioinformatics
	 https://github.com/artic-network/fieldbioinformatics/blob/master/artic/guppyplex.py
'''

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
from argparse import ArgumentParser

def get_read_mean_quality(record):
    return -10 * log10((10 ** (pd.Series(record.letter_annotations["phred_quality"]) / -10)).mean())

def run(args):
	outfh = open(args.output, "w")
	dups = set()
	fn = args.input_fq
	encoding = guess_type(fn)[1]
	_open = open
	print (encoding)
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

if __name__ == "__main__":
	parser = ArgumentParser(description='Plex individual fastq files')
	parser.add_argument('-i', '--input_fq', required=True, help='Input fastq file')
	parser.add_argument('-o', '--output', help='Output file name. If not specified, it will be generated based on the directory name and prefix')
	parser.add_argument('-max', '--max_length', type=int, help='Maximum read length')
	parser.add_argument('-min', '--min_length', type=int, help='Minimum read length')
	parser.add_argument('-q', '--quality', type=float, default=7, help='Minimum mean read quality. Reads with a mean quality below this will be skipped. Default is 20')
	parser.add_argument('-s', '--sample', type=float, default=1, help='Sampling rate for reads. A value of 1 means all reads are processed, less than 1 means a subset of reads are processed. Default is 1')
	parser.add_argument('--skip_quality_check', action='store_true', help='Skip the quality check step. By default, quality check is performed')
	args = parser.parse_args()
	run(args)
