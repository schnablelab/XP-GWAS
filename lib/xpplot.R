#### Jinliang Yang
#### simple XP-GWAS plot

xpplot <- function(pval){
    qval$log10p <- -log10(qval$pval)
    plot(x=qval$pos, y=qval$log10p,  type="p", xaxt="n", pch=20, col="slateblue", bty="n",
         xlim=c(0, max(qval$pos)), ylim=c(0.5, 10 ), ylab="-log10(P-value)", xlab="Physical Position (bp)")
    cutoff <- min(subset(qval, qval < 0.05)$log10p)
    abline(h=cutoff, col="red", lty=2, lwd=2)
}  

