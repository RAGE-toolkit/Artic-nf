Rampart installation for MacOS arm64
```shell
#create and activate environment
$conda env create -name artic-rampart
$conda activate artic-rampart

#Other dependencies and rampart 
$mamba install python=3.8
$mamba install minimap2
$mamba install nodejs

$curl -L -o rampart-1.2.0-0.tar.bz2 \
     "https://anaconda.org/artic-network/rampart/1.2.0/download/noarch/rampart-1.2.0-0.tar.bz2"
$conda install rampart-1.2.0-0.tar.bz2
$mamba install snakemake
$mamba install biopython

#running the test run
$rampart --protocol ~/Documents/GitHub/Artic-nf/meta_data/primer-schemes/rabvPeru2/V1/ --basecalledPath ~/Documents/GitHub/Artic-nf/test_data/fastq_pass
```
