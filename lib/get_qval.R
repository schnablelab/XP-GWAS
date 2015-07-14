### Jinliang Yang

get_qval <- function(pval=pval1, pcol="P1df", method="fdr"){
  qval <- p.adjust(pval[,pcol], method=method)
  return(qval)
}

xpgwas_qval <- function(stat=out, lambda=1){
    
    stat$pval <- pchisq(stat$stat/lambda, 1, lower.tail=FALSE)
    stat$qval <- get_qval(pval=stat, pcol="pval", method="fdr")
    #[1] 134 ?
    message(sprintf("###>>> [ %s ] significant sites using FDR < 0.05", nrow(subset(stat, qval < 0.05))))
    return(stat)
}
