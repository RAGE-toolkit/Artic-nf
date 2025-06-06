# Primer Set: `rabvSEasia`

This folder contains the reference genome and associated primer scheme used for amplicon-based sequencing and genome assembly for Southeast Asia, developed with the Philippines in mind and designed in 2018.

---

## 📌 Reference Genome

- **Name:** Rabies virus  
- **ID:** [Not specified]  
- **Source:** NCBI GenBank  
- **Length:** 11,923 bp  
- **File:** `rabvSEasia.reference.fasta`

### 🔧 Primer Design

- Reference sequences used:  
  KX148260, KX148263, N-gene 99% consensus sequence of [AB116581, AB116582, AB683592–AB683635], AB981664, KX148255, JN786878, KX148250, KX148254, EU293111, KX148248, KX148266  
- Original reference panel file: `philippines_allseqN_nucleotide_99%consensus.fasta`  
- The design was informed by regional N-gene sequences from the Philippines.

---

## 🧬 Primer Scheme

- **Scheme Name:** `rabvSEasia`  
- **Amplicon Size:** ~400 bp  
- **Number of Amplicons:** 41  
- **File Format:** BED / TSV  
- **Primer Files:**
  - `rabvSEasia.scheme.bed`: Combined primer scheme in BED format  
  - `multiplexPrimerScheme/rabvSEasia.bed`: BED file with primer coordinates  
  - `multiplexPrimerScheme/rabvSEasia_primers.csv`: Primer metadata in CSV format  
  - `rabvSEasia_primerSequences.fasta`: FASTA file of primer sequences  

---

## 📁 File Contents

```
├── multiplexPrimerScheme
│   ├── rabvSEasia_primers.csv             # Primer metadata in CSV format
│   └── rabvSEasia.bed                     # BED file with primer positions
├── Ngene_sequences
│   ├── philippines_allseqN_nucleotide_99%consensus.fasta   # Consensus N-gene used for design
│   └── philippines_allseqN_nucleotide_alignment.fasta      # N-gene sequence alignment
├── Primer design notes.pdf                # Notes and context from original primer design
├── rabvSEasia_primerSchemeVisual.png      # Visual representation of the primer scheme
├── rabvSEasia_primerSequences.csv         # Primer metadata in CSV format (duplicate of above or reformatted)
├── rabvSEasia_primerSequences.fasta       # FASTA file of primer sequences
├── rabvSEasia_primerSequences.fasta.*     # Associated project files (Geneious or similar software)
│   ├── .bck, .des, .prj, .sds, .ssp, .suf, .tis  # Software-generated files for sequence handling
├── rabvSEasia.reference.dict              # Sequence dictionary (used by tools like GATK)
├── rabvSEasia.reference.fasta             # Reference genome used for primer design
├── rabvSEasia.reference.fasta.*           # Associated FASTA index and BWA mapping files
│   ├── .amb, .ann, .bwt, .fai, .pac, .sa
├── rabvSEasia.scheme.bed                  # Combined BED file of full primer scheme
└── wholeGenome_sequences
    ├── rabvSEasia_wgs_metadata.txt        # Metadata for whole genome sequences used
    ├── SEasia_selectionPlusNconsensus_aln_masked_upper_spliced.fasta  # Processed alignment with N-gene consensus
    ├── SEasia_wgs_nucleotide_alignment.fasta  # Whole genome sequence alignment
    └── SEasia_wgs_RepresentativeSeq.pdf   # Summary or visual of selected representative sequences
```

---

## 🗂️ Version Notes

- **V1**: Initial release of the `rabvSEasia` primer set and reference.