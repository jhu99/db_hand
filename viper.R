#######Mask non-zeros of matrix mt at a probability of rt###########################
mask<-function(mt,rt){
  ind <- which(mt>0)
  pb <- runif(length(ind))
  mask_ind <- ind[which(pb<rt)]
  yr <- mt[mask_ind]
  mt[mask_ind] <- 0
  mdata <- list(mt=mt,yr=yr,mask_ind=mask_ind,rt=rt)
  return(mdata)
}
######################################
library(VIPER)
load("./result/sc_mDC.RD")
remove(ds10,ds11,ds9)
mdc <- ds11v2[-1]
rownames(mdc) <- ds11v2$ENSEMBLID
mdc <- data.matrix(mdc)
ind_gene_name_common <- ds11v2$ENSEMBLID
celltype <-c(0,3731,6369,9564,12274,15765,18677)
for(pb in c(0.01,0.05,0.1)){
  for(rp in 1:6){
      print(c(pb,rp))
      ind_gene_5k <- sample(ind_gene_name_common,5000,replace = FALSE)
      one_cell_type <- (celltype[rp]+1):celltype[rp+1]
      mdc_5k_selected_cells <- mdc[ind_gene_5k,one_cell_type]
      mdc_mask<-mask(mdc_5k_selected_cells,pb)
      gene.expression <- as.data.frame(mdc_mask$mt)
      fn <- paste("./result/viper",pb,rp,sep = "-")
      dir.create(fn)
      fn2 <- paste("./result/viper",pb,rp,"data.RD",sep = "-")
      save(ind_gene_5k,mdc_mask,file = fn2)
      res <- VIPER(gene.expression, num = 5000, percentage.cutoff = 0.1,
                   minbool = FALSE, alpha = 0.5, report = TRUE, outdir = fn)
      fn <- paste("./result/viper",pb,rp,"res.RD",sep = "-")
      save(res,file = fn)
  }
}
