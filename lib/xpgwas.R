
### Jinliang Yang
### updated, July 28th, 2014

#library("GenABEL")
source("lib/get_chistat.R")
source("lib/get_qval.R")

xpgwas <- function(input, filter=50,  plotlambda=TRUE){
    statout <- get_chistat(snps=input, filter=200)
    #source("lib/estlambda.R")
    lam <- estlambda(statout$stat, plot = plotlambda, proportion = 1, method = "regression",
                     filter = TRUE, main="Before genomic control")
    
    outqval <- xpgwas_qval(stat=statout, lambda=lam[['estimate']])
    return(outqval)
    
}
