read_query_from_file <- function(query_name, dir = "./sql_queries/"){
  # Read file name query_name from dir
  # Output: Query text
  
  flog.info(fn$identity("Getting `query_name` from `dir`"))
  query_file <- paste0(dir, query_name, ".sql")
  query_text <- read(query_file)
  
  return(query_text)
}