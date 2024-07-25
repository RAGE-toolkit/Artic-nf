# Artic-nf
The workflow is designed for ONT data analysis from scratch, handling raw files in fast5/pod5/fastq_pass formats to produce a consensus sequences from a given list of samples. 
The basis of this workflow, including scripts and methodologies, is inspired by the resources available on [fieldbioinformatics](https://github.com/artic-network/fieldbioinformatics). 
However, we have tailored these elements specifically to support the analysis of Rabies virus data.

## Installation (Linux/WSL)
```
git clone https://github.com/RAGE-toolkit/Artic-nf.git
cd Artic-nf
conda env create --file environment.yml
conda activate artic-nf
```
Dorado requires manual downloading, and you can obtain it from the following link
```
https://github.com/nanoporetech/dorado.
```

After the download, it needs to be uncompressed and additional models need to be downloaded as indicated below.
```
tar -xvzf <path_to_dorado...tar.gz>
<path_to_dorado_main_dir>/bin
./dorado download --directory model
mv model ./../
```

## Installation (Apple Silicon M1,M2,M3)

For Mac M3 processor, make sure the Miniforge setup is supporting arm64. Cloning base directory as artic_nf to avoid loads of package installation.

```
conda create --name artic_nf --clone base
conda activate artic_nf
```

Run below python code to confirm the platform. 

```
python
import platform
platform.machine()
```

The output of above code should be **arm64**, otherwise, download the appropriate version of the Miniforge and re-install and run the above command to check the platform.
Once everything is set, run the below commands to install nextflow and and medaka.

```
conda install nextflow=23.10.1
pip install medaka==1.8.2
```

The workflow requires bcftools to be compiled manually. Which can be done with following steps.

```
mamba install wget
wget https://github.com/samtools/bcftools/releases/download/1.19/bcftools-1.19.tar.bz2
tar -xvzf bcftools-1.19.tar.bz2
cd bcftools-1.19
./configure
make
make install
```

## Installation for Mac (x86_x64)
```
git clone https://github.com/RAGE-toolkit/Artic-nf.git
cd Artic-nf
CONDA_SUBDIR=osx-64 mamba env create -f environment.yml
conda activate artic_nf
conda config --env --set subdir osx-64
```
**Note:** Installation for Mac x86_x64 method is not tested.

## General information for All the Mac architecture (M1,M2,M3 and Intel x86_x64)
 
If you are planning to analysis the raw data (*.fast5 or *.pod5), the user needs to download the Guppy or Dorado to perform the basecalling and barcoding. 
The Mac users may need to reset the attribute to enable the dorado basecaller execution. This can be done using following.
- Download the Dorado from https://github.com/nanoporetech/dorado"
- Locate to bin directory inside Dorado folder using terminal
- Execute the below step as mentioned

```
xattr -d com.apple.quarantine dorado
```
Similarly, Guppy can be setup as mentioned below.
- Download the Guppy from https://community.nanoporetech.com/downloads
- Locate to bin directory inside Guppy folder using terminal
- Execute the below step as mentioned

```
xattr -d com.apple.quarantine guppy
```

## Running the workflow
The workflow can be run using two ways. Edit the file paths and other parameters in "nextflow.conf" and follow the below step. 
### Regular way
```
 nextflow main.nf -c nextflow.conf
```

### Alternate
```
nextflow main.nf --meta_file "meta_data/sample_sheet.csv" \
--rawfile_type "fastq" \
--rawfile_dir "/home3/sk312p/task_dir/projects/Artic_nf_development_version/workshop/fastq_pass" \
--dorado_dir "/home3/sk312p/task_dir/tools/dorado-0.4.3-linux-x64" \
--primer_schema "/home3/sk312p/task_dir/projects/Artic_testing_Feb5/Artic-nf/meta_data/primer-schemes" \
--kit_name "SQK-NBD114-24" \
--output_dir "results" \
--weeSAM "/home3/sk312p/task_dir/tools/weeSAM" \
--dorado_config "dna_r10.4.1_e8.2_400bps_fast@v4.2.0" \
--dorado_run_mode "cuda:0" \
--seq_len 350 \
--medaka_normalise 200 \
--threads 5 \
--medaka_model \
"r941_min_fast_g303" \
--fq_extension ".fastq" \
--basecaller "Dorado" \
--fastq_dir "raw_files/fastq" \
-resume
```
**Note:** Change parameters, file/folder path accordigly

## Memory management
This section is beneficial for individuals intending to execute the workflow on a laptop or a small-scale system. Adjustments in settings can prevent the system from running out of memory. Typically, Nextflow processes multiple samples in parallel, which significantly increases the likelihood of encountering out-of-memory errors. To avoid this, you can modify the **queueSize** parameter within the **nextflow.config** file. It is advisable to set the **queueSize** to 1 or 2, depending on the capacity of your RAM/CPU.

## The workflow structure
![Alt text](/img/workflow.png)
