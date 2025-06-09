# Primer Set: EA_2024

This folder contains the reference genome and associated primer scheme used for amplicon-based sequencing and genome assembly for East Africa.

---

## 📌 Reference Genome

- **Name:** Rabies virus
- **Accession:** OR045981
- **Source:** NCBI GenBank
- **Length:** 11,695 bp (original)
- **File:** `reference.fasta`

### 🔧 Reference Genome Modifications

- OR045981 was used as the initial reference sequence, as it was the first listed in the primer design FASTA.
- It contained missing data (`N`s) at the genome ends.
- To correct this, 79 bases at the 5′ end and 149 bases at the 3′ end were spliced in from a consensus of East African sequences.
- Modified reference available at:  
  `meta_data/primer-schemes/EA_2024/V1/reference_seq_detail/EA_general_align.fasta`

---

## 🧬 Primer Scheme

- **Scheme Name:** EA_2024
- **Amplicon Size:** ~700 bp
- **Number of Amplicons:** 23
- **File Format:** BED / TSV
- **Primer Files:**
  - `primers.bed`: BED file with primer coordinates
  - `primer_schemes.tsv`: Optional additional metadata

---

## 📁 File Contents

```
EA_2024_README.md                    # This documentation file

V1/                                  # Version 1 of the primer scheme
├── EA_2024_notes.rtf                # Design notes and background
├── EA_2024_primerDesign_referencePanel.fasta  # Input reference panel used in primer design
├── EA_2024.insert.bed               # Amplicon insert regions
├── EA_2024.log                      # Primer scheme generation log
├── EA_2024.plot.pdf                 # Visual plot of amplicons (PDF)
├── EA_2024.plot.svg                 # Visual plot of amplicons (SVG)
├── EA_2024.primer.bed               # BED file of primer positions
├── EA_2024.primer.tsv               # TSV file with primer sequences and metadata
├── EA_2024.reference.fasta          # Final modified reference used for primer scheme
├── EA_2024.report.json              # Summary report from primer design tool
├── EA_2024.scheme.bed               # Combined primer scheme BED file

└── reference_seq_detail/            # Supporting files for reference genome edits
├── EA_general_align.fasta                       # Multiple alignment of regional sequences
├── EA_genomeEnd_sequencesToSplice.consensus.fa  # Consensus used to patch genome ends
├── EA_genomeEnd_sequencesToSplice.fa            # Raw sequences at genome end
├── EA_genomeEnd_sequencesToSplice.fa.bak001     # Backup file (auto-generated)
├── EA_genomeStart_sequencesToSplice.consensus.fa # Consensus used for genome start
├── EA_genomeStart_sequencesToSplice.fa          # Raw sequences at genome start
├── Z00861838_spliced.fasta                      # Example spliced reference
└── Z00861838.fasta                              # Original unspliced reference
```
</pre>


## 🗂️ Version Notes

- **V1**: Initial release of the EA_2024 primer set and modified reference