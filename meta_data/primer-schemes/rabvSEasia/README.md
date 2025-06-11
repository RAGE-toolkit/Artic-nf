# 🇵🇭 Primer Set: `rabvSEasia`

This folder contains the reference genome and associated primer scheme used for amplicon-based sequencing and genome assembly for Southeast Asia, developed with the Philippines in mind and designed in 2018.

---

## 📌 Reference Genome

- **Name:** Rabies virus  
- **ID:** [Not specified]  
- **Source:** NCBI GenBank  
- **Length:** 11,923 bp  
- **File:** `rabvSEasia.reference.fasta`

### 🔧 Primer Design

A multiplex primer scheme was developed for rabies virus (RABV) circulating in Southeast Asia, with emphasis on Philippine lineages. Whole genome sequences (≥11,800 bp) were selected from RABV-GLUE [http://rabv-glue.cvr.gla.ac.uk/#/home] using filters for geographic and temporal diversity while avoiding redundancy (>99% identity). Sequences were cleaned by masking ambiguous bases and gaps to ensure compatibility with Primal Scheme.

To account for limited full-genome data from the Philippines, a 99% consensus N-gene sequence — derived from numerous partial genomes — was included, with the remainder masked. This helped capture known regional diversity. The most complete Philippine genome was prioritised and used as the reference. The final design set included 10 whole genomes and 1 consensus partial genome  (SEasia_selectionPlusNconsensus_aln_masked_upper_spliced.fasta).  

- Reference sequences used:  
  KX148260, KX148263, AB981664, KX148255, JN786878, KX148250, KX148254, EU293111, KX148248, KX148266  and  N-gene 99% consensus sequence of [AB116581, AB116582, AB683592–AB683635]
- Original reference panel file: `primer_design/wholeGenome_sequences/SEasia_selectionPlusNconsensus_aln_masked_upper_spliced.fasta`  

---

## 🧬 Primer Scheme

- **Scheme Name:** `rabvSEasia`  
- **Amplicon Size:** ~400 bp  
- **Number of Amplicons:** 41  
- **Format:** BED, TSV, FASTA  
- **Key Files:**
  - `rabvSEasia.scheme.bed`: Combined scheme BED file  
  - `multiplexPrimerScheme/rabvSEasia.bed`: Primer coordinates  
  - `multiplexPrimerScheme/rabvSEasia_primers.csv`: Primer metadata (CSV)  
  - `rabvSEasia_primerSequences.fasta`: Primer sequences (FASTA)


---

## 📁 File Contents

```
├── primer_design
│   ├── multiplexPrimerScheme
│   │   ├── rabvSEasia_primers.csv             # Primer metadata (CSV format)
│   │   └── rabvSEasia.bed                     # Primer coordinates (BED format)
│   ├── Ngene_sequences
│   │   ├── philippines_allseqN_nucleotide_99%consensus.fasta   # N-gene consensus
│   │   └── philippines_allseqN_nucleotide_alignment.fasta      # N-gene alignment
│   ├── Primer design notes.pdf                # Detailed primer design rationale
│   └── wholeGenome_sequences
│       ├── rabvSEasia_wgs_metadata.txt        # Metadata for full genome selection
│       ├── SEasia_selectionPlusNconsensus_aln_masked_upper_spliced.fasta  # Final design panel
│       ├── SEasia_wgs_nucleotide_alignment.fasta   # WGS alignment for design
│       └── SEasia_wgs_RepresentativeSeq.pdf   # Highlighted representative sequences
├── rabvSEasia_primerSchemeVisual.png          # Visualisation of primer scheme
├── rabvSEasia_primerSequences.csv             # Primer metadata (CSV)
├── rabvSEasia_primerSequences.fasta           # Primer sequences (FASTA)
├── rabvSEasia_primerSequences.fasta.bck       # Associated Geneious/sequence project files
├── rabvSEasia_primerSequences.fasta.des
├── rabvSEasia_primerSequences.fasta.prj
├── rabvSEasia_primerSequences.fasta.sds
├── rabvSEasia_primerSequences.fasta.ssp
├── rabvSEasia_primerSequences.fasta.suf
├── rabvSEasia_primerSequences.fasta.tis
├── rabvSEasia.reference.dict                  # Reference dictionary (e.g., GATK)
├── rabvSEasia.reference.fasta                 # Reference genome used in design
├── rabvSEasia.reference.fasta.amb             # Indexed reference files (BWA)
├── rabvSEasia.reference.fasta.ann
├── rabvSEasia.reference.fasta.bwt
├── rabvSEasia.reference.fasta.fai
├── rabvSEasia.reference.fasta.pac
├── rabvSEasia.reference.fasta.sa
└── rabvSEasia.scheme.bed                      # Combined primer scheme (BED)
```

---

## 🗂️ Version Notes

- **V1**: Initial release of the `rabvSEasia` primer set and reference.