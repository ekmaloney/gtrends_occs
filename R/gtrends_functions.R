#' Create Request DF for an individual search term
#' 
#' This function can then be run on all occupation search terms :) 
#'
#' @param term the search term of interest
#'
#' @return data frame with dates from 2018-01-01 to 2022-01-01 to get the entire time range we're interested in
#' @export
#'
#' @examples
create_request_df <- function(term){
  tibble::tibble(b = seq.Date(from = as.Date("2018-01-01"),
                              to = as.Date("2021-01-01"),
                              by = "month"),
                 e = seq.Date(from = as.Date("2019-01-01"),
                              to = as.Date("2022-01-01"),
                              by = "month"),
                 together = paste(b, e),
                 keyword = term,
                 geo = "US") 
}


send_request <- function(df){
  res_all <- list()
  for(i in 1:nrow(df)){
    res <- gtrends(keyword = df$keyword[i],
                   geo = df$geo[i],
                   time = df$together[i])
    
    res_all[[length(res_all)+1]] <- res
    #Sys.sleep(60)
  }
}
