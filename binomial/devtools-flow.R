## =====================================================
# Title: devtools-binomial
# Description: Contains commands to create binomial package
#
# =====================================================

library(devtools)
devtools::document()          # generate documentation
devtools::check_man()         # check documentation
devtools::test()              # run tests
devtools::build_vignettes()   # build vignettes
devtools::build()             # build bundle
devtools::install()           # install package
