# LIFE4136, Rotation 1, Group 5

This repo contains the scripts and enviroment `.ymml` files for Group 5 of 
rotation 1 in LIFE4136.

## Introduction


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

## Software

The environments provided contain the following software, each is provided with the version, and which enviroment

| Software | Version | Environment |
| --- | --- | --- |
| FastQC | 0.12.1 | QC |
| NanoPlot | 1.46.2 | QC |
| Unicycler | 0.5.1 | assemblies |
| minimap 2 | 2.30 | assemblies |
| Racon | 1.5.0 | assemblies |
| quast | 5.0.2 | quast |
| Prokka | 1.13 | annotation |
| Genovi | 0.4.3 | annotation |

## User File Layout

To run the initial script reads must be split into directories named `long_reads` and `short_reads`.
All reads need to be in a `fastq.gz` format. Short reads must have forward and reverse reads identified with `R1` and `R2` respectively.

Reference genomes should be placed in a directory named `reference`. It should contain a `.fna` file named `genome` and a `.gff` file named `annotated`.

The scripts can either be placed in the working directory, or the folder can be placed within the same directory, and the scripts ran from outside of the scripts folder.

## Script Overview

#### fastq_merge_QC.sh

This script merges the long and short reads respectively, then runs quality control for each.
Short read QC utilises `FastQC`, and `NanoPlot` is used for the long reads.

The QC outputs are put into a directory named `QC`, with sub directories `FastQC` and `NanoPlot`

This script requires the QC conda environment.

#### assemblies.sh

`Unicycler` is used to generate three assemblies from the reads: a short read assembly, a long read assembly, and a hybrid assembly.
These are outputted to the directory `assemblies` with the sub directories `short`, `long` and `hybrid` containing the respective assemblies.

A fourth assembly is made by polishing the long read assembly by using the short read.
An overlap file is made with `minimap2` between the long read assembly and short reads in a `.sam` format.
`Racon` uses the overlap file to polish the long read assembly.
The command `fold` is called to convert the `Racon` output from a single line `.fasta` to a multi-line `.fasta`.
The final polished assembly is named `ml_polished.fasta` and found in 

`Quast` is then ran to perform QC on the four assemblies. These get outputted to the directory `quast`.

#### annotation.sh

Runs `prokka` on all four assemblies to annotate them.
The script assumes the reads are from an archaeal species. This can be changed by altering the variable `KINGDOM`.

The scripts creates an output directory,`annotations` with the subdirectories `short_reads`, `long_reads`, `hybrid`, and `polished`.
Each contains the annotations for the respective assemblies.

#### genovi.sh

Runs `genovi` on all the Prokka files. These are outputted to the directory `genovi`.
It has subdirectories `short_reads`, `long_reads`, `hybrid`, and `polished`.
Each contains the genovi putputs for the respective assemblies.

## Workflow

## Usage

## Authors

Group 5:

  - Aahba Shailesh Salunkhe (mbxas28@nottingham.ac.uk)
  - Caleb Thornber (mbyct9@nottingham.ac.uk)
  - Lingzhi Liu (mbxll1@nottingham.ac.uk)



