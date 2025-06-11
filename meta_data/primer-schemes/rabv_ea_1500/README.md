# Primer Schemes

This directory contains multiplex primer schemes for rabies virus whole genome sequencing, designed using **Primal Scheme** (http://primal.zibraproject.org/). These schemes are developed to accommodate regional genetic diversity, ensuring accurate amplification and sequencing of RABV genomes from various geographic areas.

---

## Geographic Areas

### 🌍 East Africa
- **Current Scheme:** `EA_2024`  
  - Designed in **2024** to replace the previous **rabv_ea** scheme, incorporating the latest genomic data from **Tanzania**, **Kenya**, and **Malawi**.
  - **Key Features:**
    - Expands coverage to include newly sequenced data from **Malawi**, improving the scheme's accuracy and inclusivity.
    - Introduces a new **700 bp amplicon scheme** for broader genome coverage, in addition to the previous ~400 bp scheme.
  - **rabv_ea** V1 was designed in 2018 to accommodate **Kenya's** diversity and replaced **rabvTanzDg**, which was designed in 2016 to target Tanzanian RABV strains.

- **Previous Scheme:** `rabv_ea`  
  - Designed in 2018 to replace **rabvTanzDg**, expanding coverage to include genetic diversity found in **Kenya**, which includes an additional lineage **Cosmo AF1a** in addition to **Cosmo Af1b**.
  - Targeting broader **East African** diversity, this scheme is suitable for sequencing RABV from multiple countries in the region. 

- **Previous Scheme:** `rabvTanzDg`  
  - Designed in 2016 specifically for **Tanzania**, focusing on known RABV diversity from the region. Replaced by `EA_2024` to accommodate more diverse regional strains.

---

### 🇵🇪 Peru
- **Current Scheme:** `rabvPeru2` V3  
  - Edited version of **rabvPeru V2**, released in **2023**.  
  - Modifications include:
    - Alternate primers for amplicons 4left, 34right, 38left.
    - Complete replacement of the original **V1** primer for amplicon 40right.
  - This scheme is tailored for sequencing **rabies virus** from **Peru**, considering the unique genetic diversity of the region.

---

### 🇵🇭 Philippines & Southeast Asia
- **Current Scheme:** `rabvSEasia` V1  
  - Specifically designed to target the **Southeast Asia** lineages of **rabies virus**.
  - Focuses on regional diversity within Southeast Asia, ensuring comprehensive amplification of RABV strains from this geographic area.
  - Has not been tested on samples outwith the Philippines

---

### 🇳🇬 Nigeria
- **Current Scheme:** `rabvNig` V1  
  - Designed in **2022** to target genetic diversity found in **Nigeria**.
  - This scheme is based on the available genomic sequence for dog-associated rabies virus from the region, which at the time of design was limited to one genome on NCBI GenBank
---

## Notes
- These schemes are designed to ensure optimal performance for amplicon-based sequencing and genome assembly across regions with varying RABV genetic diversity.
- For each geographic area, multiple versions of the primer schemes may exist, with the most current version specified above.
- Older versions of the schemes may not be suitable for use in new sequencing efforts due to updates in primer design and expanded regional coverage.

---

For more detailed information on each scheme, refer to the specific folder for each region, where additional documentation, reference genomes, and primer files are available.