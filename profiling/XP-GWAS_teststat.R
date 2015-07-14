### Jinliang Yang
### updated, July 28th, 2014
### Dan's method!

library("GenABEL")
source("lib/get_chistat.R")
source("lib/get_qval.R")


statout <- get_chistat(snps=chr10, filter=200)
#source("lib/estlambda.R")
lam <- estlambda(statout$stat, plot = TRUE, proportion = 1, method = "regression",
                 filter = TRUE, main="Before genomic control")


outqval <- xpgwas_qval(stat=statout, lambda=lam[['estimate']])

