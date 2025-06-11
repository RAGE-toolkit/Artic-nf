# 🧬 Artic-nf

This workflow is designed for **Oxford Nanopore Technologies (ONT)** data analysis. It supports raw files in `.fastq`, `.fast5`, `.pod5`, and live basecalled `fastq_pass` formats and produces consensus genome sequences from a given list of samples.

This pipeline is based on the [ARTIC Network’s fieldbioinformatics](https://github.com/artic-network/fieldbioinformatics)toolkit, which we have adapted and customised specifically for **rabies virus** genome analysis.
---

## ⚙️ Installation (Linux/WSL)

```bash
git clone https://github.com/RAGE-toolkit/Artic-nf.git
cd Artic-nf
conda env create --file environment.yml
conda activate artic-nf
```

### 🧾 Dorado Setup

Dorado must be downloaded manually from ONT:

📥 [Dorado Download](https://github.com/nanoporetech/dorado)

> Be sure to download the version that matches your **operating system and architecture**.

---

**⚠️ IMPORTANT:**  
The commands below use `dorado-0.7.2-linux-x64.tar.gz` **as an example**.  
✅ You **must replace** this with the actual filename of the Dorado version you downloaded.  
❌ Do **not** copy-paste without checking the filename.

---

**Example (for dorado-0.7.2-linux-x64.tar.gz):**
```bash
tar -xvzf dorado-0.7.2-linux-x64.tar.gz
cd dorado-0.7.2-linux-x64/bin/
./dorado download --model all
mkdir models
mv dna_r* models
mv rna00* models
mv models/ ./../
```

Your final `dorado` directory structure should look like this:

![Dorado directory structure](/img/dorado_dir_structure.png)

### ➕ Add Dorado to Environment Variables

Edit `.bashrc`:

```bash
vim ~/.bashrc
```

Add:
```bash
export PATH="$PATH:/home/<user>/<your_tool_directory>/dorado-0.7.2-linux-x64/bin"
export DORADO_MODEL='/home/<user>/<your_tool_directory>/dorado-0.7.2-linux-x64/models'
```

---

## 🍏 Installation (macOS M1, M2, M3 – Apple Silicon)

Use a clean conda environment:

```bash
conda create --name artic_nf --clone base
conda activate artic_nf
```

Verify architecture:
```python
python3
import platform
platform.machine()
```

✔️ Output should be: `arm64`  
❌ If not, reinstall Miniforge (arm64 build).

Exit Python with `Ctrl+D`.

Install required tools:

```bash
conda install nextflow=23.10.1
pip install medaka==1.8.2
```

Compile `bcftools`:

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

## 🍎 Installation (macOS Intel x86_64)

```bash
git clone https://github.com/RAGE-toolkit/Artic-nf.git
cd Artic-nf
CONDA_SUBDIR=osx-64 mamba env create -f environment.yml
conda activate artic_nf
conda config --env --set subdir osx-64
```

> ⚠️ This method is **not yet tested**.

---

## 🔔 Important for All macOS Users (M1, M2, M3, and Intel)

> 🛑 If you’re using macOS of any kind, **you must read this section** to configure basecalling tools properly!

To analyse `.fast5` or `.pod5` raw data, you must manually install and enable execution of **Dorado** or **Guppy** basecallers.

### 🧬 Dorado Setup (macOS)

- Download from [https://github.com/nanoporetech/dorado](https://github.com/nanoporetech/dorado)
- Navigate to `bin/` folder in Terminal:
```bash
xattr -d com.apple.quarantine dorado
```

### 🧬 Guppy Setup (Optional Alternative)

- Download from [https://community.nanoporetech.com/downloads](https://community.nanoporetech.com/downloads)
- Navigate to `bin/` folder in Terminal:
```bash
xattr -d com.apple.quarantine guppy
```

---

## 🧪 Running the Workflow

You can run the workflow by editing parameters in `nextflow.config` or by specifying them directly.

### Option 1 – Regular run

```bash
nextflow main.nf
```

### Option 2 – Custom arguments

```bash
nextflow main.nf --meta_file "meta_data/sample_sheet.csv" \
--rawfile_type "fastq" \
--rawfile_dir "/path/to/fastq_pass" \
--dorado_dir "/path/to/dorado" \
--primer_schema "/path/to/primer-schemes" \
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

> 🔧 Update all paths and arguments as needed.

---

## 🧠 Memory Management Tips

For laptops or low-RAM systems:

- Edit `nextflow.config`
- Set `queueSize = 1` or `2` to reduce parallelism and prevent memory errors.

---

## 🧱 Workflow Overview

![Workflow structure](/img/workflow.png)

---

## 🖥️ How to Check Your Operating System

Before beginning installation:

```bash
uname -a
```

Or, for detailed system info:
```bash
hostnamectl
```

Use this to determine whether to follow instructions for:
- Linux
- macOS Intel (x86_64)
- macOS Apple Silicon (arm64)
- Windows (via WSL)

---

## 📝 License & Acknowledgements

Based on the ARTIC Network's tools with modifications for rabies virus workflows. Developed by the RAGE Toolkit team.