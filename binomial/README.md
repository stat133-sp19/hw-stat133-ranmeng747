# Workout 3
By Ran Meng, 4/27/2019

### Project Description:

This project for Stat-133 involves creating a package named *binomial*, which contains functions for calculating probabilties, displaying the results in dataframes and plotting the results related to the [Binomial Distribution](https://en.wikipedia.org/wiki/Binomial_distribution)

 
### Using the package:

To use the package, simply call the R function *library(binomial)* as you would for importing any other package. Tutorial of calling some  functions included in the package is demonstrated in *introduction.Rmd* under the *vignettes* subdirectory. 

### Modifying the package:

In case you want to add functionalities to the current package, you may add functions in *functions.R* or create other R scripts under subdirectory *R*. The use of roxygen comments and the practice of testing the functions using *testthat* is strongly recommanded. Please include the testing functions in a new *test-... .R* file and save it under *tests/testthat* subdirectory. 

Note that *NAMESPACE* and files under *man* subdirectory are auto-generated and you should avoid editing the files. Please be cautious to manipulate the current file structure as the package may not be successfully bulit by devtools() otherwise. 

### Prerequisites:
+ R
+ RStudio





