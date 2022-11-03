################################################################################
# Author: Em 
# Description: Main targets file that is like a master program of functions 
# each line is a step in the workflow 
# targets are stored as meta objects 
# and only changes when upstream targets are changed themselves
################################################################################

library(targets) #workflow package

#telling our workflow to get all of the functions needed 
source("R/gtrends_functions.R") #functions to get google trends 

#tell workflow what packages are needed to run functions 
tar_option_set(packages = c("gtrendsR", "readr", "dplyr", "tidyr", 
                            "purrr"))


list(
  tar_target(joe_diss_occs, "data/joe_diss_essential_data.csv",format = "file"),
  tar_target(occs_df, read_csv(joe_diss_occs)),
  tar_target(request_dfs, map(occs_df$occupation_term, create_request_df)),
  tar_target(first_5, map(request_dfs[1:5], send_request))
)

