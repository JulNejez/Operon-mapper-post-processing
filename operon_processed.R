library(tidyverse)
library(zoo)
library(dplyr)
library(WriteXLS)

filelist <- list.files(pattern = ".*.txt")

# i is name of file with operon prediction
i <- "An428A.txt"

bacteria <- gsub(pattern = "\\.txt$", "", i)
my_data <- read.delim(i)
my_data %>% drop_na()
operon <- "COG0385"
  
# Replace NA Values in Operon
my_data$Operon <- na.locf(my_data$Operon)
  
# Save columns, where is operon
rows_with_COG <- my_data %>% filter_all(any_vars(. %in% c(operon)))
number_of_op <- rows_with_COG$Operon
  
if (length(number_of_op) > 0){
  # Save full operons/genes with COG
  COG_operons <- my_data[is.element(my_data$Operon, c(number_of_op)),]
  COG_operons <- COG_operons[ , c(1, 4)]
    
  # dataframe
  df <- data.frame(Bacterie = bacteria,
                   Operon = COG_operons$Operon,
                   COGgene = COG_operons$COGgene)
  
  #Change your path
  write_xlsx(df, "C:\\Users\\Julie\\Documents\\BT_BIO\\magistr\\operony\\COG1131.xlsx")
}
