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

The primer scheme was designed based on the only publicly available genome sequence for dog RABV in Nigeria: KC196743 (dog, Nigeria, 2011), classified as Africa 2 clade in RABV_GLUE.

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