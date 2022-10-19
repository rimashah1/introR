# Intro to R Part 3

### Data Visualization ggplot2 ###
library(ggplot2)

load("data/new_metadata.RData")

# Basics of plots
# each plot needs a geom_ function to specify type of plot
# each plot also needs aes() and specifying what x and y is. Other aes arguments are optional
ggplot(new_metadata) +
  geom_point(aes(x = age_in_days, y= samplemeans))

# Aes that are added within geom_point applies only to that layer. Argument is mapped to column
# Default colors.
ggplot(new_metadata) +
  geom_point(aes(x = age_in_days, y= samplemeans, color= genotype))

# Show different celltype on plot as well
ggplot(new_metadata) +
  geom_point(aes(x = age_in_days, y= samplemeans, color= genotype, shape= celltype))

# Change size of points. Not mapped to column so outside geom_point
ggplot(new_metadata) +
  geom_point(aes(x = age_in_days, y= samplemeans, color = genotype,
                 shape=celltype), size=2.25) 

# Theme layer = handles non-plot elements like labels, legend, background
ggplot(new_metadata) +
  geom_point(aes(x = age_in_days, y= samplemeans, color = genotype,
                 shape=celltype), size=3.0) +
  theme_bw() +
  theme(axis.title = element_text(size=rel(1.5)))

# Change axis labels
ggplot(new_metadata) +
  geom_point(aes(x = age_in_days, y= samplemeans, color = genotype,
                 shape=celltype), size=3.0) +
  theme_bw() +
  theme(axis.title = element_text(size=rel(1.5))) +
  theme(plot.title=element_text(hjust=0.5)) +
  xlab("Age (days)") +
  ylab("Mean Expression") +
  ggtitle("Average Expression of Genotypes by Age (days)") +
  scale_color_manual(values=c("purple","orange"))



### Consistent Formatting ###
# If we want multiple plots that have the same formatting we can make a function
personal_theme <- function(){
  theme_bw() +
    theme(axis.title=element_text(size=rel(1.5))) +
    theme(plot.title=element_text(size=rel(1.5), hjust=0.5))
}
# the above function would replace the theme code
ggplot(new_metadata) +
  geom_point(aes(x=age_in_days, y=samplemeans, color=genotype, shape=celltype), size=rel(3.0)) +
  xlab("Age (days)") +
  ylab("Mean expression") +
  ggtitle("Expression with Age") +
  personal_theme()



### Generate Boxplot ###
factor(new_metadata$genotype, levels=c("Wt", "KO"))

ggplot(new_metadata) +
  geom_boxplot(aes(x= genotype, y= samplemeans, fill= celltype)) +
  ggtitle("Genotype Differences in Average Gene Expression") +
  xlab("Genotype") +
  ylab("Mean Expression") +
  theme_bw() +
  theme(axis.title = element_text(size=rel(1.25))) +
  theme(plot.title=element_text(hjust=0.5, size=rel(1.5))) +
  scale_fill_manual(values=c("gold","salmon"))



### Writing Data to Files and Exporting ###
write.csv(sub_meta, file="data/subset_meta.csv") # save df to file
write(glengths, file="data/genome_lengths.txt", ncolumns = 1) # save vector as single column

## Saving Figures ##
# Open device for writing. pdf/png
pdf("figures/scatterplot.pdf")

# Make plot that is to be saved
ggplot(new_metadata) +
  geom_point(aes(x = age_in_days, y= samplemeans, color = genotype,
                 shape=celltype), size=rel(3.0)) 

# Close device to save
dev.off()



### Remember you can ask for help in many places ###



### Tidyverse data wrangling ###
