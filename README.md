# Artic-nf
## Installation (Linux/WSL)
```
git clone https://github.com/RAGE-toolkit/Artic-nf.git
cd Artic-nf
conda env create --file environment.yml
conda activate artic_nf
```

## Installation (Apple Silicon)
```
git clone https://github.com/RAGE-toolkit/Artic-nf.git
cd Artic-nf
CONDA_SUBDIR=osx-64 mamba env create -f environment.yml
conda activate artic_nf
conda config --env --set subdir osx-64
```
Mac users may need to reset the attribute to enable the dorado basecaller execution. This can be done using following.
- Download the Dorado from https://github.com/nanoporetech/dorado"
- Locate to bin directory inside dorado folder using terminal
- Execute the below step as mentioned
```
xattr -d com.apple.quarantine dorado
```

### Downloading other modules/software
The workflow also requires weeSAM to be present to generate the summary stats. This need to be cloned seperately.
```
git clone https://github.com/centre-for-virus-research/weeSAM.git
```

## Handling CONDA installation Failure
Follow the manual_package_install.txt if the conda installation fails.

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
Change parameters, file/folder path accordigly 

![Alt text](/img/workflow.png)
