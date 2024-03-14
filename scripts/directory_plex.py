'''The code has been refered and modified from fieldbioinformatics
   https://github.com/artic-network/fieldbioinformatics/blob/master/artic/guppyplex.py
'''

import argparse
import sys
from Bio import SeqIO
import tempfile
import os
import glob
import gzip
import fnmatch
import shutil
import pandas as pd
from collections import defaultdict
from mimetypes import guess_type
from functools import partial
from math import log10
from random import random

def get_read_mean_quality(record):
    return -10 * log10((10 ** (pd.Series(record.letter_annotations["phred_quality"]) / -10)).mean())

def run(parser, args):
    files = os.listdir(args.directory)
    fastq_files = [os.path.join(args.directory, f) for f in files if fnmatch.fnmatch(f, '*.fastq*') and not f.endswith('.temp')]

    if fastq_files:
        if not args.output:
            fastq_outfn = "%s_%s.fastq" % (args.prefix, os.path.basename(args.directory))
        else:
            fastq_outfn = args.output

        outfh = open(fastq_outfn, "w")
        print("Processing %s files in %s" % (len(fastq_files), args.directory), file=sys.stderr)

        dups = set()

        for fn in fastq_files:
            encoding = guess_type(fn)[1]
            _open = open
            # only accommodating gzip compression at present
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

def main():
    parser = argparse.ArgumentParser(description="Process guppy-demultiplexed data, integrating functionalities from 'gather' and 'demultiplex' tasks, optimized for workflows utilizing Medaka. It supports gzipped FASTQ files and includes basic QC metrics.")
    
    parser.add_argument('-d', '--directory', required=True, help='Directory containing FASTQ files.')
    parser.add_argument('-o', '--output', help='Output file name. If not specified, it will be generated based on the directory name and prefix.')
    parser.add_argument('-p', '--prefix', default='output', help='Prefix for the output file name')
    parser.add_argument('-max', '--max_length', type=int, help='Maximum read length. Reads longer than this will be skipped.')
    parser.add_argument('-min', '--min_length', type=int, help='Minimum read length. Reads shorter than this will be skipped.')
    parser.add_argument('-q', '--quality', type=float, default=20, help='Minimum mean read quality. Reads with a mean quality below this will be skipped. Default is 20.')
    parser.add_argument('-s', '--sample', type=float, default=1, help='Sampling rate for reads. A value of 1 means all reads are processed, less than 1 means a subset of reads are processed. Default is 1.')
    parser.add_argument('--skip_quality_check', action='store_true', help='Skip the quality check step. By default, quality check is performed.')
    
    args = parser.parse_args()
    run(parser, args)

if __name__ == "__main__":
    main()

