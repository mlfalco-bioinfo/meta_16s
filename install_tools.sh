#!/bin/bash

# Update and install basic dependencies
sudo apt-get update
sudo apt-get install -y wget curl git

# Install FastQC
echo "Installing FastQC..."
sudo apt-get install -y fastqc

# Install Trimmomatic
echo "Installing Trimmomatic..."
sudo apt-get install -y trimmomatic

# Install Miniconda for QIIME2
echo "Installing Miniconda..."
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh -b -p $HOME/miniconda
export PATH="$HOME/miniconda/bin:$PATH"
conda init

# Install QIIME2
echo "Installing QIIME2..."
wget https://data.qiime2.org/distro/core/qiime2-2023.2-py38-linux-conda.yml
conda env create -n qiime2-2023.2 --file qiime2-2023.2-py38-linux-conda.yml
conda activate qiime2-2023.2

# Install R and necessary packages
echo "Installing R and necessary packages..."
sudo apt-get install -y r-base
R -e "install.packages(c('phyloseq', 'ggplot2', 'dplyr', 'vegan'), repos='http://cran.rstudio.com/')"

echo "Installation complete. Please activate the QIIME2 environment with 'conda activate qiime2-2023.2' before running the pipeline."
