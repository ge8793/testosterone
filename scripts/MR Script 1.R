rm(list=ls())
#load package MR Base
library(TwoSampleMR)
#authenticate study
ao <- available_outcomes()
#temporarily revert to old version to allow auth
devtools::install_github('MarkEdmondson1234/googleAuthR@v0.8.1')
#launch auth package
library(googleAuthR)
#authenticate again
ao <- available_outcomes()
#read the data in
testost_exp_dat <- mydata <- read.csv("/Users/ge8793/Documents/EBI DH Fellowship/R/Testosterone and Osteosarcoma/191028_Testost_SNP.csv", header=TRUE)
head(testost_exp_dat)
#add a final line to the file as is missing
cat("\n", file = file.choose(), append = TRUE)
#open the file again
testost_exp_dat <- mydata <- read.csv("/Users/ge8793/Documents/EBI DH Fellowship/R/Testosterone and Osteosarcoma/191028_Testost_SNP.csv", header=TRUE)
head(testost_exp_dat)
#turn the file into exposure data
testost_exp_data<-read_exposure_data("/Users/ge8793/Documents/EBI DH Fellowship/R/Testosterone and Osteosarcoma/191028_Testost_SNP.csv", clump = FALSE, sep = ",",
                                     phenotype_col = "Phenotype", snp_col = "SNP", beta_col = "beta",
                                     se_col = "se", eaf_col = "eaf",
                                     effect_allele_col = "effect_allele",
                                     other_allele_col = "other_allele", pval_col = "pval",
                                     units_col = "units", samplesize_col = "samplesize",
                                     gene_col = "gene", min_pval = 1e-200)
#install the default tools
devtools::install_github("MRCIEU/MRInstruments")
#find out what outcome studies are available on MR base
ao <- available_outcomes()
#see the header for this 
head(ao)
#search available studies 
ao[grepl("bone cancer", ao$trait), ]
#extract the snps from the outcome gwas
osarc_out_dat <- extract_outcome_data(
  snps = testost_exp_data$SNP,
  outcomes = 20948
)
#cleanup outcome data
cleanup_outcome_data(osarc_out_dat)
#see outcome data
extract_outcome_data()
#available outcomes
available_outcomes
#harmonise the 2 data sets
dat <- harmonise_data(
  exposure_dat = testost_exp_data, 
  outcome_dat = osarc_out_dat, action = 1
)

