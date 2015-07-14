# XP-GWAS: a method for identifying trait-associated variants by sequencing pools of individuals

Here we report a method for conducting GWAS that does not require the genotyping of large numbers of individuals. Instead, XP-GWAS (extreme phenotype GWAS) relies on genotyping pools of individuals from a diversity panel having extreme phenotypes. This analysis measures allele frequencies in the extreme pools, enabling the discovery of associations between genetic variants and traits of interest. 

## INSTALLATION AND USAGE

### Clone the repo
```
git clone git@github.com:yangjl/XP-GWAS.git
```

### Format your input data

Input data should be a tab separated file with the column names matching the below example.   
- **Columns 1-3** should be **"snpid" (SNP ID)**, **"chr" (Chromosome name)** and **"pos" (Physical Position)**.  
- **Columns 4 and onwards**, with column names like **high_ref** and **high_alt**, indicate the reference and alternative allele counts at each polymorphic site.

```
    snpid chr  pos high_ref high_alt low_ref low_alt random_ref random_alt
1 10_3005  10 3005        0        1       1       7          0          0
2 10_3219  10 3219        5        5       9       5          6          4
3 10_3452  10 3452       26       28      32      92         32         52
4 10_3523  10 3523        4        8       8      27          9         11
5 10_3658  10 3658        9       25      10      18          6         17
6 10_4099  10 4099       12        5      14       3         13         11
```

### Run statistical test for XP-GWAS
The following scripts should be ran in `R` console. An add-on package `GenABEL` should be installed first. 
```
install.packages("GenABEL")
```

```
source("lib/xpgwas.R")
library("GenABEL")

### read the input data
input <- read.table("data/input_sample.txt", header=TRUE)

### get FDR corrected p-values for sites passed your filtering criterion (DEFAULT filter = 50)
### plotlambda: indicate whether to plot the genomic control results, default = TRUE.
qval <- xpgwas(input, filter=200,  plotlambda=TRUE)

### save results
save(file="cache/qval.RData", list=c("input", "qval"))
```

### Plot your results

```
source("lib/xpplot.R")
xpplot(qval)
```

## DOCUMENTATION

For more information, see our [tutorial](https://github.com/yangjl/XP-GWAS/blob/master/reports/XP-GWAS_method.pdf).
