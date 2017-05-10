source("extractor.R")
query <- "3cjh"
query <- "P32897"
query <- "homo sapiens[ORGN]"
datafolder="/Users/jialu/Research/datasets/"
network<-read.csv("/Users/jialu/Research/datasets/networks.tab",header = TRUE,sep = "\t")


resultfolder <- "/Users/jialu/Research/datasets/ncbi_db_protein/"
es  <- entrez_search(db="protein",term = query)
geneID <- es$ids
es <- efetch(db = "protein",ids = geneID, folder = resultfolder)

