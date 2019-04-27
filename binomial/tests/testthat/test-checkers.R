context("Test for workout03 checkers")


test_that("check input is a valid probability", {
  x <- 0.4
  y <- 1.6
  z <- "hello"
  w <- c(0.3,0.4)
  expect_true(check_prob(x))
  expect_error(check_prob(y), 'p has to be a number between 0 and 1')
  expect_error(check_prob(z), 'p must be numeric')
  expect_error(check_prob(w), 'Only 1 prob input is allowed')
})

test_that("check input is a valid trial", {
  x <- -1
  y <- 2
  z <- "hello"
  w <- c(0.3,0.4)
  expect_error(check_trials(x), 'trial must be non- negative integer')
  expect_true(check_trials(y))
  expect_error(check_trials(z), 'trial must be numeric')
  expect_error(check_trials(w), 'Only 1 trial input is allowed')
})


test_that("check input is a valid success", {
  x <- 7
  y <- 5
  z <- "hello"
  w <- 10
  expect_error(check_success(x, y), 'success cannot be greater than trials')
  expect_true(check_success(y, x))
  expect_error(check_success(z, 3), 'Both success and trial must be numeric')
  expect_true(check_success(c(x,y), w))
})
