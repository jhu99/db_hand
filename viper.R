#######Mask non-zeros of matrix mt at a probability of rt###########################
mask<-function(mt,rt){
  ind <- which(mt>0.004321375)
  pb <- runif(length(ind))
  mask_ind <- ind[which(pb<rt)]
  yr <- mt[mask_ind]
  mt[mask_ind] <- 0.004321374
  mdata <- list(mt=mt,yr=yr,mask_ind=mask_ind,rt=rt)
  return(mdata)
}
######################################
library(VIPER)
load("./sc_test_data.RD")
remove(md)
for(pb in c(0.01,0.05,0.1)){
  for(rp in 1:10){
      cn<-500
      print(c(rp,cn))
      ind_gene_5k <- sample(ind_gene_name_common,5000,replace = FALSE)
      rand_sc_mdc <- sample(1:18677, cn, replace = FALSE)
      rand_sc_mdc <- sort(rand_sc_mdc)
      mdc_5k_100cells <- mdc[ind_gene_5k,rand_sc_mdc]
      mdc_mask<-mask(mdc_5k_100cells,pb)
      save(rand_sc_mdc,mdc_mask,mdc,file = "sc_viper_xxx.RD")
      gene.expression <- as.data.frame(mdc_mask$mt)
      fn <- paste("./result/viper",pb,rp,cn,sep = "-")
      dir.create(fn)
      res <- VIPER(gene.expression, num = 5000, percentage.cutoff = 0.1,
                   minbool = FALSE, alpha = 0.5, report = TRUE, outdir = fn)
      fn <- paste("./result/viper",pb,rp,cn,".RD",sep = "-")
      save(rand_sc_mdc,ind_gene_5k,mdc_mask,res,file = fn)
  }
}
