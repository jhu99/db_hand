# Read single cell count table from mESC.
fns <- list.files(path = "../datasets/sca/mESC",include.dirs = TRUE,
           recursive = TRUE, full.names = TRUE,
          pattern = "*GSE*")
for (fn in fns){
  print(fn)
}
#mESC/GSE1161165 & int
ds1<-read.csv(fns[1],header = TRUE, sep =",", stringsAsFactors = FALSE)
#mESC/GSE54695 & float & log10 transformed or FPKM? 
ds2<-read.csv(fns[2],header = TRUE, sep ="\t", stringsAsFactors = FALSE)
#mESC/GSE75790 & int
ds3<-read.csv(fns[3],header = TRUE, sep ="\t", stringsAsFactors = FALSE)
save(ds1,ds2,ds3,file = "sc_mESC.RD")
#
##############################################################################
#Read single cell count table from hESC.
fns <- list.files(path = "../datasets/sca/hESC",include.dirs = FALSE,
                  recursive = TRUE, full.names = TRUE,
                  pattern = "*GSE*")
for (fn in fns){
  print(fn)
}
#hESC/GSE75748 &single cell & cell type & float
ds4<-read.csv(fns[5],header = TRUE, sep =",", stringsAsFactors = FALSE)
#hESC/GSE75748 &single cell & time course & float
ds5<-read.csv(fns[6],header = TRUE, sep =",", stringsAsFactors = FALSE)
#RNA-sequencing of 329 single cells collected at 
#four time points during a 4-day DE differentiation 
#to identify mechanisms leading to cellular heterogeneity 
#during differentiation
#hPSC/GSE109979 &single cell & time course & RPKM
ds6<-read.csv(fns[2],header = TRUE, sep ="\t", stringsAsFactors = FALSE, skip = 1)
#hPSC/GSE102066 
ds7<- read.csv(fns[1],header = TRUE, sep ="\t", stringsAsFactors = FALSE, comment.char = "#")
#hPSC/GSE94979
fns <- list.files(path = "../datasets/sca/GSE94979_RAW",include.dirs = FALSE,
                  recursive = TRUE, full.names = TRUE,
                  pattern = "*GSE*")
i<- 1
for(fn in fns)
{
  i<-i+1
  tmp <- read.csv(fn,header = FALSE, sep ="\t", stringsAsFactors = FALSE, comment.char = "#")
  if(i==2)
  {
    ds8 <- tmp
  }else
  {
    ds8[,i] <- tmp$V2
  }
}
save(ds4,ds5,file="sc_hESC.RD")
save(ds6,ds7,ds8,file = "sc_hPSC.RD")
##############################################################################
#Read single cell count table from hESC.
fns <- list.files(path = "../datasets/sca/mDC",include.dirs = TRUE,
                  recursive = TRUE, full.names = TRUE,
                  pattern = "*GSE*")
for (fn in fns){
  print(fn)
}
#mDC/GSE48968_allgenesTPM_GSM1189042_GSM1190902
ds9<- read.csv(fns[2],header = TRUE, sep ="\t", stringsAsFactors = FALSE)
#mDC/GSE48968_allgenesTPM_GSM1406531_GSM1407094
ds10<- read.csv(fns[3],header = TRUE, sep ="\t", stringsAsFactors = FALSE)
#mDC/GSE114313
ds11<- read.csv(fns[1],header = TRUE, sep =" ", stringsAsFactors = FALSE)
mt <- ds11v2
rownames(mt)<- mt$ENSEMBLID
mt <- mt[,-1]
mtsign <- (mt>0)
mtratio <- colMeans(t(mtsign))
lowexpress<-which(mtratio<0.01)
ds11v2<- ds11[-lowexpress,]
cs <- colSums(mt)
mdc <- t(log10(t(mt)*10^6/cs + 1.01))
save(mdc,file = "sc_mdc_log10_transformed.RD")
save(ds9,ds10,ds11,ds11v2,file = "sc_mDC.RD")
##############################################################################
#Read single cell count table from mouse cell atlas
fns <- list.files(path = "../datasets/sca/mouse/GSE108097_RAW",include.dirs = TRUE,
                  recursive = TRUE, full.names = TRUE,
                  pattern = "*dge*")
for (fn in fns)
{
  ds11<- read.csv(fn,header = TRUE, sep =" ", stringsAsFactors = FALSE)
}
ds12<- read.csv(file = "../datasets/sca/mouse/Figure2-batch-removed.txt",
                header = TRUE, sep ="\t", stringsAsFactors = FALSE)
save(ds12,file = "sc_mca.RD")
write(ds12[,1],file = "mca_gene.txt")

mt <- ds12
cs <- colSums(mt)
md <- t(log10(t(mt)*10^6/cs + 1.01))
save(md,file = "sc_mca_log10_transformed_ref.RD")
##################################################
#Download ensembl gene id
library(biomaRt)
ensembl = useEnsembl(biomart="ensembl", 
                     dataset="mmusculus_gene_ensembl",mirror = 'asia')
head(listAttributes(ensembl))
bm <- getBM(attributes=c('ensembl_gene_id','ensembl_transcript_id','external_gene_name','transcript_length','cds_length'),  mart = ensembl)
write.csv(bm, file = "ensembl.txt")
save(bm,file = "ensembl_mmusculus_gene.RD")

