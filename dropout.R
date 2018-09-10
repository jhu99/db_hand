########Load data###################################################################
setwd("~/Research/db_hand")
load("sc_mdc_log10_transformed.RD")
load("sc_mca_log10_transformed_ref.RD")
load("ensembl_mmusculus_gene.RD")
########Merge data frame############################################################
bmt <- bm[,c(1,3)]
bmt <- bmt[!duplicated(bmt),]
rownames(bmt) <- bmt$ensembl_gene_id
ind_ensemble_gene_id <- rownames(mdc)
ind_ensemble_gene_id <- intersect(ind_ensemble_gene_id,bmt$ensembl_gene_id)
mdc <- mdc[ind_ensemble_gene_id,]
ind_external_gene_name<-bmt[ind_ensemble_gene_id,2]
rownames(mdc) <- ind_external_gene_name
####### ###################################
ind_gene_name_ref <- rownames(md)
ind_gene_name_common <- intersect(ind_gene_name_ref,ind_external_gene_name)
mdc <- mdc[ind_gene_name_common,]
save(md,mdc,ind_gene_name_common,file = "sc_test_data.RD")
