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
#######Pre-selection of candidate cells for a single cell###########################
library(glmnet)
ref_imputation <- function()
{
  pre_candidate_num <- 200
  len_mdc <- dim(mdc_mask$mt)[2]
  len <- dim(md)[2]
  pv <- vector(mode = "numeric",length = len)
  mis_ind_samples <- c()
  yp_predict_samples <- c()
  for(i in 1:100){
    print(i)
    mis_ind <- mdc_mask$mask_ind[mdc_mask$mask_ind > (5000*(i-1)) & mdc_mask$mask_ind <= (5000*i)]
    if(length(mis_ind)==0)
      next
    y<- mdc_mask$mt[,i]
    for(j in 1:len){
      x<- md_5K_selected[,j]
      sob<- summary(lm(y~x))
      pv[j] <- sob$coefficients[2,4]
    }
    candidates <- order(pv)[1:pre_candidate_num]
    x <- md_5K_selected[,candidates]
    fit <- cv.glmnet(x,y,type.measure = "mse")
    local_mis_ind <- mis_ind%%5000
    if(local_mis_ind[length(local_mis_ind)]==0){
      local_mis_ind[length(local_mis_ind)]<-5000
    }
    newx <- x[local_mis_ind,,drop=FALSE]
    yp <- predict(fit,newx = newx,s="lambda.min")
    yp_predict_samples <- c(yp_predict_samples,yp)
  }
  ct<-cor.test(yp,mdc_mask$yr)
  save(ct,file = "sc_ct.RD")
  return(ct)
}
#####Generate 10 test datasets for each pb in c(0.01,0.05,0.1)
load("sc_test_data.RD")
for(pb in c(0.01,0.05,0.1)){
  corest<-c()
  corpv<-c()
  print(pb)
  for(rp in 1:10){
    print(rp)
    ind_gene_5k <- sample(ind_gene_name_common,5000,replace = FALSE)
    rand_sc_mdc <- sample(1:18677, 100, replace = FALSE)
    rand_sc_mdc <- sort(rand_sc_mdc)
    md_5K_selected <- md[ind_gene_5k,]
    mdc_5K_100cells <- mdc[ind_gene_5k,rand_sc_mdc]
    mdc_mask<-mask(mdc_5K_100cells,pb)
    save(ind_gene_5k,rand_sc_mdc,mdc_mask,file = "sc_xxx.RD")
    ct <- ref_imputation()
    corest<-c(corest,ct$estimate)
    corpv<-c(corpv,ct$p.value)
  }
  fname<-paste("result",pb,rp,".RD",sep = "-")
  save(corest,corpv,file = fname)
}
