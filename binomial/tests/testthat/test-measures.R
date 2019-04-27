context("Test for workout03 summary measures")

test_that("check mean given trial numbers and probability of single success", {
  x <- 10
  y <- 0.3
  expect_equal(aux_mean(x,y), 3)
  expect_length(aux_mean(x,y), 1)
  expect_type(aux_mean(x,y), 'double')
})

test_that("check variance given trial numbers and probability of single success", {
  x <- 10
  y <- 0.3
  expect_equal(aux_variance(x,y), 2.1)
  expect_length(aux_variance(x,y), 1)
  expect_type(aux_variance(x,y), 'double')
})

test_that("check mode given trial numbers and probability of single success", {
  x <- 10
  y <- 0.3
  z <- 9
  w <- 0.5
  expect_equal(aux_mode(x,y), 3)
  expect_equal(aux_mode(z,w), c(5,4))
  expect_type(aux_mean(x,y), 'double')
})

test_that("check skewness given trial numbers and probability of single success", {
  x <- 10
  y <- 0.3
  expect_equal(round(aux_skewness(x,y), 3), round(0.2760262, 3))
  expect_length(aux_skewness(x,y), 1)
  expect_type(aux_skewness(x,y), 'double')
})

test_that("check kurtosis given trial numbers and probability of single success", {
  x <- 10
  y <- 0.3
  expect_equal(round(aux_kurtosis(x,y), 3), round(-0.1238095, 3))
  expect_length(aux_kurtosis(x,y), 1)
  expect_type(aux_kurtosis(x,y), 'double')
})
