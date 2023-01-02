run_query <- function(source, query_statement){
  # Runs a Query Statement on the connection source
  # Output: Query Data
  
  # Define Connection from Source
  connection <- connect_to_db(source)
  start_time <- Sys.time()
  # Get Query Data
  query_data <- dbGetQuery(
    conn = connection, 
    statement = query_statement
  )
  
  # Disconnect Connection
  dbDisconnect(conn = connection)
  end_time <- Sys.time()
  flog.info(fn$identity("Fetched query, returning. Took `difftime(time2 = start_time, time1 = end_time, units = 'secs')` seconds"))
  # Return Query Data
  return(query_data)
}