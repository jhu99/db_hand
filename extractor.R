library("rentrez");
efetch <- function(db,ids,folder)
{
  for(gi in ids){
    outfile <- paste(folder,paste(c(gi,"fasta"),collapse = "."),sep = "")
    sq <- entrez_fetch(db,id=gi,rettype = "fasta")
    write(sq,file = outfile)
    outfile <- paste(folder,paste(c(gi,"xml"),collapse = "."),sep = "")
    sq <- entrez_fetch(db,id=gi,rettype = "native")
    write(sq,file = outfile)
    outfile <- paste(folder,paste(c(gi,"gp"),collapse = "."),sep = "")
    sq <- entrez_fetch(db,id=gi,rettype = "gp")
    write(sq,file = outfile)
  }
}


