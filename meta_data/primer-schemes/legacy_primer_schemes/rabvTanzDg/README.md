# 🇹🇿 Primer Set: `rabvTanzDg`

This folder contains the reference genome and associated primer scheme used for amplicon-based sequencing and genome assembly of rabies virus (RABV) in **Tanzaniax*, generated in 2016.

**Important:** **DO NOT USE V1.** This version contained incorrect primer coordinates due to issues in the `primal` scheme output. It has been replaced by **V2**, which includes corrected coordinates and should be used instead.

---

## 📌 Reference Genome

- **Name:** Rabies virus  
- **ID:** KF155002  
- **Source:** NCBI GenBank  
- **Length:** 11,923 bp  
- **File:** `rabvTanzDg.reference.fasta`

### 🔧 Primer Design

- Designed using KF155002 (dog, Tanzania, 2010) as the sole reference sequence.

---

## 🧬 Primer Scheme

- **Scheme Name:** `rabvTanzDg`  
- **Amplicon Size:** ~400 bp  
- **Number of Amplicons:** 47  
- **File Format:** BED / TSV  
- **Primer Files:**
  - `rabv_ea.primer.bed`: BED file with primer coordinates  
  - `rabv_ea.primer.tsv`: Primer metadata in TSV format  
  - `rabv_ea.primer.csv`: (Optional) Primer metadata in CSV format  
  - `rabv_ea_primers.fasta`: FASTA file of primer sequences  

---

## 📁 File Contents

```
.
├── README.md                                  # This file
├── V1                                         # ⚠️ Deprecated version — do not use
│   ├── rabvTanzDg_primerSequences.csv         # Primer sequences and metadata (CSV)
│   ├── rabvTanzDg.reference.fasta             # Reference genome (KF155002)
│   ├── rabvTanzDg.reference.fasta.amb         # BWA index file
│   ├── rabvTanzDg.reference.fasta.ann         # BWA index file
│   ├── rabvTanzDg.reference.fasta.bwt         # BWA index file
│   ├── rabvTanzDg.reference.fasta.fai         # FASTA index
│   ├── rabvTanzDg.reference.fasta.pac         # BWA index file
│   ├── rabvTanzDg.reference.fasta.sa          # BWA index file
│   └── rabvTanzDg.scheme.bed                  # BED file with (incorrect) primer coordinates
└── V2                                         # ✅ Corrected version — use this one
├── rabvTanzDg_primerSequences.csv         # Corrected primer sequences and metadata (CSV)
├── rabvTanzDg.insert.bed                  # Amplicon insert regions (excludes primer sites)
├── rabvTanzDg.reference.fasta             # Reference genome (KF155002)
├── rabvTanzDg.reference.fasta.fai         # FASTA index
└── rabvTanzDg.scheme.bed                  # Corrected BED file with primer coordinates

```

---

## 🗂️ Version Notes

- **V1** (circa mid-2016): Initial release of the `rabvTanzDg` primer set and reference. A problem with the `primal` scheme output resulted in incorrect BED coordinates — **this version should not be used**.
- **V2**: Corrected version with accurate primer coordinates and associated insert file.