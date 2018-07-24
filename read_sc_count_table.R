# Read single cell count table from mESC.
fns <- list.files(path = "../datasets/sca/mESC",include.dirs = TRUE,
           recursive = TRUE, full.names = TRUE,
          pattern = "*GSE*")
for (fn in fns){
  print(fn)
}
#mESC/GSE1161165 & int
ds1<-read.csv(fns[1],header = TRUE, sep =",", stringsAsFactors = FALSE)
#mESC/GSE54695 & float & log10 transformed or ?
ds2<-read.csv(fns[2],header = TRUE, sep ="\t", stringsAsFactors = FALSE)
#mESC/GSE75790 & int
ds3<-read.csv(fns[3],header = TRUE, sep ="\t", stringsAsFactors = FALSE)
save(ds1,ds2,ds3,file = "sc_mESC.RD")
#
##############################################################################
#Read single cell count table from hESC.
fns <- list.files(path = "../datasets/sca/hESC",include.dirs = TRUE,
                  recursive = TRUE, full.names = TRUE,
                  pattern = "*GSE*")
for (fn in fns){
  print(fn)
}
##############################################################################
#Read single cell count table from hESC.
fns <- list.files(path = "../datasets/sca/mDC/",include.dirs = TRUE,
                  recursive = TRUE, full.names = TRUE,
                  pattern = "*GSE*")
for (fn in fns){
  print(fn)
}
