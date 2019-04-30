#title: functions.R
#Descriptions: Contains all functions needed for binomial package

#---------------------------------------------


#check whether prob is between 0 and 1
check_prob <- function(prob){

  if (length(prob) > 1){
    stop('Only 1 prob input is allowed')
  }

  if (is.na(prob)){
    stop('Please enter a non-NA value')
  }


  if (is.integer(prob)){
    prob <- as.numeric(prob)
  }

  if(!is.numeric(prob)){
    stop('p must be numeric')
  }

  if (prob < 0 || prob > 1){
    stop('p has to be a number between 0 and 1')
  }

  return(TRUE)
}

# Check whether trials numbers is a non- negative integer
check_trials <- function(trials){
  if (length(trials) > 1){
    stop('Only 1 trial input is allowed')
  }

  if (is.na(trials)){
    stop('Please enter a non-NA value')
  }


  if (is.integer(trials)){
    trials <- as.numeric(trials)
  }

  if (!is.numeric(trials)){
    stop ('trial must be numeric ')
  }

  if (trials < 0 || trials %% 1 != 0){
    stop('trial must be non- negative integer')
  }

  return (TRUE)
}

#Check whether input success is a valid value for number of successes
check_success <- function(success, trials){
  if (sum(is.na(success)) != 0 | is.na(trials)){
    stop('Input must be 2 arguments without NA values')
  }

  if (length(trials) > 1){
    stop('Only 1 trial input is allowed')
  }

  if (is.integer(trials) || is.integer(success)){
    trials <- as.numeric(trials)
    success <- as.numeric(success)
  }

  if (!is.numeric(success) || !is.numeric(trials)){
    stop('Both success and trial must be numeric')
  }

  if (trials < 0 || trials %% 1 != 0 || sum(success < 0) != 0 || sum(success %% 1) != 0){
    stop('Both success and trial must be non- negative integers')
  }

  if(max(success) > trials){
    stop('success cannot be greater than trials')
  }

  return(TRUE)
}

# Calculates mean given trial numbers and probability
aux_mean <- function(trials, prob){
  mean = trials*prob

  return (mean)
}

# Calculates variance given trial numbers and probability
aux_variance <- function(trials, prob){
  var = trials*prob*(1-prob)

  return (var)
}

# Calculates mode given trial numbers and probability
aux_mode <- function(trials, prob){

  if ((trials*prob + prob) %% 1 == 0 ){
    mode = as.integer(trials*prob + prob)

    return(c(mode, mode - 1))
  }

  else{
    mode = as.integer(trials*prob + prob)

    return(mode)
  }
}

# Calculates skewness given trial numbers and probability
aux_skewness <- function(trials, prob){
  numerator = 1- 2*prob
  denominator = sqrt(trials*prob*(1-prob))
  skewness = numerator/denominator

  return(skewness)
}

# Calculates kurtosis given trial numbers and probability
aux_kurtosis <- function(trials, prob){
  numerator = 1 - 6*prob*(1-prob)

  denomiator = trials*prob*(1-prob)

  kurtosis = numerator/denomiator

  return(kurtosis)
}



#' @title bin_choose
#' @description calculates the number of combinations in which k successes can occur in n trials
#' @param n Number of trials
#' @param k Number of successes
#' @return numeric: # of combinations
#' @export
#' @examples:
#' bin_choose(7,5)
bin_choose <- function(n, k){

  if (sum(is.na(k)) != 0 | is.na(n)){
    stop('Input must be 2 arguments without NA values')
  }

  if (length(n) > 1){
    stop('Only 1 trial input is allowed')
  }

  if (is.integer(n) || is.integer(k)){
    trials <- as.numeric(n)
    success <- as.numeric(k)
  }

  if (!is.numeric(n) || !is.numeric(k)){
    stop('Both n and k must be numeric')
  }

  if (n < 0 || n %% 1 != 0 || sum(k < 0) != 0 || sum(k %% 1) != 0){
    stop('Both n and k must be non- negative integers')
  }

  if (max(k) > n){
    stop('k cannot be greater than n')
  }

  res = factorial(n)/(factorial(k)*factorial(n-k))

  return(res)
}


#' @title bin_probability
#' @description calculates the binomial probability distribution given # of successes, # of
#' trials and the probability of getting a success in one trial
#' @param success Number of successes
#' @param trials Number of trials
#' @param prob probability of success in a single trial
#' @return numeric: probability of getting k successes out of n trials
#' @export
#' @examples:
#' bin_probability(10,15,0.4)
bin_probability <- function(success, trials, prob){

  if(check_trials(trials) && check_prob(prob) && check_success(success, trials)) {

    res = bin_choose(trials, success)*prob^(success)*(1-prob)^(trials-success)

    return(res)
  }

}

#' @title bin_distribution
#' @description Displays probability density of binomial distribution
#' given # of trials and probability of a single success
#' @param trials Number of trials
#' @param prob probability of success in a single trial
#' @return bindis: primary class 'bindis' and second class 'data.frame'
#' @export
#' @examples:
#' bin_distribution(trials = 5, prob = 0.5)
bin_distribution <- function(trials, prob){

  dat <- data.frame(success = c(0:trials), probability = bin_probability(c(0:trials), trials, prob))

  class(dat) <- c('bindis', 'data.frame')

  return(dat)
}

#' @export
plot.bindis <- function(x,...){
  dat <- x
  rownames(dat) <- dat$success

  barplot(as.matrix(dat)[,2], xlab = 'successes', ylab = 'probability',
          main = 'Probability density distribution', las = 1, border = NA)
}


#' @title bin_cumulative
#' @description Displays probability density and cumulative probability of binomial distribution
#' given # of trials and probability of a single success
#' @param trials Number of trials
#' @param prob probability of success in a single trial
#' @return bincum : Returns dataframe with primary class 'bincum' and second class 'data.frame'
#' @export
#' @examples:
#' bin_cumulative(trials = 5, prob = 0.3)
bin_cumulative <- function(trials, prob){

  dat <- bin_distribution(trials, prob)

  dat$cumulative <- cumsum(dat$probability)

  class(dat) <- c('bincum', 'data.frame')

  return(dat)
}

#' @export
plot.bincum <- function(x,...){
  dat <- x
  plot(x = dat$success, y = dat$cumulative, xlab = 'successes', ylab = 'probability',
                    main = 'Cumulative probability', type = 'o', las = 1)

}

#' @title bin_variable
#' @description Creates and returns an object of "binvar"
#' @param trials Number of trials
#' @param prob probability of success in a single trial
#' @return binvar: binvar object
#' @export
#' @examples:
#' bin_variable(trials = 5, prob = 0.5)
bin_variable <- function (trials, prob){
  check_trials(trials)
  check_prob(prob)

  res <- list(
    trials = trials,
    prob = prob
   )


  class(res) <- 'binvar'

  res

}

#' @export
print.binvar <- function(x, ...){
  cat('"Binomial variable"')
  cat('\n')
  cat('\n')
  cat('Parameters')
  cat('\n')
  cat('- number of trials:', x$trials)
  cat('\n')
  cat('- prob of success:', x$prob)
  cat('\n')

  invisible(x)

}


#' @export
summary.binvar <- function(x, ...) {
  trials <- x$trials
  prob <- x$prob

  res <- list(
     trials = trials,
     prob = prob,
     mean = aux_mean(trials, prob),
     variance = aux_variance(trials,prob),
     mode = aux_mode(trials, prob),
     skewness = aux_skewness(trials, prob),
     kurtosis = aux_kurtosis(trials, prob))

  class(res) <- "summary.binvar"
  res
}


#' @export
print.summary.binvar <- function(x, ...) {
  cat('"Summary Binomial"')
  cat('\n')
  cat('\n')
  cat('Parameters')
  cat('\n')
  cat('- number of trials:', x$trials)
  cat('\n')
  cat('- prob of success:', x$prob)
  cat('\n')
  cat('\n')
  cat('Measures')
  cat('\n')
  cat('- mean:', x$mean)
  cat('\n')
  cat('- variance:', x$variance)
  cat('\n')
  cat('- mode:', x$mode)
  cat('\n')
  cat('- skewness:', x$skewness)
  cat('\n')
  cat('- kurtosis:', x$kurtosis)


  invisible(x)
}


#' @title bin_mean
#' @description Calculates mean given # of trials and probability of a single success
#' @param trials Number of trials
#' @param prob probability of success in a single trial
#' @return numeric: mean value
#' @export
#' @examples:
#' bin_mean(trials = 5, prob = 0.5)
bin_mean <- function (trials, prob){
  if (check_trials(trials) && check_prob(prob)){
    mean = aux_mean(trials, prob)
    return(mean)
  }
}

#' @title bin_variance
#' @description Calculates variance given # of trials and probability of a single success
#' @param trials Number of trials
#' @param prob probability of success in a single trial
#' @return numeric: the variance value
#' @export
#' @examples:
#' bin_variance(trials = 5, prob = 0.5)
bin_variance <- function (trials, prob){
  if (check_trials(trials) && check_prob(prob)){
    var = aux_variance(trials, prob)
    return(var)
  }
}

#' @title bin_mode
#' @description Find mode given # of trials and probability of a single success. Length of result could be 1 or 2.
#' @param trials Number of trials
#' @param prob probability of success in a single trial
#' @return numeric: the mode value(s)
#' @export
#' @examples:
#' bin_mode(trials = 5, prob = 0.5)
bin_mode <- function (trials, prob){
  if (check_trials(trials) && check_prob(prob)){
    mode = aux_mode(trials, prob)
    return(mode)
  }
}

#' @title bin_skewness
#' @description Find skewness given # of trials and probability of a single success
#' @param trials Number of trials
#' @param prob probability of success in a single trial
#' @return numeric: the skewness value
#' @export
#' @examples:
#' bin_skewness(trials = 5, prob = 0.5)
bin_skewness <- function (trials, prob){
  if (check_trials(trials) && check_prob(prob)){
    skewness = aux_skewness(trials, prob)
    return(skewness)
  }
}

#' @title bin_kurtosis
#' @description Find kurtosis given # of trials and probability of a single success
#' @param trials Number of trials
#' @param prob probability of success in a single trial
#' @return numeric: the kurtosis value
#' @export
#' @examples:
#' bin_kurtosis(trials = 5, prob = 0.5)
bin_kurtosis <- function (trials, prob){
  if (check_trials(trials) && check_prob(prob)){
    kurtosis = aux_kurtosis(trials, prob)
    return(kurtosis)
  }
}

