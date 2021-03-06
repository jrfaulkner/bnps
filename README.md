# spmrf

This repository houses the `R` package `spmrf`, which is used for fitting Bayesian nonparametric adaptive smoothing models as described in Faulkner and Minin (2018).  The `spmrf` package interfaces with Stan, which is a C++ package for performing Bayesian inference using Hamiltonian Monte Carlo (see [http://mc-stan.org/](http://mc-stan.org/)).  Stan can be interfaced with the R package `rstan`, and thus the `spmrf` package depends on the `rstan` package to fit models.

## Installation
1. Install package dependency `rstan` and install package `devtools` using `install.packages` function.  Note that if you do not already have `rstan` installed, you may need to install additional packages such as `Rtools` if using a Windows platform, or `Xcode` if you are using a Mac.  See the [`rstan` prerequisites](https://github.com/stan-dev/rstan/wiki/RStan-Getting-Started#prerequisites) for more information.  If you want the vignettes, you may also need to install the `rmarkdown` package
2. Load `devtools` using `library(devtools)`.
3. Install `spmrf` from GitHub using either
  1) `install_github("jrfaulkner/spmrf")` or
  2) `install_github("jrfaulkner/spmrf", build_vignettes=TRUE)` if you want the vignette documentation which provides examples of using `spmrf`.  Note that building vignettes will make the load take a little longer.

## Vignettes
The following vignettes provide some examples using the `spmrf` package with step-by-step instructions and R code. 

1. [Introduction to spmrf](https://github.com/jrfaulkner/spmrf/blob/master/vignettes/introduction_to_spmrf.Rmd)
2. [Coal Mining Example](https://github.com/jrfaulkner/spmrf/blob/master/vignettes/coal_mining_example.Rmd)
3. [Unequal Grid and Covariates Example](https://github.com/jrfaulkner/spmrf/blob/master/vignettes/unequal_grid_and_covariate_example.Rmd)
4. [Phylodynamics Examples](https://github.com/jrfaulkner/spmrf/blob/master/vignettes/phylodynamics_examples.Rmd)

## References
Faulkner, J. R., and V. N. Minin. 2018. [Locally adaptive smoothing with Markov random fields and shrinkage priors](http://projecteuclid.org/euclid.ba/1487905413). Bayesian Analysis 13(1):225-252.
