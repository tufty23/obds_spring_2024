#!/bin/bash
##########################################################################
## A script template for submitting batch jobs. To submit a batch job, 
## please type
##
##    sbatch myprog.sh
##
## Please note that anything after the characters "#SBATCH" on a line
## will be treated as a Slurm option.
##########################################################################

## Specify a partition. Check available partitions using sinfo Slurm command.
#SBATCH --partition=short

## The following line will send an email notification to your registered email
## address when the job ends or fails.
#SBATCH --mail-type=END,FAIL

## Specify the amount of memory that your job needs. This is for the whole job.
## Asking for much more memory than needed will mean that it takes longer to
## start when the cluster is busy.
#SBATCH --mem=10G

## Specify the number of CPU cores that your job can use. This is only relevant for
## jobs which are able to take advantage of additional CPU cores. Asking for more
## cores than your job can use will mean that it takes longer to start when the
## cluster is busy.
#SBATCH --ntasks=12

## Specify the maximum amount of time that your job will need to run. Asking for
## the correct amount of time can help to get your job to start quicker. Time is
## specified as DAYS-HOURS:MINUTES:SECONDS. This example is one day.
#SBATCH --time=0-01:00:00

## Provide file name (files will be saved in directory where job was ran) or path
## to capture the terminal output and save any error messages. This is very useful
## if you have problems and need to ask for help.
#SBATCH --output=./mapped_reads/%j_%x.out
#SBATCH --error=./mapped_reads/%j_%x.err

## ################### CODE TO RUN ##########################
# Load modules (if required - e.g. when not using conda) 
# module load R-base/4.3.0

# Execute these commands 
# Will put the directory and environment here, but this would automatically work
# Submissions will inherit the environment from where you are submitting from

#I tried the below 2 codes to double check but doens't seem to work
#load_mamba && echo "mamba loaded sucessfully"
#cd /project/lina3946/1_linux/rnaseq

hisat2 --threads 12 \
       -x /project/shared/resources/1_linux/genomes/Mus_musculus/Ensembl/GRCm38/Sequence/HISAT/mm10 \
       -1 /project/lina3946/1_linux/rnaseq/fastq/ERR1755082_1.fastq.gz \
       -2 /project/lina3946/1_linux/rnaseq/fastq/ERR1755082_2.fastq.gz \
       --rna-strandness RF \
       --summary-file stats.txt \
       -S sampleERR1755082.sam 

# exercise 1
# 2 files so 2 threads and so 250mbx2=500mb (recomm in fastqc command) but will put 4GB (8fold estimate)
# this will be quite short so short queue and also 1 hour time not 1 day
# also put output and error messages in same output directory folder 

# exercise 2
# 12 files so 12 threads and so 250mbx12=4gb so 6gb with extra
# short, 1hr

# exercise 3
# hisat2 12 threads, 10GB
# short 1 hour
