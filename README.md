# Artic-nf
## Installation instructions are as follows
```
conda env create --name environment.yml
conda activate artic_nf
```
The workflow also requires weeSAM to be present to generate the summary stats. This need to be cloned seperately.
```
git clone https://github.com/centre-for-virus-research/weeSAM.git
```
If the above fails, then follow the manual_package_install.txt

If you want to save the paramets for long time (output_dir, fast5_dir, guppy_basecaller path) edit it in "nextflow.config" and run the below command. 
## Pipeline can be run as follows
```
 nextflow main.nf
```

## Alternatively you can run the below command to execute the pipeline (change the path accordingly)
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

![Alt text](/img/workflow.png)
