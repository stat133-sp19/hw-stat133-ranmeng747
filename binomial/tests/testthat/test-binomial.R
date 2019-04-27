context("Test for workout03 binomial")

test_that("check bin_choose() that calculates the number of
          combinations in which k successes can occur in n trials", {

            expect_equal(bin_choose(n = 5, k = 2), 10)
            expect_equal(bin_choose(5,0), 1)
            expect_length(bin_choose(5, 1:3), 3)
            })

test_that("check bin_probability() which calculates the probability in
 which k successes can occur in n trials given probability of single success", {

   expect_equal(bin_probability(success = 2, trials = 5, prob = 0.5), 0.3125)
   expect_equal(round(bin_probability(success = 55, trials = 100, prob = 0.45), 3), round(0.01075277, 3))
   expect_length(bin_probability(success = 0:2, trials = 5, prob = 0.5), 3)
   expect_error(bin_probability(success = 10, trials = 5, prob = 0.5), 'success cannot be greater than trials')
 })

test_that("check bin_distribution() that displays probability density of binomial distribution", {
  trials <- 5
  prob <- 0.5
  expect_length(bin_distribution(trials, prob), 2)
  expect_length(bin_distribution(trials, prob)$probability, trials+1)
  expect_equal(sum(bin_distribution(trials, prob)$probability), 1)

})

test_that("check bin_cumulative() which displays probability density and cumulative probability of binomial distribution ", {
  trials <- 5
  prob <- 0.5
  expect_length(bin_cumulative(trials, prob), 3)
  expect_length(bin_cumulative(trials, prob)$cumulative, trials+1)
  expect_equal(bin_cumulative(trials, prob)$cumulative[trials+1], 1)

})
