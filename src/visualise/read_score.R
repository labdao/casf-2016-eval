library(readr)
library(janitor)

# read score
function(score_path){
  score <- read_delim(score_path, 
                      delim = "\t", escape_double = FALSE, 
                      trim_ws = TRUE) %>%
    janitor::clean_names()
  
  return(score)
}

list.files(full.names = TRUE)


