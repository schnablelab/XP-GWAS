# Jinliang Yang

chr4 <- outqval

chr4 <- subset(chr4, log10p >0.5)
chr4$log10p <- -log10(chr4$pval)
plot(x=chr4$pos, y=chr4$log10p,  type="p", xaxt="n", pch=20, col="slateblue", bty="n",
     xlim=c(0, max(chr4$pos)), ylim=c(0.5, 10 ), ylab="-log10(P-value)", xlab="Chr4")
abline(h =5, lty=2, col="red", lwd=4)

