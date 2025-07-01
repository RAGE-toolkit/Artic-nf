
# Scripts to produce json files for RAMPART
# Written by: Kirstyn Brunker
# Date: 19 Jun 2025

# Input: Uses files produced by primal scheme as input
# Output: primer.json and genome.json to show scheme-specific amplicon products and gene positions in RAMPART visualisation

# Load necessary packages
library(jsonlite)
library(Biostrings)
library(ORFik)
library(stringr)
library(DECIPHER)

# Function to generate primers.json with calculated amplicons
bed_to_amplicons_json <- function(bed_path, scheme_name, output_json) {
  # Read BED file
  bed <- read.table(bed_path, header = FALSE, stringsAsFactors = FALSE)
  colnames(bed) <- c("chr", "start", "end", "name", "pool", "strand")
  
  # Separate forward and reverse primers
  fwd <- bed[bed$strand == "+", ]
  rev <- bed[bed$strand == "-", ]
  
  # Sort both by start position
  fwd <- fwd[order(fwd$start), ]
  rev <- rev[order(rev$start), ]
  
  # Check if there are equal numbers of forward and reverse primers
  if (nrow(fwd) != nrow(rev)) {
    stop("Unequal number of forward and reverse primers!")
  }
  
  # Build amplicons as [start_of_fwd +1, end_of_rev]
  amplicons <- lapply(seq_len(nrow(fwd)), function(i) {
    start <- fwd$start[i] + 1  # BED is 0-based, JSON is 1-based
    end   <- rev$end[i]
    c(start, end)
  })
  
  # Create the JSON structure
  primers_json <- list(
    name = scheme_name,
    amplicons = amplicons
  )
  
  # Write the JSON to file
  write_json(primers_json, output_json, pretty = TRUE, auto_unbox = TRUE)
  
  message("Wrote primers.json with ", length(amplicons), " amplicons to ", output_json)
}

# Function to create genome JSON
create_genome_json <- function(fasta_file, output_file, genome_label) {
  # Read in the reference FASTA (single sequence)
  string <- readDNAStringSet(fasta_file)
  
  # Remove gaps using ORFik's RemoveGaps function
  string <- RemoveGaps(string, removeGaps = "common")
  
  # Convert sequence to character string after gap removal
  string <- as.character(string)
  
  # Default RABV gene positions
  default_genes <- data.frame(
    gene  = c("N", "P", "M", "G", "L"),
    start = c(71, 1514, 2496, 3318, 5418),
    end   = c(1423, 2407, 3104, 4892, 11801)
  )
  
  # Find ORFs for each gene and build the results
  gene_results <- lapply(seq_len(nrow(default_genes)), function(i) {
    window_seq <- subseq(string, start = default_genes$start[i], end = default_genes$end[i])
    
    # Find ORFs within the gene window
    orfs <- as.data.frame(findORFs(window_seq, startCodon = "ATG", minimumLength = 200))
    
    if (nrow(orfs) == 0) {
      message("WARNING: No ORF found for ", default_genes$gene[i], ", default gene positions used")
      return(list(
        start = default_genes$start[i],
        end   = default_genes$end[i],
        strand = 1
      ))
    } else {
      # Take the first ORF or best scoring one
      best_orf <- orfs[which.max(orfs$width), ]
      list(
        start  = default_genes$start[i] + best_orf$start - 1,
        end    = default_genes$start[i] + best_orf$end   - 1,
        strand = 1
      )
    }
  })
  
  # Name the genes based on default gene names
  names(gene_results) <- default_genes$gene
  
  # Build the genome JSON structure
  genome_json <- list(
    label = genome_label,  # Genome label passed as an argument
    length = nchar(string),  # Use the full length of the sequence
    genes = gene_results,
    reference = list(
      label = genome_label,  # Genome label passed as an argument
      sequence = string
    )
  )
  
  # Write the JSON to output file
  write_json(genome_json, output_file, pretty = TRUE, auto_unbox = TRUE)
  
  message("Done: wrote genome.json with ", length(gene_results), " genes to ", output_file)
}

# Example Usage

# Create primers JSON from BED file
# bed_to_amplicons_json("../../meta_data/primer-schemes/EA_2024/V1/EA_2024.scheme.bed", 
#                        "EA_2024 rabies virus primer scheme", "primers.json")

# Create genome JSON from reference FASTA
# create_genome_json("../../meta_data/primer-schemes/EA_2024/V1/EA_2024.reference.fasta", 
#                    "genome.json", "EA_2024")