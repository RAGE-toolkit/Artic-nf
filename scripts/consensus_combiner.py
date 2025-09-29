import argparse
from pathlib import Path
from Bio import SeqIO


class ConsensusCombiner:
    def __init__(self, run_name, input_dir: str, output_file: str = "combined_consensus.fasta"):
        self.input_dir = Path(input_dir)
        self.output_file = output_file
        self.run_name = run_name

    def combine(self):
        fasta_files = sorted(self.input_dir.glob("*.consensus.fasta"))
        if not fasta_files:
            print(f"No *.consensus.fasta files found in {self.input_dir}")
            return

        all_records = []
        for fasta_file in fasta_files:
            for record in SeqIO.parse(fasta_file, "fasta"):
                # Clean header to retain only the first word (e.g., 'foo_2024')
                record.id = record.description.split()[0]
                record.name = self.run_name + "_" + record.id
                record.description = ""
                all_records.append(record)

        SeqIO.write(all_records, self.output_file, "fasta")
        print(f"Combined {len(all_records)} sequences into {self.output_file}")


def main():
    parser = argparse.ArgumentParser(description="Combine *.consensus.fasta files into one FASTA file with cleaned headers.")
    parser.add_argument("input_dir", help="Directory containing *.consensus.fasta files")
    parser.add_argument("-o", "--output", default="combined_consensus.fasta",
                        help="Output file name (default: combined_consensus.fasta)")
    parser.add_argument("-r", "--run_name", default="test_run", help="run name of the experiment")
    args = parser.parse_args()

    combiner = ConsensusCombiner(args.run_name, args.input_dir, args.output)
    combiner.combine()


if __name__ == "__main__":
    main()

