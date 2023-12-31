# Artic-nf
## Installation instructions are as follows
```
conda env create --name environment.yml
conda activate artic_nf
```
If the above fails, then follow the manual_package_install.txt

If you want to save the paramets for long time (output_dir, fast5_dir, guppy_basecaller path) edit it in "nextflow.config" and run the below command. 
## Pipeline can be run as follows
```
 nextflow main.nf
```

## Other wise execute the below command
```
nextflow main.nf \
 --meta_file "meta_data/sample_sheet.csv" \
 --fast5_dir "projects/fast5/" \
 --guppy_dir "projects/ont-guppy-cpu/bin/" \
 --primer_schema "projects/Artic-nf/meta_data/primer-schemes/" \
 --guppy_barcode_kits "EXP-NBD104" \
 --output_dir "results"
```

![Alt text](/img/workflow.png)
