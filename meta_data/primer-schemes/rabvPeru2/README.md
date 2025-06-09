# 🇵🇪 Primer Set: `rabvPeru2`

This folder contains the reference genome and associated primer scheme used for amplicon-based sequencing and genome assembly of rabies virus (RABV) in Peru. The scheme was developed in response to poor performance of an earlier design (`rabvPeru`) based on publicly available data from neighbouring countries. This updated version (`rabvPeru2`) was informed by metagenomic sequencing of three Peruvian RABV genomes from the Puno region (2011–2012), carried out at the University of Glasgow.

---

## 📌 Reference Genome

- **Name:** Rabies virus  
- **ID:** PP965373  
- **Source:** NCBI GenBank  
- **Length:** 11,922 bp  
- **File:** `rabvPeru2.reference.fasta`

### 🔧 Primer Design

The `rabvPeru2` primer scheme was developed using whole genome sequences generated from three RABV samples originating from the Puno region. These were aligned and cleaned to remove ambiguous bases before use in Primal Scheme. This empirical approach improved compatibility with Peruvian viral diversity and resolved issues encountered with the earlier `rabvPeru` design.

- **Reference sequences used:**  
  PP965373, KU938752, KU938829  
- **Reference panel file:**  
  `primer_design/peru_glasgow_n3seq_noAmb.fasta`

---

## 🧬 Primer Scheme

- **Scheme Name:** `rabvPeru2`  
- **Amplicon Size:** ~400 bp  
- **Number of Amplicons:** 41  
- **Formats:** BED, FASTA  
- **Key Files:**
  - `rabvPeru2.scheme.bed` – Full primer scheme in BED format  
  - `rabvPeru2.primers.fasta` – Primer sequences in FASTA format  
  - `rabvPeru2.reference.fasta` – Reference genome  

---

### 🔧 Primer Modifications

Following initial testing, several modifications were made to improve genome coverage in poorly performing regions. One primer (40R) was completely replaced, and several alternate primers were added.

**Added / Modified Primers:**
- `rabvPeru2_5alt_LEFT`: `TCCTGAGGCTGTTTATACTCGG`  
- `rabvPeru2_34alt_RIGHT`: `ACAGATTTTTCTCAACCCTCTGG`  
- `rabvPeru2_38alt_LEFT`: `TGACATTGCCTCGATCAACCGG`  
- `rabvPeru2_40alt_RIGHT`: `CAGATTTCCGGGCGGATCTGG`

---

## 📁 File Contents

```
.
├── rabvPeru2_README.md
├── V1
│   ├── primer_notes.md                      # Notes on initial primer design
│   ├── rabvPeru2.primers.fasta              # Primer sequences (FASTA)
│   ├── rabvPeru2.reference.fasta            # Reference genome
│   ├── rabvPeru2.reference.fasta.amb
│   ├── rabvPeru2.reference.fasta.ann
│   ├── rabvPeru2.reference.fasta.bwt
│   ├── rabvPeru2.reference.fasta.fai
│   ├── rabvPeru2.reference.fasta.pac
│   ├── rabvPeru2.reference.fasta.sa
│   └── rabvPeru2.scheme.bed                 # BED file of primer scheme
└── V2
    ├── primer_design
    │   ├── peru_glasgow_n3seq.fasta                 # Original genomes used for design
    │   └── peru_glasgow_n3seq_noAmb.fasta           # Cleaned genome panel for primer design
    ├── rabvPeru2.primer.bed                         # Updated BED file (includes alt primers)
    ├── rabvPeru2.primers.fasta                      # Updated primer sequences (FASTA)
    ├── rabvPeru2.reference.fasta                    # Reference genome
    ├── rabvPeru2.reference.fasta.amb
    ├── rabvPeru2.reference.fasta.ann
    ├── rabvPeru2.reference.fasta.bwt
    ├── rabvPeru2.reference.fasta.fai
    ├── rabvPeru2.reference.fasta.pac
    └── rabvPeru2.reference.fasta.sa
```

---

## 🗂️ Version Notes

- **V1**: Initial release of the `rabvPeru2` primer set and reference.
- **V2**: Modified `rabvPeru2` primer set with alternative P40 RIGHT and additional alternate primers.

---

## 🗂️ Other Notes
- Probably should have removed one of PP965373| KU938752 from primer design reference set since they are identical