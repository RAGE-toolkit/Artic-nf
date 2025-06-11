# 🇵🇪 Primer Set: `rabvPeru`

This folder contains the reference genome and primer scheme developed for amplicon-based sequencing and genome assembly of rabies virus (RABV) in **Peru**.  
Due to a lack of genome-level dog RABV data from Peru at the time, the scheme was designed using publicly available sequences from **Peru (non-genome)***, **neighbouring countries** and **newly sequenced archived Peruvian samples** based on information available in August 2019.

**Important:** **DO NOT USE THIS SCHEME**. This `rabvPeru` primer set was based on limited available data and did not perform well on Peruvian sequences. The diversity it targeted turned out to be unrepresentative of circulating viruses, so it was ultimately replaced with an improved scheme, `rabvPeru2`.

---

## 📌 Reference Genome

- **Virus:** Rabies virus  
- **Genome length:** 11,922 bp  
- **Source:** AB517659 from NCBI GenBank  
- **File:** `rabvPeru.reference.fasta`  
- **Reference ID:** AB517659

---

## 🧪 Primer Design Overview

The development of the `rabvPeru` primer scheme followed a multi-step process to overcome limited availability of dog RABV genetic data in Peru.

### 1. Initial Efforts with Archived Samples

- Sequencing was attempted on **three archived, non-bat RABV samples** from Peru, shared by the **Streicker group (University of Glasgow)**.
- The **rabv_ea** primer set (originally designed for East African RABV) was used.
- Sequencing was only partially successful, producing **gappy data**—insufficient for full genome recovery.

---

## 🧬 Public Sequence Curation

### 2. Mining Partial N Gene Sequences

To inform primer design, available **nucleoprotein (N) gene** sequences were collected and curated using **[RABV-GLUE](http://rabv-glue.cvr.gla.ac.uk/#/home)**:

- **Inclusion criteria:** Sequences from Peru not associated with bat clades.
- **Additional search:** Included entries with missing country metadata (`country=NULL`) but “Per” in the isolate ID.
  - This added 5 extra sequences (`peru_misc.fasta`).
  - Only one (KU963490, labelled *“PeruDog”*) was retained.
  - The others were either bat-associated or unrelated to Peru.

### 3. Alignment Strategy

Two alignments were prepared:

- `peru_nonBatClade_n40`: 40 Peru sequences (excluding KU963490)
- `peru_nonBatClade+misc1_n41`: Same as above, plus KU963490

Each alignment included **outgroup sequences**:
- **EU293115** (French fox) or  
- **FJ712193** (Chinese dog)  
— to support phylogenetic analysis and help resolve evolutionary relationships.

---

## 🧬 Clade Assignment & Reference Selection

### 4. Clade Identification

Using **RABV-GLUE** automated genotyping:

- All Peruvian N gene sequences were assigned to the **Cosmopolitan clade**.
- Most had **undetermined minor clades**, except for a few identified as **Cosmopolitan AM3a**.
- One of the three Glasgow-derived sequences (NB09) also belonged to **Cosmo AM3a**.

### 5. Closest Available References

Two potential clade affiliations complicated reference selection:

| Minor Clade | Closest Reference | Notes |
|-------------|-------------------|-------|
| **AM3a**    | AB517659 (Brazil, ~2012) | Based on NB09 + public data |
| **AF1a**    | KX148194 (Morocco, 1989) | Used for samples with undetermined clade |

---

## 🧬 Reference Panel Construction

To account for this ambiguity, multiple reference sequences were created and evaluated:

1. **99% consensus** from the 41 Peruvian N gene sequences  
2. **KX148194** – Full-genome reference from Morocco  
3. **NB09 + AB517659 (AM3a)** – Spliced to form a near-complete AM3a reference  
4. **NB08 + NB11 (Glasgow)** – Used to form a second consensus reference  

Two reference panels were tested:
- One **prioritising AF1a** (KX148194-based, `peru_seq4primers_v4.fasta`)
- One **prioritising AM3a** (spliced NB09+AB517659, `peru_seq4primers_v5.fasta`)

- Primers were designed using **PrimalScheme** based on the preferred AM3a-aligned reference panel.
---


## 🧬 Primer Scheme Details

- **Scheme Name:** `rabvPeru`  
- **Version:** `V1`  
- **Amplicon Size:** ~400 bp  
- **Number of Amplicons:** 41
- **File Formats:** BED / TSV  

---

### 🔑 Key Files

### 🔑 Key Files

- `glasgowRoof_lib2_peru.fasta`: Unaligned consensus sequences from Peruvian samples used in primer design  
- `glasgowRoof_lib2_peru_aln.fasta`: Aligned version of Peruvian consensus sequences  
- `combinedSamples/glasgowRoof_lib2_peruprelimMapped.consensus.fasta`: Consensus from pooled Peru samples, used for initial mapping  
- `Samerica_RABV_WGS.fasta`: South American reference genomes for contextual phylogeny  
- `consensus_UniqueSequences_peru_nonBatClademisc1_n41_aln.fasta`: Final 41-sequence alignment used for phylogenetic analysis  
- `RAxML_bestTree.peru_Aug19andCuratedTree`: Maximum likelihood phylogenetic tree  
- `peru_nonBatClade+misc1_n41.fasta`: Key sequence set for scheme development  
- `peru_nonBatClade+misc1_n41_metadata.txt`: Metadata accompanying key sequences  
- `peru_nonBatClade+misc1+outgp_aln.fasta.reduced`: Reduced alignment with outgroup used in tree inference  
- `KX148194.fasta` / `AB517659.fasta`: Representative WGS references from other regions (AF1a and AM3a)

---

## 📁 File Contents

```
.
├── README.md                                      # Project overview and background info
└── V1                                             # Primer scheme version 1
├── primer_design                              # Primer design process files
│   ├── glasgow_sequenced                      # Sequences generated from archived Peruvian samples
│   │   ├── normal_pipeline                    # Standard consensus and alignment pipeline
│   │   │   ├── closest_WGS
│   │   │   │   ├── AB517659.fasta             # AM3a reference from Brazil
│   │   │   │   └── KX148194.fasta             # AF1a reference from Morocco
│   │   │   ├── combinedSamples
│   │   │   │   └── glasgowRoof_lib2_peruprelimMapped.consensus.fasta  # All 3 consensus from Peru samples sequenced in Glasgow
│   │   │   ├── glasgowRoof_lib2_NB08prelimMapped.consensus.fasta      # Sample NB08 consensus
│   │   │   ├── glasgowRoof_lib2_NB09prelimMapped.consensus.fasta      # Sample NB09 consensus
│   │   │   ├── glasgowRoof_lib2_NB11prelimMapped.consensus.fasta      # Sample NB11 consensus
│   │   │   ├── glasgowRoof_lib2_peru_aln.fasta                         # Aligned sample sequences
│   │   │   ├── glasgowRoof_lib2_peru.fasta                             # Unaligned sample sequences
│   │   │   └── SouthAmericaWGS
│   │   │       └── Samerica_RABV_WGS.fasta     # Regional whole-genome sequences
│   │   └── tree
│   │       ├── consensus_UniqueSequences_peru_nonBatClademisc1_n41_aln.fasta  # 41-sequence alignment for tree
│   │       ├── peru_Aug19andCurated_aln.fasta.reduced                          # Reduced alignment for RAxML
│   │       ├── RAxML_bestTree.peru_Aug19andCuratedTree                         # Best maximum likelihood tree
│   │       ├── RAxML_bipartitions.peru_Aug19andCuratedTree                     # Bipartition support tree
│   │       ├── RAxML_bipartitionsBranchLabels.peru_Aug19andCuratedTree         # Tree with branch labels
│   │       ├── RAxML_bootstrap.peru_Aug19andCuratedTree                        # Bootstrap replicates
│   │       └── RAxML_info.peru_Aug19andCuratedTree                             # RAxML run information
│   ├── GLUEsequenceSets                         # Curated sequence sets from RABV-GLUE
│   │   ├── 3553@2010.fasta                      # Individual curated genome (labelled)
│   │   ├── BrazilWGS.fasta                      # Brazilian whole genomes
│   │   ├── peru_misc.fasta                      # Additional Peruvian sequences 
│   │   ├── peru_nonBatClade_n40_aln.fasta       # Alignment of 40 non-bat Peru sequences
│   │   ├── peru_nonBatClade_n40.fasta           # Unaligned 40-sequence panel
│   │   ├── peru_nonBatClade_n40.txt             # Metadata for 40-sequence set
│   │   ├── peru_nonBatClade_n40+outgrp_aln.fasta       # Alignment with outgroup
│   │   ├── peru_nonBatClade_n40+outgrp.fasta           # Unaligned with outgroup
│   │   ├── peru_nonBatClade_n41.txt                    # Metadata for 41-sequence set
│   │   ├── peru_nonBatClade+misc1_n41_aln.fasta        # Alignment incl. 1 misc PeruDog seq
│   │   ├── peru_nonBatClade+misc1_n41_metadata.txt     # Metadata for 41-sequence + misc set
│   │   ├── peru_nonBatClade+misc1_n41.fasta            # Unaligned 41-sequence set
│   │   ├── peru_nonBatClade+misc1+outgp_aln.fasta      # Alignment incl. outgroup
│   │   ├── peru_nonBatClade+misc1+outgp_aln.fasta.reduced  # Reduced for tree building
│   │   ├── peru_nonBatClade+misc1+outgp.fasta              # Unaligned incl. outgroup
│   │   └── raxmlTrees
│   │       ├── 1
│   │       │   ├── peru_nonBatClade_n40.txt
│   │       │   ├── peru_nonBatClade_n40+outgrp_aln.fasta.reduced
│   │       │   ├── RAxML_bestTree.peru_1
│   │       │   ├── RAxML_bipartitions.peru_1
│   │       │   ├── RAxML_bipartitionsBranchLabels.peru_1
│   │       │   ├── RAxML_bootstrap.peru_1
│   │       │   └── RAxML_info.peru_1


```

## 🗂️ Version Notes

- **V1** (circa August 2019): Initial version of the `rabvPeru` primer set and reference genome.