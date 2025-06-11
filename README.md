# 🧬 Artic-nf

The `Artic-nf` workflow is designed for Oxford Nanopore (ONT) sequencing data, handling input in various formats—including `.fastq`, `.fast5`, `.pod5`, and live basecalled directories (`fastq_pass`)—to generate consensus sequences for a given sample set.

This pipeline is based on the [ARTIC Network’s fieldbioinformatics](https://github.com/artic-network/fieldbioinformatics) toolkit, which we have adapted and customised specifically for **rabies virus** genome analysis.

---

## 📥 Quick Navigation

Click below to jump directly to the install instructions for your operating system:

- [🔧 Linux / WSL](#installation-linuxwsl)
- [🍎 macOS (M1/M2/M3)](#installation-apple-silicon-m1m2m3)
- [🍏 macOS (Intel x86_x64)](#installation-for-mac-x86_x64)
- [💡 General Instructions for All Mac Users](#general-information-for-all-the-mac-architecture-m1m2m3-and-intel-x86_x64)

---

## ❓ Check Your Operating System

Before proceeding, it's useful to confirm your operating system and architecture.

```bash
uname -a
```

For Python-based checks (e.g., for Apple Silicon):

```python
python3
import platform
platform.machine()
```

---

## Installation (Linux/WSL)

```bash
git clone https://github.com/RAGE-toolkit/Artic-nf.git
cd Artic-nf
conda env create --file environment.yml
conda activate artic-nf
```

### 🧠 Dorado Basecaller Setup

Dorado must be downloaded manually from Oxford Nanopore:  
👉 [https://github.com/nanoporetech/dorado](https://github.com/nanoporetech/dorado)

Make sure to download the correct version for your system.

Assume you’ve downloaded `dorado-0.7.2-linux-x64.tar.gz`:  
⚠️ **Make sure to adjust this command if your downloaded file has a different version or name.**

```bash
tar -xvzf dorado-0.7.2-linux-x64.tar.gz
cd dorado-0.7.2-linux-x64/bin/
./dorado download --model all
mkdir models
mv dna_r* models
mv rna00* models
mv models/ ./../
```

Your Dorado directory structure should now resemble:

```
dorado-0.7.2-linux-x64/
├── bin/
│   ├── dorado
│   └── ...
├── models/
│   ├── dna_r10...
│   └── rna00...
```

### 🔗 Adding Dorado Path to Your Environment Variable

To make Dorado available system-wide, you need to add its binary and model directories to your shell’s environment variables.

#### 🕵️‍♀️ Step 1: Determine Your Shell

Run the following to find out which shell you're using:

```bash
echo $SHELL
```

Typical outputs:
- `/bin/bash` → edit `~/.bashrc` (or `~/.bash_profile` on macOS)
- `/bin/zsh` → edit `~/.zshrc`

> ⚠️ On **macOS**, `~/.bash_profile` is often used instead of `~/.bashrc`.

#### 🛠 Step 2: Add Dorado to Your Shell Profile

Edit the appropriate file (e.g., `~/.bash_profile`, `~/.bashrc`, or `~/.zshrc`) and add the following lines:

```bash
export PATH="$PATH:/home/<user>/path/to/dorado-x.y.z/bin"
export DORADO_MODEL="/home/<user>/path/to/dorado-x.y.z/models"
```

Replace `<user>` and paths with your actual directory structure.

#### 🔁 Step 3: Apply the Changes

After saving the file, run:

```bash
source ~/.bash_profile   # if you edited bash_profile
# or
source ~/.bashrc         # if you edited bashrc
# or
source ~/.zshrc          # if you use zsh
```

This ensures your changes take effect in your current terminal session.

---

## Installation (Apple Silicon M1, M2, M3)

⚠️ **Make sure your Miniforge or Conda setup supports `arm64`.**

Clone the base environment:

```bash
conda create --name artic_nf --clone base
conda activate artic_nf
```

Check platform:

```python
python3
import platform
platform.machine()  # Should return 'arm64'
```

Install required tools:

```bash
conda install nextflow=23.10.1
pip install medaka==1.8.2
```

### 🔧 Compile bcftools (required):

```bash
mamba install wget
wget https://github.com/samtools/bcftools/releases/download/1.19/bcftools-1.19.tar.bz2
tar -xvjf bcftools-1.19.tar.bz2
cd bcftools-1.19
./configure
make
make install
```

---

## Installation for Mac (x86_x64)

```bash
git clone https://github.com/RAGE-toolkit/Artic-nf.git
cd Artic-nf
CONDA_SUBDIR=osx-64 mamba env create -f environment.yml
conda activate artic_nf
conda config --env --set subdir osx-64
```

> ⚠️ This method is **untested**, proceed with caution.

---

## 💡 General Information for All Mac Architectures (M1, M2, M3 and Intel)

If you're analysing raw `.fast5` or `.pod5` data, you must download and configure **Guppy** or **Dorado** for basecalling and demultiplexing.

After downloading Dorado:

```bash
# Navigate to Dorado's bin directory
cd dorado-x.y.z/bin/
xattr -d com.apple.quarantine dorado
```

For Guppy:

```bash
# Navigate to Guppy's bin directory
cd guppy/bin/
xattr -d com.apple.quarantine guppy
```

> ⚠️ **Mac users must read this section regardless of which install instructions they followed.**

---

## 🚀 Running the Workflow

### Option 1: Use nextflow.config

Edit parameters in `nextflow.config`, then run:

```bash
nextflow main.nf
```

### Option 2: Command Line Parameters

```bash
nextflow main.nf --meta_file "meta_data/sample_sheet.csv" \
--rawfile_type "fastq" \
--rawfile_dir "fastq_pass/" \
--dorado_dir "/path/to/dorado" \
--primer_schema "meta_data/primer-schemes" \
--kit_name "SQK-NBD114-24" \
--output_dir "results" \
--weeSAM "/path/to/weeSAM" \
--dorado_config "dna_r10.4.1_e8.2_400bps_fast@v4.2.0" \
--dorado_run_mode "cuda:0" \
--seq_len 350 \
--medaka_normalise 200 \
--threads 5 \
--medaka_model "r941_min_fast_g303" \
--fq_extension ".fastq" \
--basecaller "Dorado" \
--fastq_dir "raw_files/fastq" \
-resume
```

> ✏️ Edit paths and parameters as needed.

---

## 🧠 Memory Management

To run on laptops or low-RAM systems, adjust the `queueSize` parameter in `nextflow.config` to limit parallel processes:

```nextflow
queueSize = 1
```

---

## 🔍 Workflow Overview

![Workflow Overview](/img/workflow.png)