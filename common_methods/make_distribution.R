make_distribution <- function(df, level_vec, distr_var, breakupvector, file_name, write_sheet = NULL){
  
  remove_col <- setdiff(colnames(df),level_vec)
  test <- unite(df,col = "level_f",sep = "@",-remove_col)
  
  decile <- function(x){quantile(x,probs = breakupvector,na.rm = T)}
  
  test_decile_S <- sapply(unique(test$level_f), function(x){
    
    a <- test %>% 
      filter(level_f == x)%>%
      select(distr_var)
    decile(a[[1]])
  })
  percentile <- row.names(test_decile_S)
  test_decile_S <- data.frame(t(test_decile_S))
  colnames(test_decile_S) <- percentile
  test_decile_S <- cbind(level = row.names(test_decile_S),test_decile_S)
  
  test_decile_S <- separate(test_decile_S,level,level_vec,sep = "@")
  
  write_csv(x = test_decile_S, 
            path = fn$identity("./reports/percentile_distris/`file_name`.csv"))
  
  
  if(!is.null(write_sheet)){
    sheets_exist <- gs_ws_ls(ss = write_sheet)
    if (file_name %in% sheets_exist){
      
      gs_edit_cells(ss = write_sheet,
                    ws = file_name,
                    input = test_decile_S,
                    anchor = "A1",
                    trim = TRUE)
      
    }else{
      
      gs_ws_new(ss = write_sheet,
                ws_title = file_name,
                input = test_decile_S,
                anchor = "A1",
                trim = TRUE)
      
    }
  }
  
  return(test_decile_S)
  
  
}