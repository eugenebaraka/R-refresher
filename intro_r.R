## Paths and Library

setwd("/Users/eugen/Desktop/test")
library(tidyverse)

## Read data

no_loan <- read.csv(file = "prospects_no_loans.csv")
no_loan$prev_loan <- "none"
housing_loan <- read.csv(file = "prospects_housing_loans.csv")
housing_loan$prev_loan <- "housing"
personal_loan <- read.csv(file = "prospects_personal_loans.csv")
personal_loan$prev_loan <- "personal"
## Merge data

merged_data <- rbind(no_loan, housing_loan, personal_loan)
merged_data <- pivot_longer(merged_data, cols = c("married", "not.married"), 
             names_to = "marriage_status", 
             values_to = "amount($)")

## edit "not.married" to "not married"
merged_data[merged_data$marriage_status == "not.married",]$marriage_status <- 
  "not married"

# Rearrange cols by amount

merged_data <- merged_data %>% select(everything()) %>% 
  arrange(desc(`amount($)`))

# Aggregate by education
merged_data %>% group_by(education_category) %>% summarize(avg_amount = mean(`amount($)`))

## Plotting

ggplot(data = merged_data, aes(x = marriage_status, y = `amount($)`)) +
  geom_col()

