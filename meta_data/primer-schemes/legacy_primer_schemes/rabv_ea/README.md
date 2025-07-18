# 🇰🇪🇹🇿 Primer Set: `rabv_ea`

This folder contains the reference genome and associated primer scheme used for amplicon-based sequencing and genome assembly for East Africa (Tanzania/Kenya) from 2020–2024.

**Important:** **DO NOT USE V1**. **V1** contained incorrect primer coordinates and has been replaced by **V2**, which includes the corrected coordinates.

---

## 📌 Reference Genome

- **Name:** Rabies virus  
- **ID:** RV3407 (SD668)  
- **Source:** Internal data  
- **Length:** 11,923 bp  
- **File:** `rabv_ea.reference.fasta`

### 🔧 Primer Design

- Four sequences from 2018 were used: SD668, SD674, RAB16029, Z0826362 — representing Kenya and Tanzania.  
- Original reference panel file: `rabv_ea_primerDesign_referencePanel.fasta`  
- SD668 was used as the primary reference sequence for the scheme.

---

## 🧬 Primer Scheme

- **Scheme Name:** `rabv_ea`  
- **Amplicon Size:** ~400 bp  
- **Number of Amplicons:** 38  
- **File Format:** BED / TSV  
- **Primer Files:**
  - `rabv_ea.primer.bed`: BED file with primer coordinates  
  - `rabv_ea.primer.tsv`: Primer metadata in TSV format  
  - `rabv_ea.primer.csv`: (Optional) Primer metadata in CSV format  
  - `rabv_ea_primers.fasta`: FASTA file of primer sequences  

---

## 📁 File Contents

```
products.fna                             # Assembled amplicon products
rabv_ea_primerDesign_referencePanel.fasta  # Input references used for primer design
rabv_ea_primerPositions_check            # QC output for primer placement
rabv_ea_primers.fasta                    # FASTA file of primer sequences
rabv_ea_README.md                        # This documentation file

rabv_ea.primer.bed                       # BED file with primer coordinates
rabv_ea.primer.csv                       # Primer metadata in CSV format
rabv_ea.primer.tsv                       # Primer metadata in TSV format

rabv_ea.reference.dict                   # Sequence dictionary for reference (used by tools like GATK)
rabv_ea.reference.fasta                  # Reference genome used for primer design
rabv_ea.reference.fasta.fai              # FASTA index file (generated by samtools)

rabv_ea.scheme.bed                       # Combined primer scheme in BED format
```

## 🗂️ Version Notes

- **V1**: Initial release of the `rabv_ea` primer set and reference. (DO NOT USE)
- **V2**: Primer coordinates corrected- incorrect in V1.
