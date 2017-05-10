source("extractor.R")
datafolder="/Users/jialu/Research/datasets/"
network<-read.csv("/Users/jialu/Research/datasets/networks.tab",
                  header = TRUE,sep = "\t",stringsAsFactors = FALSE)
nodes <- c(network$interactorA,network$interactorB)
selected <- duplicated(nodes)
nodes <- nodes[!selected]
resultfolder <- "/Users/jialu/Research/datasets/ncbi_db_protein/"
for(query in nodes){
  es  <- entrez_search(db="protein",term = query)
  geneID <- es$ids
  es <- efetch(db = "protein",ids = geneID, folder = resultfolder) 
}


