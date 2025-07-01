# Apply rampart_json_functions code

source("rampart_json_functions.R")

# Create primers JSON from BED file
bed_to_amplicons_json("../../meta_data/primer-schemes/EA_2024/V1/EA_2024.scheme.bed", 
                       "EA_2024 rabies virus primer scheme", "outputs/EA_2024_primers.json")

# Create genome JSON from reference FASTA
create_genome_json("../../meta_data/primer-schemes/EA_2024/V1/EA_2024.reference.fasta", 
                 "outputs/EA_2024_genome.json", "EA_2024")
