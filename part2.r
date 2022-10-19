# Intro to R Part 2


### Data Wrangling: Subsetting ###
# Vectors. Index starts at 1

age <- c(15, 22, 45, 52, 73, 81)
age[5] # fifth value
age[-5] # all values except the 5th

age[c(3,5,6)] # select multiple values
idx <- c(3,5,6) # OR create vector of the elements of interest
age[idx]

age[1:4]
age[4:1]

alphabets <- c('C', 'D', 'X', 'L', 'F')
alphabets[c(1,2,5)]
alphabets[-3]
alphabets[5:1]


# Subsetting Vectors with Logical Operators
age > 50
age > 50 | age < 18 # prints boolean 
age[age > 50 | age < 18] # prints values

which(age > 50 | age < 18) # prints indicies where true
age[which(age > 50 | age < 18)] # prints values


# Factors
expression <- c("low", "high", "medium", "high", "low", "medium", "high")
expression <- factor(expression)
expression[expression == "high"] # returns elements that are equal to high

samplegroup <- c("CTL", "KO", "OE")
samplegroup <- factor(samplegroup)
samplegroup[samplegroup != "KO"]


# Releveling Factors
str(expression) # view assignments 
expression <- factor(expression, levels=c("low", "medium", "high"))
str(expression) # levels are now reassigned 

samplegroup <- factor(samplegroup, levels=c("KO", "CTL", "OE"))
str(samplegroup)



### Packages and Libraries ###
search()

# install packages with CRAN
install.packages("ggplot2")

# install packages with BiocManager
install.packages("BiocManager") 
BiocManager::install("package_name")

# load packages
library(ggplot2) # for reference https://ggplot2.tidyverse.org/reference/index.html

install.packages("tidyverse")



### Data Wrangling: df, matrices, lists ###
metadata <-  read.csv('data/mouse_exp_design.csv')

metadata[1, 1] # row, column
metadata[1, 3] 
metadata[3, ] # extract entire row
metadata[ , 3]# extract entire column. outputs as a vector
metadata[ , 3, drop = FALSE] # outputs as df

# extract 2 columns at a time
metadata[ , 1:2] 
# extract rows 1,3,6
metadata[c(1,3,6), ]

# extract celltype column for the first three samples
metadata[c("sample1", "sample2", "sample3") , "celltype"] 

# shortcut to extract 1 column
metadata$genotype # output is vector

# print column names
colnames(metadata)
# print row names
rownames(metadata)

metadata[c("sample2", "sample8"), c("genotype", "replicate")]
metadata$replicate[c(4,9)] # OR
metadata[c(4, 9), "replicate"]
metadata[ , "replicate", drop = FALSE]


## Subsetting Dataframes with Logical Operators
# Extract rows/columns with specific values

#1 extract column of interest
logical_idx <- metadata$celltype == "typeA" #looking for values = typeA. outputs true/false
#2 Extract rows that are true
metadata[logical_idx, ]
idx <- which(metadata$celltype == "typeA")

# Extract data for replicates 2 and 3
idx <- which(metadata$replicate > 1) # indices for rows
metadata[idx, ] # extracts rows
# all in one step
sub_meta <- metadata[which(metadata$replicate > 1), ]

genotype_ko <- metadata[which(metadata$genotype == "KO"), ]


## Lists
# use double brackets
list1 <- list(10, "Hello", c(12,13,14))
comp2 <- list1[[2]]
class(comp2)

list1[[3]][1] # access component of vector which is component of list

random <- list("metadata", "age", "list1", "samplegroup", "number")
random[[4]]

# can assign names to components of a list to tell what's in the list
names(list1) <- c("number", "Hello", "numbers")
names(list1)
# extract component using name
list1$Hello

names(random) <- c("metadata", "age", "list1", "samplegroup", "number")
random$age



### %in% ###
rpkm_data <- read.csv("data/counts.csv")
head(rpkm_data)
ncol(rpkm_data)
nrow(rpkm_data)

A <- c(1,3,5,7,9,11)   # odd numbers
B <- c(2,4,6,8,1,5)  # add some odd numbers in 
intersection <- A %in% B
A[intersection]
any(A %in% B) # if any values of A are in B
all(A %in% B) # if all values of A are in B
any(B %in% A)
in_both <-  B %in% A
B[in_both]

# to see if each element of 2 vectors is in the same place
A == B
# check if it's a match
all(A == B)

x <- rownames(metadata)
y <- colnames(rpkm_data)
all(x %in% y) # all samples are present
x == y
all(x == y) # not in same order


important_genes <- c("ENSMUSG00000083700", "ENSMUSG00000080990", "ENSMUSG00000065619", "ENSMUSG00000047945", "ENSMUSG00000081010", "ENSMUSG00000030970")

row_rpkm <- rownames(rpkm_data)
genes_in_rpkm <- important_genes %in% row_rpkm
genes_in_rpkm # all genes are in dataset

rows_with_important_genes <- rownames(rpkm_data) %in% important_genes
ans <- rpkm_data[idx, ] # extract rows
idx2 <- which(rownames(rpkm_data) %in% important_genes)
ans2 <- rpkm_data[idx2, ]

rpkm_data[important_genes, ] # same as above but without %in%



### Reordering and matching ###
# Manual reordering
teaching_team <- c("Jihe", "Mary", "Meeta", "Radhika")
reorder_teach <- teaching_team[c(4, 2, 1, 3)] # reorders with indicies 

## Use match function
first <- c("A","B","C","D","E")
second <- c("B","D","E","A","C")
match(first, second) # returns indices of how the second vector should be reordered to match the first
reorder_idx <- match(first,second) # save as variable
second_reordered <- second[reorder_idx] # reorders based on indices

# Different lengths
first <- c("A","B","C","D","E")
second <- c("D","B","A")
match(first, second)
second[match(first, second)] # NAs present for missing values

genomic_idx <- match(rownames(metadata), colnames(rpkm_data))
genomic_idx
rpkm_ordered  <- rpkm_data[ , genomic_idx]
View(rpkm_ordered)

# df without sample2 and sample9
subset_rpkm <- rpkm_ordered[ , -c(2,9)]

idx <- match(rownames(metadata), colnames(subset_rpkm))
metadata[idx, ]



### Set up df for visualization- map function ###
# obtain mean values of all samples
library(purrr)
samplemeans <- map_dbl(rpkm_ordered, mean) # execute task on every element of vector or every column of df 

age_in_days <- c(40, 32, 38, 35, 41, 32, 34, 26, 28, 28, 30, 32)    
new_metadata <- data.frame(metadata, samplemeans, age_in_days) # add 2 columns to original df
