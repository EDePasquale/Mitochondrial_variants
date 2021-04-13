###########################
#                         #
# MAESTER Paper Revisions #
#    Erica DePasquale     #
#    Mon 12 Apr 2021      #
#                         #
###########################

# NC_012920 https://www.genome.jp/dbget-bin/www_bget?refseq:NC_012920
# 16569 bp

# "The total number of possible variants is 3x16,569+1=49,708 because the 
#  mitochondrial genome (NC_012920) is 16,569 bp with three possible variants 
#  each, except base 3,107, which has four possible variants (A, C, T, G) 
#  because the reference is N."

# Packages
library(dplyr)

# Read in reference mitochondrial genome
setwd("~/Documents/Projects/MAESTER")

mito_ref_orig=read.table("mito_reference.txt", stringsAsFactors = F) # https://www.genome.jp/dbget-bin/www_bget?-f+refseq+NC_012920
mito_ref=NULL
for(i in 1:nrow(mito_ref_orig)){
  mito_ref=paste0(mito_ref, mito_ref_orig[i,])
}
mito_ref=toupper(mito_ref)
mito_ref_sep=unlist(strsplit(mito_ref, split=""))

# Create base table
variant_table=matrix(nrow=49708, ncol=5)
variant_table[,1]=rep("MT", 49708)
variant_table[,5]=rep("+", 49708)

# Add start, end, and allele information for each nucleotide
start_row=1
for(i in 1:length(mito_ref_sep)){
  if(mito_ref_sep[i] == "N"){ # special case for base 3,107
    cell_range=start_row:(start_row+3)
    variant_table[cell_range, 2]=i
    variant_table[cell_range, 3]=i
  }else{
    cell_range=start_row:(start_row+2)
    variant_table[cell_range, 2]=i
    variant_table[cell_range, 3]=i
  } 
  for(j in cell_range){
    non_ref=setdiff(c("A", "C", "T", "G"), mito_ref_sep[i])
    variant_table[j, 4]=paste0(mito_ref_sep[i], "/", non_ref[which(cell_range==j)])
  }
  start_row=tail(cell_range, n=1)+1
}

write.table(variant_table, "variant_table.txt", sep="\t", row.names = F, col.names = F, quote=F)

# Process VEP results (http://feb2021.archive.ensembl.org/Homo_sapiens/Tools/VEP/Results?tl=7nVTR4F7LvanKnbJ-7217453)
VEP=read.table("VEP_results.txt", sep="\t", header=T) # had to manually remove leading pound to avoid header escape
keep_columns=c("Uploaded_variation",
               "Location",
               "Allele",
               "Consequence",
               "SYMBOL",
               "Gene",
               "Feature_type",
               "Feature",
               "BIOTYPE",
               "Amino_acids",
               "Codons",
               "SIFT",
               "PolyPhen")
VEP_redu=VEP[keep_columns] # why is this 49882 and not 49708?
#example 12986 and 12987, where the gene is different for the same site. This is fine

write.table(VEP_redu, "VEP_redu.txt", sep="\t", row.names = T, quote=F)

# Disease data from MitoMap
disease=read.table("disease.cgi.txt", sep="\t", stringsAsFactors = F, header=T) # https://www.mitomap.org/foswiki/bin/view/MITOMAP/Resources

# Polymorphism data from MitoMap
polymorphisms=read.table("polymorphisms.cgi.txt", sep="\t", stringsAsFactors = F, header=T) # https://www.mitomap.org/foswiki/bin/view/MITOMAP/Resources


# Create *pretty* table (sorry for the ugly code!)
rev_table=matrix(ncol=3, nrow=nrow(VEP_redu))
rev_table[,1]=as.numeric(gsub("_.*", "", gsub("MT_", "", VEP_redu$Uploaded_variation)))
rev_table[,2]=gsub("/.*", "", gsub(".*_", "", VEP_redu$Uploaded_variation))
rev_table[,3]=gsub(".*/", "", gsub(".*_", "", VEP_redu$Uploaded_variation))
rev_table=cbind(rev_table, VEP_redu[,4:13])
rev_table=cbind(temp1=paste0(rev_table[,1], "_", rev_table[,2], "_", rev_table[,3]),rev_table)
disease=cbind(temp1=paste0(disease[,2], "_", disease[,3], "_", disease[,4]), disease)
polymorphisms=cbind(temp1=paste0(polymorphisms[,2], "_", polymorphisms[,3], "_", polymorphisms[,4]), polymorphisms)
rev_table=left_join(rev_table, disease, by="temp1")
rev_table=rev_table[,-(15:19)]
rev_table=rev_table[,-19]
rev_table=left_join(rev_table, polymorphisms, by="temp1")
rev_table=rev_table[,-(19:26)]
rev_table=rev_table[,-1]
rev_table[is.na(rev_table)] <- "-"

rev_cols=c("Position",
           "Reference",
           "Variant",
           "Consequence",
           "Symbol",
           "Gene",
           "Feature type",
           "Feature",
           "Biotype",
           "Amino acids",
           "Codons",
           "SIFT",
           "PolyPhen",
           "Homoplasmy",
           "Heteroplasmy",
           "Disease",
           "Status",
           "GB Count",
           "GB Frequency")

colnames(rev_table)=rev_cols

write.table(rev_table, "rev_table.txt", sep="\t", row.names = T, quote=F) # need to remove first column (minus the header) upon first use


