################################################################################
# Author: Em 
# Description: Messing around with google trends data code
################################################################################

#libraries
library(gtrendsR)
library(tidyverse)

#first, make df of days to request 
#if make this a function, need to pass in the 'keyword' variable
#depending on the occupation in question
days <- tibble::tibble(b = seq.Date(from = as.Date("2018-01-01"),
                                    to = as.Date("2021-01-01"),
                                    by = "month"),
                       e = seq.Date(from = as.Date("2019-01-01"),
                                    to = as.Date("2022-01-01"),
                                    by = "month"),
                       together = paste(b, e),
                       keyword = "essential",
                       geo = "US") 


res_all <- list()
for(i in 1:nrow(days)){
  res <- gtrends(keyword = days$keyword[i],
                 geo = days$geo[i],
                 time = days$together[i])
  
  res_all[[length(res_all)+1]] <- res
  #Sys.sleep(60)
}

res_temp <- res_all %>% map_df("interest_over_time")
res_q <- res %>% pluck("related_queries")

y <- res_temp %>% count(date)


q <- gtrends(keyword = days$keyword[1],
             geo = days$geo[1],
             time = 'today 3-m')
