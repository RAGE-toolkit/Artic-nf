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

## Alternatively you can run the below command to execute the pipeline
```
nextflow main.nf \
 --params.meta_file "meta_data/sample_sheet.csv" \
 --params.fast5_dir "projects/fast5/" \
 --params.guppy_dir "projects/ont-guppy-cpu/bin/" \
 --params.primer_schema "projects/Artic-nf/meta_data/primer-schemes/" \
 --params.guppy_barcode_kits "EXP-NBD104" \
 --params.output_dir "results"
```

![Alt text](/img/workflow.png)
