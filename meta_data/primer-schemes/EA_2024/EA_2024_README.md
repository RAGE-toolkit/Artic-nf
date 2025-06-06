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
README.md                       # This documentation file
reference.fasta                 # Modified reference genome (FASTA)
primers.bed                     # Primer coordinates in BED format
primer_schemes.tsv              # (Optional) Primer details
meta_data/                      # Supporting metadata including alignment and reference modification
└── primer-schemes/
└── EA_2024/
└── V1/
└── reference_seq_detail/
└── EA_general_align.fasta
---

## 🗂️ Version Notes

- **V1**: Initial release of the EA_2024 primer set and modified reference