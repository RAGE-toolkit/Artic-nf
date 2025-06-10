# 🇵🇪🦇 Primer Set: `DrVB` (Daniel Streicker group)

This folder contains the reference genome and associated primer scheme used for amplicon-based sequencing and genome assembly of *Desmodus rotundus* bat rabies virus (DRBR) in **Peru**. The primer scheme was developed using a hybrid reference generated from a combination of Peruvian partial genomes and available whole genome sequences (WGS).

> ⚠️ **Note:** This scheme has not been tested with the ARTIC pipeline. It includes alternate primer versions for some amplicons (e.g., `400_10A_LEFT_1`, `400_10B_LEFT_1`), which may cause issues in downstream analysis.

Contact Hollie French (h.french.1@research.gla.ac.uk) for additional details/queries.

---

## 📌 Reference Genome

- **Name:** Rabies virus  
- **ID:** `L3_clade2_hybrid` (from hybrid file)  
- **Source:** Custom hybrid reference  
- **Length:** 11,923 bp  
- **File:** `DrVB.reference.fasta`

### 🔧 Primer Design

The scheme was based on partial RABV genomes from Peru mixed with WGS to create a hybrid reference.

- **Reference sequences used:**  
  - `EU293113`, `JQ685936`, `KM594041`, `KM594043`
- **Reference panel:**  
  - `references/HybridDrVs_Peru.fasta`

---

## 🧬 Primer Scheme

- **Scheme Name:** `DrVB`  
- **Amplicon Size:** ~400 bp  
- **Number of Amplicons:** 41  
- **File Formats:** BED (coordinates), FASTA (primers), Excel (metadata)
- **Primer Notes:** Alternate LEFT/RIGHT primers included per amplicon (A/B design)

---

## 🔑 Key Files

- `DrVB.scheme.bed`: Primer coordinates (BED format), including alternates  
- `DrVB.reference.fasta`: Hybrid reference genome used in scheme design  
- `DrVB_Rabies_amplicon_primers_V3.xlsx`: Primer metadata and sequences  
- `HybridDrVs_Peru.fasta`: Reference panel used to generate the hybrid reference  
- Individual FASTA files: Sequences used in the hybrid reference  
  (`EU293113.fasta`, `JQ685936.fasta`, `KM594041.fasta`, `KM594043.fasta`)

---

## 📁 File Contents

## 📁 File Contents

```
├── DrVB_Rabies_amplicon_primers_V3.xlsx            # Primer sequences and metadata (Excel)
├── readme.md                                       # This README file
├── references                                      # Input reference sequences
│   ├── EU293113.fasta                              # Reference genome
│   ├── HybridDrVs_Peru.fasta                       # Hybrid reference combining partial and WGS sequences
│   ├── JQ685936.fasta                              # Reference genome
│   ├── KM594041.fasta                              # PReference genome
│   └── KM594043.fasta                              # Reference genome
└── V1                                              # Versioned scheme files
├── DrVB.reference.fasta                        # Final hybrid reference used for design
├── DrVB.reference.fasta.amb                    
├── DrVB.reference.fasta.ann                    
├── DrVB.reference.fasta.bwt                    
├── DrVB.reference.fasta.pac                    
├── DrVB.reference.fasta.sa                     
└── DrVB.scheme.bed                             # BED file of primer coordinates

```

---

## 🗂️ Version Notes

- **V1** (circa December 2023): Initial development of the `DrVB` scheme using a hybrid reference combining Peruvian partial genomes and publicly available WGS. Designed to target *Desmodus rotundus* RABV sequences. Includes alternate primers per amplicon. Not validated in ARTIC pipeline.

