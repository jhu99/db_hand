##Evaluation on proposed algorithm
medianL1_all<-c()
meanL1_all<-c()
mse_all <-c()
peason_corr_all <- c()
for(pb in c(0.01,0.05,0.1)){
  meanL1<-c()
  medianL1<-c()
  mse<-c()
  fn <- paste("result",pb,".RD",sep = "-")
  fn <- paste("result",fn,sep = "/")
  load(fn)
  peason_corr_all<-cbind(peason_corr_all,corest)
  for(rp in 1:10){
    fn <- paste("result",pb,rp,".RD",sep = "-")
    fn <- paste("result",fn,sep = "/")
    load(fn)
    x <- as.matrix(yp_predict_samples - mdc_mask$yr)
    meanL1<-c(mean(abs(x)),meanL1)
    medianL1<-c(median(abs(x)),medianL1)
    mse<-c(mean(x^2),mse)
  }
  meanL1_all<-cbind(meanL1_all,meanL1)
  medianL1_all<-cbind(medianL1_all,medianL1)
  mse_all<-cbind(mse_all,mse)
}
boxplot(peason_corr_all,names=c("1%","5%","10%"),xlab ="Percentage of masking data",
        ylab="Pearson correlation coefficient")
boxplot(meanL1_all,names=c("1%","5%","10%"),xlab ="Percentage of masking data",ylab="mean L1 loss")
boxplot(medianL1_all,names=c("1%","5%","10%"),xlab ="Percentage of masking data",ylab="median L1 loss")
boxplot(mse_all,names=c("1%","5%","10%"),xlab ="Percentage of masking data",ylab="mean square error")
####Evaluation on viper
for(pb in c(0.01,0.05,0.1)){
  pb<-0.01
  meanL1<-c()
  medianL1<-c()
  mse<-c()
  for(rp in 1:10){
    for(cn in c(200,300)){
      fn <- paste("./result/viper",pb,rp,cn,".RD",sep = "-")
      load(fn)
      x<-res$imputed_log[mdc_mask$mask_ind]-mdc_mask$yr
      meanL1<-c(meanL1,mean(abs(x)))
      medianL1<-c(medianL1,median(abs(x)))
      mse<-c(mse,mean(x^2))
    }
  }
  boxplot(cbind(meanL1,medianL1),xlab ="Percentage of masking data",ylab="mean L1 loss")
  boxplot(medianL1,xlab ="Percentage of masking data",ylab="median L1 loss")
  boxplot(mse,xlab ="Percentage of masking data",ylab="mean square error")
  
}

