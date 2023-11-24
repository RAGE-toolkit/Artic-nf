# Artic-nf
MinION basecalling and consensus sequence generator.
## Installation
create artic-nf conda environment and activate it by running below command
```
conda env create -f env.yml
conda activate artic-nf
```
Add the fast5 files to the directory raw_files/fast5. By default the fastq files are saved to raw_files/fastq directory (directory gets created during the workflow execution). Any changes required to the output directory can be modified at nextflow.config file

workflow can be run using below commad
```
nextflow main.nf
```
### Following are the set of rules executed by artic_nf
![Alt text](/img/artic_wf.png)

### to be implemented
- Add run information to results (todo)
- Customize primer schema (todo)
- Add all the software version in a log file (todo)
- Add coverage summary (todo)
- Test it with real-time raw data (todo)
- Add guppy basecaller CPU/GPU option (todo)
- Add guppy config to the nextflow.config (done)
