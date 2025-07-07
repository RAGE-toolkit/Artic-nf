# 🇳🇬 Primer Set: `rabvNig`

This folder contains the reference genome and associated primer scheme used for amplicon-based sequencing and genome assembly of canine/dog-associated rabies virus (RABV) in Nigeria.

---

## 📌 Reference Genome

- **Name:** Rabies virus  
- **ID:** KC196743  
- **Source:** NCBI GenBank  
- **Length:** 11,923 bp  
- **File:** `rabvNig.reference.fasta`

### 🔧 Primer Design

RABV-GLUE was used to identify publicly available RABV genomes from Nigeria, revealing two sequences: KC196743 (dog, 2011) and KX148201 (dog, 2016), which belonged to different minor clades—Africa-2 and Cosmopolitan AF1a, respectively. To assess the broader diversity of RABV in the region, a larger dataset comprising 287 additional sequences from Nigeria was analysed. The majority of these sequences clustered within the Africa-2 minor clade, indicating that the AF1a clade is uncommon in this context.

Primers were therefore designed using KC196743 as a reference representative of the dominant Africa-2 clade. To incorporate additional sequence diversity, a 75% consensus sequence was generated from KC196743 and the 287 partial sequences, and this consensus was used as a secondary reference for primer design.

---

## 🧬 Primer Scheme

- **Scheme Name:** `rabvNig`  
- **Amplicon Size:** ~400 bp  
- **Number of Amplicons:** 41  
- **Formats:** BED, FASTA  
- **Key Files:**
  - **`rabvNig.primer.bed`**: BED file containing primer coordinates  
  - **`rabvNig.primer.csv`**: CSV file with primer metadata  
  - **`rabvNig.primer.fasta`**: FASTA file with primer sequences  
  - **`rabvNig.reference.fasta`**: The reference genome used for primer design  
  - **`rabvNig.reference.fasta.fai`**: Index file for the reference genome  
  - **`rabvNig.scheme.bed`**: BED file with amplicon scheme based on primer coordinates  

---

## 📁 File Contents

```
.
└── V1
├── rabvNig.primer.bed      # BED file containing the primer coordinates for each amplicon
├── rabvNig.primer.csv      # CSV file with metadata for each primer including IDs and sequences
├── rabvNig.primer.fasta    # FASTA file with primer sequences for use in amplicon-based sequencing
├── rabvNig.reference.fasta # Reference genome sequence used for primer design (KC196743)
├── rabvNig.reference.fasta.fai # Index file for the reference genome, needed for alignment tools
└── rabvNig.scheme.bed      # BED file outlining the primer scheme for amplification regions

```

---

## 🗂️ Version Notes

- **V1** (circa December 2023): Initial release of the `rabvNig` primer set and reference. 