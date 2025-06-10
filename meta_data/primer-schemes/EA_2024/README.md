# 🌍 Primer Set: `EA_2024`

This folder contains the reference genome and associated primer scheme used for amplicon-based sequencing and genome assembly of rabies virus (RABV) circulating in East Africa. The `EA_2024` scheme replaces the previous `rabv_ea` set and incorporates the latest available sequencing data as per October 2024. It improves coverage of regional viral diversity by including sequences from Tanzania, Kenya, and — new in this version — Malawi, with contributions from Dr Stella Mazeri (University of Edinburgh).

---

## 📌 Reference Genome

- **Virus:** Rabies virus  
- **Accession:** OR045981  
- **Source:** NCBI GenBank  
- **Length:** 11,695 bp (original)  
- **File:** `EA_2024.reference.fasta`  

### 🔧 Reference Genome Modifications

The genome OR045981 was used as the starting reference but had unresolved regions (`N`s) at both ends. These missing regions were replaced by splicing in consensus sequence derived from East African genomes:

- **5′ end:** 79 bp spliced in  
- **3′ end:** 149 bp spliced in  

Details of sequences used:

- All available East African sequences (excluding Malawi):  
  `V1/reference_seq_detail/EA_general_align.fasta`
- Start region:  
  `V1/reference_seq_detail/EA_genomeStart_sequencesToSplice.fa`  
  Consensus:  
  `V1/reference_seq_detail/EA_genomeStart_sequencesToSplice.consensus.fa`
- End region:  
  `V1/reference_seq_detail/EA_genomeEnd_sequencesToSplice.fa`  
  Consensus:  
  `V1/reference_seq_detail/EA_genomeEnd_sequencesToSplice.consensus.fa`

The final modified reference used in primer design is:  
`V1/EA_2024.reference.fasta`

---

## 🧬 Primer Design

Primers were designed using a representative panel of 20 sequences chosen from a phylogenetic tree of East African and Malawian RABV genomes with ≥96% coverage. The tree was reduced using [Treemmer](https://git.scicore.unibas.ch/TBRU/Treemmer) to maintain diversity while minimising redundancy.

- **Reference panel file:**  
  `V1/primer_design/EA_2024_primerDesign_referencePanel.fasta`

- **Accessions included:**  
  `KY210231`, `KR906749`, `KR906748`, `Z00861809`, `MN726819`,  
  `Z00861838`, `SD746`, `LN001`, `LN002`,  
  `BVL/479/21-10/05/2021-Blantyre-Dog`,  
  `050121_Chimalilo1-05/01/2021-Thyolo-Dog`, `MT006`, `KR906769`, `SD750`,  
  `KX148207`, `KR906744`, `KY210309`, `SD807`, `KY210240`, `MAL1020`

---

## 🧪 Primer Scheme Details

- **Scheme Name:** `EA_2024`  
- **Version:** `V1`  
- **Amplicon Size:** ~700 bp  
- **Number of Amplicons:** 23  
- **File Formats:** BED / TSV  

### 🔑 Key Files

- `EA_2024.primer.bed`: BED format file with primer coordinates  
- `EA_2024.primer.tsv`: Primer metadata and sequences  
- `EA_2024.scheme.bed`: Combined scheme file for downstream use  
- `EA_2024.insert.bed`: Insert regions excluding primer sites  
- `EA_2024.reference.fasta`: Final modified reference used in design  
- `EA_2024.plot.pdf` / `.svg`: Visual representation of primer positions  
- `EA_2024.report.json`: Summary of the primer scheme design process  
- `EA_2024.log`: Log file of the primer design tool run  

---

## 📁 File Contents

```

README.md                                # This documentation file

V1/                                      # Version 1 of the EA_2024 scheme
├── EA_2024.insert.bed                   # Amplicon regions excluding primer sites
├── EA_2024.log                          # Log from primer scheme generation
├── EA_2024.plot.pdf                     # Visual layout of primers (PDF format)
├── EA_2024.plot.svg                     # Visual layout of primers (SVG format)
├── EA_2024.primer.bed                   # BED file listing primer coordinates
├── EA_2024.primer.tsv                   # TSV file with primer names and sequences
├── EA_2024.reference.fasta              # Final reference genome used for scheme
├── EA_2024.report.json                  # Summary report from primer design
├── EA_2024.scheme.bed                   # Combined primer BED file for use in pipelines

├── primer_design/                       # Primer design inputs and intermediate files
│   ├── EA_2024_primerDesign_referencePanel.fasta      # Final panel of 20 reference sequences used for design
│   ├── reference-seqs/                                 # Source data and intermediate alignments
│   │   ├── EA_general_align.fasta                      # Multiple alignment of East African sequences (Tanzania/Kenya)
│   │   ├── EA_general_metadata_new_assignment_fig1.csv # Metadata used in reference selection
│   │   ├── EA_Malawi_96cov_treemmer/                   # Tree-reduced panel from TZA,KEN,MWI sequences, considering only those with ≥96% genome coverage 
│   │   │   ├── EA_Malawi.96cov.fasttree_trimmed_list_X_20
│   │   │   ├── EA_Malawi.96cov.fasttree_trimmed_list_X_20_sequences.fasta
│   │   │   └── EA_Malawi.96cov.fasttree_trimmed_tree_X_20
│   │   ├── EA_Malawi_treemmer/                         # Tree-reduced panel from TZA,KEN,MWI sequences, considering all sequences (not just xx coverage)
│   │   │   ├── EA_Malawi.fasttree.newick_trimmed_list_X_20
│   │   │   ├── EA_Malawi.fasttree.newick_trimmed_list_X_20_sequences.fasta
│   │   │   └── EA_Malawi.fasttree.newick_trimmed_tree_X_20
│   │   ├── EA_Malawi.96cov.aln.fasta                   # Full alignment for 96% coverage TZA,KEN,MWI genomes
│   │   ├── EA_Malawi.96cov.fasttree                    # Tree built from 96% coverage TZA,KEN,MWI sequences
│   │   ├── EA_Malawi.aln.fasta                         # Alignment of all TZA,KEN,MWI sequences
│   │   ├── EA_Malawi.fasttree                          # Full tree from TZA,KEN,MWI sequences
│   │   ├── EA_Malawi.fasttree.newick                   # Newick-format tree file
│   │   ├── MWI-blantyre_1_104_unaligned_lowNprop.fasta # Raw input data from Malawi
│   │   └── rabv_ea.reference.fasta                     # Previous reference used in `rabv_ea` scheme

│   └── trimmed_trees/                                  # Tree files from Treemmer-reduced panels
│       └── EA_trimmed_20reps/
│           ├── Tree_EA_Ml.newick
│           ├── Tree_EA_Ml.newick_res_1_LD
│           ├── Tree_EA_Ml.newick_res_1_TLD.pdf
│           ├── Tree_EA_Ml.newick_trimmed_list_X_20
│           ├── Tree_EA_Ml.newick_trimmed_tree_X_20
│           └── Tree_EA_Ml.tree

├── reference_seq_detail/                # Details of genome end repairs
│   ├── EA_general_align.fasta                         # Full East African alignment
│   ├── EA_genomeEnd_sequencesToSplice.consensus.fa    # Consensus for 3′ end repair
│   ├── EA_genomeEnd_sequencesToSplice.fa              # Raw sequences for 3′ end
│   ├── EA_genomeEnd_sequencesToSplice.fa.bak001       # Backup
│   ├── EA_genomeStart_sequencesToSplice.consensus.fa  # Consensus for 5′ end repair
│   ├── EA_genomeStart_sequencesToSplice.fa            # Raw sequences for 5′ end
│   ├── Z00861838_spliced.fasta                        # Base genome after modifications (before renaming to generic EA_reference)
│   └── Z00861838.fasta                                # Base genome before modifications

```

---

## 🗂️ Version Notes

- **V1** (October 2024): Initial release of the `EA_2024` primer set and reference.
