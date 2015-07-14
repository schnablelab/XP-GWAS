### Author: Jinliang Yang
############################
chistat <- function(snpdf){
  #out <- snp50[, 1:5]
  ## high vs. low
  snpdf <- as.matrix(snpdf)
  stat <- apply(snpdf, 1, function(y){
    #Example data vector:
    #y=c(42,20,30,35,18,50)
    #Arranged in a table like those on the board last week (for illustration)
    #tab=matrix(y,byrow=T,ncol=2)
    #tab
    
    x=1:3
    tab=matrix(y,byrow=T,ncol=2)
    o=glm(cbind(tab[,1],tab[,2])~x,
          family=binomial(link=logit))
    chisqStat=anova(o)[2,2]
    chisqStat
  })  
  return(stat)
}

#### loop through all SNPs
get_chistat <- function(snps=snps, filter=50){
    ### snps: a data.frame format input file
    ### filter: minimum depth for a given site, default=50
    
    snps$high_total <- snps$high_ref + snps$high_ref
    snps$low_total <- snps$low_ref + snps$low_ref
    snps$random_total <- snps$random_ref + snps$random_ref
    snp50 <- subset(snps, high_total > filter & low_total > filter & random_total > filter)
    dim(snp50)
    message(sprintf("###>>> input [ %s ] variants, remaining [ %s ] after depth filtering [ > %s ]", 
                    nrow(snps), nrow(snp50), filter))
   
    out <- snp50[, 1:3]
    snpcol <- snp50[, c("high_ref", "high_alt", "low_ref", "low_alt", "random_ref", "random_alt")]
    
    ### add 1 for each column
    snpcol$high_ref <- snpcol$high_ref + 1
    snpcol$high_alt <- snpcol$high_alt + 1
    snpcol$low_ref <- snpcol$low_ref + 1
    snpcol$low_alt <- snpcol$low_alt + 1
    snpcol$random_ref <- snpcol$random_ref + 1
    snpcol$random_alt <- snpcol$random_alt + 1
    
    #### get statistics using Dan's method!
    out$stat <- chistat(snpdf = snpcol)
    message(sprintf("###>>> DONE!"))
    return(out)
}



