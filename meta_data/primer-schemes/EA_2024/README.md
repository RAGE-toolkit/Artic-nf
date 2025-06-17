# 🌍 Primer Set: `EA_2024`

This folder contains the reference genome and associated primer scheme used for amplicon-based sequencing and genome assembly of rabies virus (RABV) circulating in East Africa. The `EA_2024` scheme replaces the previous `rabv_ea` set and incorporates the latest available sequencing data as per October 2024. It improves coverage of regional viral diversity by including sequences from Tanzania, Kenya, and — new in this version — Malawi, with contributions from Dr Stella Mazeri (University of Edinburgh).

---

## 📌 Reference Genome

- **Virus:** Rabies virus  
- **Accession:** consensus of reference panel with base genome OR045981 (id:Z00861838)
- **Source:** NCBI GenBank  
- **Length:** 11,695 bp (original)  
- **File:** `EA_2024.reference.fasta`  

### 🔧 Reference Genome Modifications

A 51% consensus sequence of the sequence panel used in primer design was generated. Any ambiguous bases (Ns) in the consensus were replaced with the base call in genome Z00861838 (accession OR045981, as the base genome in primer design). Since this genome had unresolved regions (`N`s) at both ends missing regions were replaced by splicing in consensus sequence derived from all available East African genomes:

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

### 🔧 Other Modifications

It was noted that primer positions in original bed files were incorrect once the modified reference genome was produced. Hence, this were corrected manually.

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

.
├── README.md                         # Overview and instructions for the primer design project
└── V1
    ├── EA_2024.insert.bed            # BED file showing insert regions between primers
    ├── EA_2024.log                   # Log file recording details of primer design run
    ├── EA_2024.plot.pdf              # Primer positions visualisation (PDF)
    ├── EA_2024.plot.svg              # Primer positions visualisation (SVG)
    ├── EA_2024.primer.bed.txt        # BED format table of designed primers
    ├── EA_2024.primer.sequences.fasta# FASTA of designed primer sequences
    ├── EA_2024.primer.tsv            # Tab-delimited table of primers with metadata
    ├── EA_2024.reference.fasta       # Reference genome used for primer design
    ├── EA_2024.report.json           # JSON report of design metrics and summary
    ├── EA_2024.scheme.bed            # Final primer scheme (BED format)
    ├── primer_design
    │   ├── EA_2024_primerDesign_referencePanel_with51consensus.fasta  # Ref panel incl. their consensus sequence 
    │   ├── EA_2024_primerDesign_referencePanel.fasta                  # Main reference panel
    │   ├── EA_2024.51consensus.ambiguousbasemodification.fasta        # Ref panel consensus with ambiguous bases handled
    │   ├── reference-seqs
    │   │   ├── EA_general_align.fasta               # All East Africa RABV sequence alignment
    │   │   ├── EA_general_metadata_new_assignment_fig1.csv  # Metadata for sequences
    │   │   ├── EA_Malawi_96cov_treemmer # Tremmer analysis of East Africa sequences with at least 96% genome cov
    │   │   │   ├── EA_Malawi.96cov.fasttree_trimmed_list_X_20          # List of selected reference sequences for primer design (after Tremmer)
    │   │   │   ├── EA_Malawi.96cov.fasttree_trimmed_list_X_20_sequences.fasta # FASTA of selected sequences
    │   │   │   └── EA_Malawi.96cov.fasttree_trimmed_tree_X_20          # Trimmed phylogenetic tree
    │   │   ├── EA_Malawi_treemmer # Tremmer analysis of East Africa sequences with any genome cov
    │   │   │   ├── EA_Malawi.fasttree.newick_trimmed_list_X_20         # List of selected sequences
    │   │   │   ├── EA_Malawi.fasttree.newick_trimmed_list_X_20_sequences.fasta # FASTA of selected sequences
    │   │   │   └── EA_Malawi.fasttree.newick_trimmed_tree_X_20         # Trimmed phylogenetic tree
    │   │   ├── EA_Malawi.96cov.aln.fasta          # Alignment of 96cov East africa + Malawi sequences
    │   │   ├── EA_Malawi.96cov.fasttree           # Fasttree tree for 96cov
    │   │   ├── EA_Malawi.aln.fasta                # General alignment of East africa + Malawi sequences
    │   │   ├── EA_Malawi.fasttree                 # Phylogenetic tree of East africa + Malawi sequences
    │   │   ├── EA_Malawi.fasttree.newick          # Newick format tree of East africa + Malawi sequences
    │   │   └── MWI-blantyre_1_104_unaligned_lowNprop.fasta  # Unaligned low-N-content sequences
    │   └── trimmed_trees
    │       └── EA_trimmed_20reps
    │           ├── Tree_EA_Ml.newick               # Main tree (Newick)
    │           ├── Tree_EA_Ml.newick_res_1_LD      # LD-resolved tree
    │           ├── Tree_EA_Ml.newick_res_1_TLD.pdf # Visualisation of resolved tree (PDF)
    │           ├── Tree_EA_Ml.newick_trimmed_list_X_20   # List of selected sequences
    │           ├── Tree_EA_Ml.newick_trimmed_tree_X_20   # Trimmed tree (Newick)
    │           └── Tree_EA_Ml.tree                 # General tree object (format unspecified)
    └── reference_seq_detail
        ├── EA_general_align.fasta                  # General sequence alignment
        ├── EA_genomeEnd_sequencesToSplice.consensus.fa    # Consensus FASTA for genome ends
        ├── EA_genomeEnd_sequencesToSplice.fa       # Genome end sequences to splice
        ├── EA_genomeEnd_sequencesToSplice.fa.bak001 # Backup of genome end sequences
        ├── EA_genomeStart_sequencesToSplice.consensus.fa  # Consensus FASTA for genome start
        ├── EA_genomeStart_sequencesToSplice.fa     # Genome start sequences to splice
        ├── Z00861838_spliced.fasta                 # Spliced sequence for sample Z00861838
        └── Z00861838.fasta                         # Original sequence for sample Z00861838

```

---

## 🗂️ Version Notes

- **V1** (October 2024): Initial release of the `EA_2024` primer set and reference.
