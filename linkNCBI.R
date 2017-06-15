source("extractor.R")
# network<-read.csv("/Users/jialu/Research/datasets/biogrid_net.tab",
#                    header = TRUE,sep = "\t",stringsAsFactors = FALSE)
# nodes <- c(network$interactorA,network$interactorB)
# selected <- duplicated(nodes)
# nodes <- nodes[!selected]
# save(nodes,file = "/Users/jialu/Research/datasets/nodes_list_biogrid.RData")
load("/Users/jialu/Research/datasets/nodes_list_str.RData")
resultfolder <- "/Users/jialu/Research/datasets/ncbi_db_protein/"
nodes_acc_gi_file <- "/Users/jialu/Research/datasets/ncbi_db_protein/00004_biogrid.tab"
gi_map=c()
gi_list=c()
for(i in 1:54155){
  query=nodes[i]
  print(i)
  i=i+1
  es  <- entrez_search(db="protein",term = query)
  geneID <- es$ids
  for(gi in geneID){
    #gi_list=c(gi,gi_list)
    write.table(c(query,gi),file = nodes_acc_gi_file,append = TRUE,row.names = FALSE,col.names = FALSE,quote = FALSE)
  }
}
#save(gi_list,gi_map,file = "/Users/jialu/Research/datasets/ncbi_db_protein/00000.RData")
#es <- efetch(db = "protein",ids = gi_list, folder = resultfolder) 
