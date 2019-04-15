#Auxiliary functions for calculating balances
#' @title future_value
#' @description Calculate future value of investment given present amount, the interest rates and number of years of investment
#' @param amount: Initial invested amount
#' @param rate: annual rate of return
#' @param years: Number of years
#' @return numeric: Future value of investment

future_value <- function(amount = 1000, rate = 0.05, years = 10){
  
  if (is.na(amount) | is.na(rate) | is.na(years)){
    stop("Input cannot be NA")
  }
  
  if (is.nan(amount) | is.nan(rate) | is.nan(years)){
    stop("No NAN values")
  }
  
  if(!is.numeric(amount) | !is.numeric(rate) | !is.numeric(years)){
    stop("Input must be numeric")
  }
  
  if(amount <= 0){
    stop("Initial amount must be positive")
  }
  
  if (years < 0){
    stop("Investment period must be non- negative")
  }
  
  FV = amount*(1+rate)^years
  
  return (FV)
  
}


#' @title annuity
#' @description Calculate future value of annuity given initial contributed amount, the interest rates and number of years of investment
#' @param contrib: Initial contribued amount
#' @param rate: annual rate of return
#' @param years: Number of years
#' @return numeric: Future value of annuity

annuity <- function(contrib = 200, rate = 0.05, years = 10){
  
  if (is.na(contrib) | is.na(rate) | is.na(years)){
    stop("Input cannot be NA")
  }
  
  if (is.nan(contrib) | is.nan(rate) | is.nan(years)){
    stop("No NAN values")
  }
  
  if(!is.numeric(contrib) | !is.numeric(rate) | !is.numeric(years)){
    stop("Input must be numeric")
  }
  
  if(contrib <= 0){
    stop("Contributed amount must be positive")
  }
  
  if (years < 0){
    stop("Investment period must be non- negative")
  }
  
  FVA = contrib*((((1+rate)^years)-1)/rate)
  
  return (FVA)
  
}

#' @title growing_annuity
#' @description Calculate future value of growing annuity given contributed amount, the interest rates, the annual growth rate and number of years of investment
#' @param contrib: Initial contribued amount
#' @param rate: annual rate of return
#' @param growth: annual growth rate
#' @param years: Number of years
#' @return numeric: Future value of annuity

growing_annuity <- function(contrib = 200, rate = 0.05, growth = 0.03, years = 10){
  
  if (is.na(contrib) | is.na(rate) | is.na(growth) | is.na(years)){
    stop("Input cannot be NA")
  }
  
  if (is.nan(contrib) | is.nan(rate) | is.nan(growth) | is.nan(years)){
    stop("No NAN values")
  }
  
  if(!is.numeric(contrib) | !is.numeric(rate) | !is.numeric(growth) | !is.numeric(years)){
    stop("Input must be numeric")
  }
  
  if(contrib <= 0){
    stop("Contributed amount must be positive")
  }
  
  if ((rate - growth) == 0){
    stop("Cannot have same annual rate of return and growth rate")
  }
  
  if (years < 0){
    stop("Investment period must be non- negative")
  }
  
  FVGA = contrib*((((1+rate)^years)-((1+growth)^years))/(rate-growth))
  
  return (FVGA)
  
}