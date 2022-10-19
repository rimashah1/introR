### Part 1 Exercises ###
#1 Function that converts temp (F) to temp (K)

temp_conv <- function(temp_f) {
  temp_c <-  (temp_f - 32) * 5 / 9
  temp_k <-  temp_c + 273.15
  return (temp_k)
}
temp_conv(70)

#2 Round temp_k to 1 digit
round(temp_conv(70), digits=1)



### Part 2 Exercises ### 
animals <- read.csv('data/animals.csv')
rownames(animals)
class(animals)
nrow(animals)
ncol(animals)

animals[which(animals$speed == 40), 1] # return where speed=40. 1=extract only 40
animals[which(animals$color == "Tan"),] # return rows with color=tan. nothing after , = extract whole row
animals[which("speed" > 50), "color", drop=F] # return rows where speed > 50 and only output color column 
animals$color[which(animals$color == "Grey")] <- "Gray" # output rows with color= gray and only output color column. rename grey to gray
animals_list <- list(animals$speed, animals$color)
names(animals_list) <- colnames(animals)


proj_summary <- read.table(file='data/project-summary.txt', header=TRUE, row.names = 1)
ctrl_samples <- data.frame(row.names = c("sample3", "sample10", "sample8", "sample4", "sample15"), date = c("01/13/2018", "03/15/2018", "01/13/2018", "09/20/2018","03/15/2018"))

length(which(rownames(ctrl_samples) %in% rownames(proj_summary)))
proj_summary_ctrl <- proj_summary[which(rownames(proj_summary) %in% rownames(ctrl_samples)),]

m <- match(rownames(proj_summary_ctrl), rownames(ctrl_samples))
proj_summary_ctrl <- cbind(proj_summary_ctrl, batch=ctrl_samples[m,])


proj_summary_noctl <- proj_summary[which(proj_summary$treatment != "control")]
keep <- map_lgl(proj_summary_noctl, is.numeric)
proj_summary_noctl <- proj_summary_noctl[,keep]



### Part 3 Exercises ###