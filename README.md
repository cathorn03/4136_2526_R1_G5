# LIFE4136, Rotation 1, Group 5

This repo contains the scripts and enviroment `.ymml` files for Group 5 of 
rotation 1 in LIFE4136.

## Introduction

This repo

## Repository Layout

This repo contains two directories:
- envs
- scripts

### envs

Contains `.yml` files for each of the conda environments used by the scripts.
The below code will install all the conda environments when used within the envs directory.

```{bash}
conda install -f QC.yml
conda install -f assemblies.yml
conda install -f quast.yml
conda install -f annotation.yml
```

### scripts

Contains all the scripts

## Software

The environments provided contain the following software, each is provided with the version, and which enviroment

| Software  | Version | Environment | GitHub Link |
| --------- | ------- | ----------- | ----------- |
| FastQC    | 0.12.1  | QC          | https://github.com/s-andrews/FastQC |
| NanoPlot  | 1.46.2  | QC          | https://github.com/wdecoster/NanoPlot |
| Unicycler | 0.5.1   | assemblies  | https://github.com/rrwick/Unicycler |
| minimap2  | 2.30    | assemblies  | https://github.com/lh3/minimap2 |
| Racon     | 1.5.0   | assemblies  | https://github.com/isovic/racon |
| Quast     | 5.0.2   | quast       | https://github.com/ablab/quast |
| Prokka    | 1.13    | annotation  | https://github.com/tseemann/prokka |
| Genovi    | 0.4.3   | annotation  | https://github.com/robotoD/GenoVi |

## User File Layout

To run the initial script reads must be split into directories named `long_reads` and `short_reads`.
All reads need to be in a `fastq.gz` format. Short reads must have forward and reverse reads identified with `R1` and `R2` respectively.

Reference genomes should be placed in a directory named `reference`. It should contain a `.fna` file named `genome` and a `.gff` file named `annotated`.

The scripts can either be placed in the working directory, or the folder can be placed within the same directory, and the scripts ran from outside of the scripts folder.
For each script a command is provided to run the scripts as is the scripts directory from this repo was coppied into the working directory.
# Script Overview

#### 1_Read_merge.sh

This script merges the long and short reads respectively.

Inputs:

 - `./short_reads/*.fasta.gz`
 - `./long_reads/*.fasta.gz`

Outputs:

 - `./short_reads/merged_sr_R1.fastq.gz`
 - `./short_reads/merged_sr_R2.fastq.gz`
 - `./short_reads/merged_sr.fastq.gz`
 - `./long_reads/merged_lr.fastq.gz`
 
#### 2a_Short_QC.sh

Runs FastQC on each of the merged short read fasta.gz files. 
Creates a directory named `QC` with the sub-directory `FastQC` for the output files.

Runs using the `QC` environment.

Inputs:

 - `./short_reads/merged_sr_R1.fastq.gz`
 - `./short_reads/merged_sr_R2.fastq.gz`
 - `./short_reads/merged_sr.fastq.gz`

Outputs:

 - `./QC/short`
 
#### 2b_Long_QC.sh

Runs NanoPlot on the merged long read fasta.gz files.
Creates a directory named `QC` with the sub-directory `FastQC` for the output files.

Runs using the `QC` environment.

Inputs:

 - `./long_reads/merged_lr.fastq.gz`
 
Outputs:

 - `./QC/long/`

#### 3_Assemblies.sh

`Unicycler` is used to generate three assemblies from the reads: a short read assembly, a long read assembly, and a hybrid assembly.
These are outputted to the directory `assemblies` with the sub directories `short`, `long` and `hybrid` containing the respective assemblies.

Uses the conda enviroment `assemblies`

Inputs:

 - `./short_reads/merged_sr_R1.fastq.gz`
 - `./short_reads/merged_sr_R2.fastq.gz`
 - `./long_reads/merged_lr.fastq.gz`
 
Outputs:

 - `./assemblies/short/`
 - `./assemblies/long/`
 - `./assemblies/hybrid/`
 
#### 4_Polished_assembly.sh

A fourth assembly is made by polishing the long read assembly by using the short read.
An overlap file is made with `minimap2` between the long read assembly and short reads in a `.sam` format.
`Racon` uses the overlap file to polish the long read assembly.
The command `fold` is called to convert the `Racon` output from a single line `.fasta` to a multi-line `.fasta`.
The final polished assembly is named `ml_polished.fasta` and found in `./assemblies/long/`.

Uses the `assembly` enviroment.

Inputs:

 - `./short_reads/merged_sr.fastq.gz`
 - `./assemblies/long/assembly.fastq`
 
Outputs:

 - `./assembly/short_vs_L_assembly.sam`
 - `./assembly/long/polished.fasta`
 - `./assembly/long/ml_polished.fasta`

#### 5_Quast.sh

`Quast` is then ran to perform QC on the four assemblies. An output directory named `quast` is also created.

Uses the `assemblies` environment.

Inputs:

 - `./assemblies/short/assembly.fasta`
 - `./assemblies/long/assembly.fasta`
 - `./assemblies/hybrid/assembly.fasta`
 - `./assemblies/long/ml_polished.fasta`
 - `./reference/genome.fna`
 - `./reference/anotated.gff`

Outputs:

 - `./quast/`

#### 6_Annotation.sh

Runs `prokka` on all four assemblies to annotate them.
The script assumes the reads are from an archaeal species. This can be changed by altering the variable `KINGDOM`.

The scripts creates an output directory,`annotations` with the sub-directories `short_reads`, `long_reads`, `hybrid`, and `polished`.
Each contains the annotations for the respective assemblies.

Uses the `annotation` environment.

Inputs:

 - `./assemblies/short/assembly.fasta`
 - `./assemblies/long/assembly.fasta`
 - `./assemblies/hybrid/assembly.fasta`
 - `./assemblies/long/ml_polished.fasta`
 
Outputs:

 - `./annotations/short/`
 - `./annotations/long/`
 - `./annotations/hybrid/`
 - `./annotations/long/`

#### 7_Genovi.sh

Runs `genovi` on all the Prokka files. These are outputted to the directory `genovi`.
It has subdirectories `short_reads`, `long_reads`, `hybrid`, and `polished`.
Each contains the genovi outputs for the respective assemblies.

Uses the `annotation` environment.

Inputs:

 - `./annotations/short_reads/PROKKA*.gbk`
 - `./annotations/long_reads/PROKKA*.gbk`
 - `./annotations/hybridPROKKA*.gbk`
 - `./annotations/polished/PROKKA*.gbk`
 
Outputs:

 - `./genovi/short/`
 - `./genovi/long/`
 - `./genovi/hybrid/`
 - `./genovi/polished/`

## Usage

Copy the scripts folder into the directory you want to run the analysis in.

```{bash}
cp -r /path/to/4136_2526_R1_G5/scripts /path/to/directory/
```

In the working directory place all short reads into a directory named `short_reads` and all long reads into a directory named `long_reads`.

```{bash}
mkdir short_reads
cp /path/to/ShortReads/*.fasta.gz ./short_reads/

mkdir long_reads
cp /path/to/LongReads/*.fasta.gz ./long_reads/
```

The reference genome `.fna` files and `.gff` files need to be put into directory named `reference` in the working directory. 
The `.fna` needs to be named `reference.fna` and the `.gff` needs to be named `annotated.gff`

```{bash}
mkdir reference
cp /path/to/reference ./reference/reference.fna
cp cp /path/to/reference ./reference/annotated.gff
```

#### Merging .fasta.gz files

Run `1_read_merge.sh` with the following command.

```{bash}
sbatch ./scripts/1_Read_merge.sh
```

Of the short reads files containing merged forward reads (`merged_sr_R1.fastq.gz`), merged reverse reads(`merged_sr_R1.fastq.gz`),
and combined forward and reverse reads (`merged_sr.fastq.gz`). A merged long read file is made (`merged_lr.fasta.gz`).
The merged files are outputted into the directories containing the respective individual reads.

#### Quality Control

QC of the reads are carried out by the scripts `2a_Short_QC.sh` and `2b_Long_QC.sh` which handle the short and long reads respectively.
They create a directory named `QC` with a sub-directory of `short` or `long` dependent on the script. 
The two scripts can be ran independently and in any order as below.

```{bash}
sbatch ./scripts/2a_Short_QC.sh
sbatch ./scripts/2b_Long_QC.sh
```

The short reads are QCed using FastQC. 
Within `./QC/short/` a `.html` report and output `.zip` file is made for the each of the merged files (forward, reverse, both).

The long reads are QCed using NanoPlot.
In `./QC/long` a `.html` report is produced (`NanoPlot-report.html`) containing the QC results.
A file named `NanoStats.txt` containing a summary of the report is made.
Summary graphs of the data are outputted in both `.png` and `.html` formats, as well as a NanoPlot `.log` file.

#### Assemblies

4 assemblies are made by the scripts: one from the short reads, one from the long reads, a hybrid of short and long reads, and a long read assembly polished with the short reads.
`3_Assemblies.sh` creates the first 3 assemblies using Unicycler.

```{bash}
sbatch ./scripts/3_Assemblies.sh
```

A directory named `assemblies` is made with a sub-directory for each of the assemblies. In each sub-directory the assembly is named `assembly.fasta`.

The polished assembly is made from polishing the long read assembly (`./assemblies/long/assembly.fasta`) with the merged short reads (`./short_reads/merged_sr.fasta.gz`).
A `.sam` overlap file is made in `./assemblies`. Racon uses this to produce the polished assembly in `./assembly/long/`, named `polished.fasta`.
The output of Racon is a single line `.fasta` so for the following use of quast this is converted into a multi line `.fasta` (`./assemblies/long/ml_polished.fasta`)

```{bash}
sbatch ./scripts/4_Polished_assembly
```

All 4 assemblies are put through quast for QC.
This requires the reference genome for the organism in a `.fna` as well as an annotated sequence in a `.gff` format.

```{bash}
sbatch ./scripts/5_Quast.sh
```

An output directory is made containing the quast results (`./quast`). 
Detailed results can be found within `./quast/report.html` and `./quast/report.pdf`.

#### Annotations

The assemblies are annotated using Prokka. 
The sequences we analysed were archaeal, and as such the Prokka option `--kingodm` was set to `Archea`.
This can be altered by changing the variable `$KINGDOM` as required.

```{bash}
sbatch ./scripts/6_Annotations.sh
```

An output directory named `annotations` is made with sub-directories for each of the assemblies.

The Prokka `.gbk` files are then each put into GenoVi to produce a circular visualisations of the assemblies against the genome.
An output directory named `genovi` is made with sub-directories for each of the different assemblies.

```{bash}
sbatch ./scripts/7_Genovi.sh
```

For each assembly a `.png` and `.svg` file of the visualisation is made in the directory. 
These visualisations include ones depicting the contigs/chromosomes, and the genes which lie within.

A `.csv` file containing statistics about the assembly, named `*_gral_stats.csv` is produced.
This contains size, GC content, CDS, tRNA, and rRNA information about each contig.

These are coloured by their Clusters of Orthologous Groups (COG) categories and show different genomic features.
Along side these visualisations, several `.csv` files which containing statistics about the COG categories.
A `.png` of a histogram for the abundance of the different COG categories is also produced.

## Authors

Group 5:

  - Lingzhi Liu (mbxll1@nottingham.ac.uk)
  - Aahba Shailesh Salunkhe (mbxas28@nottingham.ac.uk)
  - Caleb Thornber (mbyct9@nottingham.ac.uk)




