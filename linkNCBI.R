source("extractor.R")
network<-read.csv("/Users/jialu/Research/datasets/networks.tab",
                  header = TRUE,sep = "\t",stringsAsFactors = FALSE)
nodes <- c(network$interactorA,network$interactorB)
selected <- duplicated(nodes)
nodes <- nodes[!selected]
resultfolder <- "/Users/jialu/Research/datasets/ncbi_db_protein/"
nodes_acc_gi_file <- "/Users/jialu/Research/datasets/acc_gi.tab"
for(query in nodes){
  es  <- entrez_search(db="protein",term = query)
  geneID <- es$ids
  for(gi in geneID){
    write.table(paste(c(gi,query),collapse = "\t"),file = nodes_acc_gi_file,append = TRUE,row.names = FALSE,col.names = FALSE,quote = FALSE)
  }
  es <- efetch(db = "protein",ids = geneID, folder = resultfolder) 
}


