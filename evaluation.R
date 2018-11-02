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
  meanL1<-c()
  medianL1<-c()
  mse<-c()
  for(rp in 1:6){
    fn <- paste("./result/viper",pb,rp,"res.RD",sep = "-")
    fn2 <- paste("./result/viper",pb,rp,"data.RD",sep = "-")
    load(fn)
    load(fn2)
    sg <- all(res$imputed[mdc_mask$mask_ind]==0)
    print(sg)
    #x<-res$imputed_log[mdc_mask$mask_ind]-mdc_mask$yr
    #meanL1<-c(meanL1,mean(abs(x)))
    #medianL1<-c(medianL1,median(abs(x)))
    #mse<-c(mse,mean(x^2))
  }
  #boxplot(cbind(meanL1,medianL1),xlab ="Percentage of masking data",ylab="mean L1 loss")
  #boxplot(medianL1,xlab ="Percentage of masking data",ylab="median L1 loss")
  #boxplot(mse,xlab ="Percentage of masking data",ylab="mean square error")
}

#########Evaluation on scimpute###########
medianL1_all<-c()
meanL1_all<-c()
mse_all <-c()
peason_corr_all <- c()
for(pb in c(0.01,0.05,0.1)){
  meanL1<-c()
  medianL1<-c()
  mse<-c()
  corest<-c()
  for(rp in 1:6){
    print(c(pb,rp))
    fn1 <- paste("./result/scimpute",pb,rp,"/data.RD",sep = "-")
    load(fn1)
    mdc_mask$mt[mdc_mask$mask_ind]<- mdc_mask$yr
    cs <- colSums(mdc_mask$mt)
    md <- t(log10(t(mdc_mask$mt)*10^6/cs + 1.01))
    fn2 <- paste("./result/scimpute",pb,rp,"/scimpute_count.csv",sep = "-")
    impute.df<-read.csv(fn2,stringsAsFactors = FALSE)
    cns <- impute.df$X
    impute.df<-impute.df[-1]
    cs.df<-colSums(impute.df)
    impute.mt <- t(log10(t(impute.df)*10^6/cs.df + 1.01))

    x <- impute.mt[mdc_mask$mask_ind]-
      md[mdc_mask$mask_ind]
    meanL1<-c(mean(abs(x)),meanL1)
    medianL1<-c(median(abs(x)),medianL1)
    mse<-c(mean(x^2),mse)
    ct <- cor.test(impute.mt[mdc_mask$mask_ind],md[mdc_mask$mask_ind])
    corest<-c(ct$estimate,corest)
  }
  meanL1_all<-cbind(meanL1_all,meanL1)
  medianL1_all<-cbind(medianL1_all,medianL1)
  mse_all<-cbind(mse_all,mse)
  peason_corr_all<-cbind(peason_corr_all,corest)
}
boxplot(peason_corr_all,names=c("1%","5%","10%"),xlab ="Percentage of masking data",
        ylab="Pearson correlation coefficient")
boxplot(meanL1_all,names=c("1%","5%","10%"),xlab ="Percentage of masking data",ylab="mean L1 loss")
boxplot(medianL1_all,names=c("1%","5%","10%"),xlab ="Percentage of masking data",ylab="median L1 loss")
boxplot(mse_all,names=c("1%","5%","10%"),xlab ="Percentage of masking data",ylab="mean square error")
#########Evaluation on saver###########
medianL1_all<-c()
meanL1_all<-c()
mse_all <-c()
peason_corr_all <- c()
for(pb in c(0.01,0.05,0.1)){
  meanL1<-c()
  medianL1<-c()
  mse<-c()
  corest<-c()
  for(rp in 1:6){
    print(c(pb,rp))
    fn <- paste("../result/saver",pb,rp,"/data.RD",sep = "-")
    load(fn)
    x<- mdc.saver$estimate[mdc_mask$mask_ind]-mdc_mask$yr
  }
}
