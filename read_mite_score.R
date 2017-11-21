# Confendience score for mite candidates
data<-read.csv("./datasets/mite/OS_score_collections.txt",
               header = FALSE, sep = "\t",comment.char = "#", stringsAsFactors = FALSE
               )
x <- sort(data$V2, decreasing = TRUE,na.last = TRUE)
