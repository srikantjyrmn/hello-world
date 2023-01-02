save_ran_query <- function(source, query_statement, saved_data_name, update = FALSE){
  file_name <- fn$identity("./data/`saved_data_name`.csv")
  flog.info(file.exists(file_name))
  
  if (update == TRUE || !file.exists(file_name)){
    
    flog.info(fn$identity("Running query `saved_data_name`"))
    
    # Get Data
    df <- run_query(
      source = source, 
      query_statement = query_statement
    )
    
    # Save Data
    write_csv(
      x = df, 
      path = file_name, 
      col_names = TRUE
    )
    
    # Return Data
    return(df)
    
  }else{
    
    flog.info(fn$identity("Reading saved `saved_data_name` data"))
    df <- read_csv(file = file_name, col_names = TRUE)
    return(df)
    
  }
}