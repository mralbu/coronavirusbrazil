
<!-- README.md is generated from README.Rmd. Please edit that file -->

\# coronavirusbrazil

<!-- badges: start -->

[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![License:
MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![GitHub
commit](https://img.shields.io/github/last-commit/mralbu/coronavirusbrazil)](https://github.com/mralbu/coronavirusbrazil/commit/master)
<!-- badges: end -->

The coronavirusbrazil package provides a tidy format dataset of the 2019
Novel Coronavirus COVID-19 (2019-nCoV) epidemic for Brazil. The raw data
pulled from [Ministério da Saúde](https://covid.saude.gov.br/) and
[brasil.io](https://brasil.io/dataset/covid19/caso).

This repository was inspired by the
[coronavirus](https://github.com/RamiKrispin/coronavirus) package
repository.

## Installation

You can install the released version of coronavirusbrazil from
[CRAN](https://CRAN.R-project.org) with:

``` r
# install.packages("devtools")
devtools::install_github("mralbu/coronavirusbrazil")
```

## Usage

The package contains the following datasets:

``` r
library(coronavirusbrazil)


data("coronavirus_br")
head(coronavirus_br) 
#>         date cases deaths delta_cases delta_deaths days_gt_10 days_gt_100
#> 1 2020-02-25     0      0          NA           NA         NA          NA
#> 2 2020-02-26     1      0           1            0         NA          NA
#> 3 2020-02-27     1      0           0            0         NA          NA
#> 4 2020-02-28     1      0           0            0         NA          NA
#> 5 2020-02-29     2      0           1            0         NA          NA
#> 6 2020-03-01     2      0           0            0         NA          NA
```

``` r
plot_coronavirus_br(coronavirus_br, xaxis_br = "cases", delta = TRUE, log_scale = TRUE)
```

<img src="man/figures/README-unnamed-chunk-2-1.png" width="100%" />

``` r
data("coronavirus_br_states")
head(coronavirus_br_states) 
#> # A tibble: 6 x 8
#> # Groups:   state [1]
#>   state date       cases deaths delta_cases delta_deaths days_gt_10 days_gt_100
#>   <chr> <date>     <dbl>  <dbl>       <dbl>        <dbl>      <dbl>       <dbl>
#> 1 RO    2020-02-25     0      0           0            0         NA          NA
#> 2 RO    2020-02-26     0      0           0            0         NA          NA
#> 3 RO    2020-02-27     0      0           0            0         NA          NA
#> 4 RO    2020-02-28     0      0           0            0         NA          NA
#> 5 RO    2020-02-29     0      0           0            0         NA          NA
#> 6 RO    2020-03-01     0      0           0            0         NA          NA
```

``` r
plot_coronavirus_states(coronavirus_br_states, filter_state = c("RJ", "SP", delta = TRUE, log_scale = TRUE))
#> Scale for 'y' is already present. Adding another scale for 'y', which will
#> replace the existing scale.
```

<img src="man/figures/README-unnamed-chunk-4-1.png" width="100%" />

``` r
data("coronavirus_br_cities")
head(coronavirus_br_cities) 
#> # A tibble: 6 x 11
#>   date       state city  place_type cases deaths is_last estimated_popul~
#>   <date>     <chr> <chr> <chr>      <dbl>  <dbl> <lgl>              <dbl>
#> 1 2020-04-03 AP    Maca~ city          19      0 TRUE              503327
#> 2 2020-04-03 PA    Abae~ city           1      0 TRUE              157698
#> 3 2020-04-03 PA    Anan~ city           9      0 TRUE              530598
#> 4 2020-04-03 PA    Barc~ city           1      0 TRUE              124680
#> 5 2020-04-03 PA    Belém city          30      0 TRUE             1492745
#> 6 2020-04-03 PA    Cast~ city           1      0 TRUE              200793
#> # ... with 3 more variables: city_ibge_code <dbl>,
#> #   confirmed_per_100k_inhabitants <dbl>, death_rate <dbl>
```

There are also geospatial datasets avaiable:

``` r
head(spatial_br_states)
#> # A tibble: 6 x 13
#>   id    name  uf    codigo regiao geometry date       cases deaths delta_cases
#>   <chr> <chr> <chr>  <int> <chr>  <list>   <date>     <dbl>  <dbl>       <dbl>
#> 1 AC    Acre  AC        12 Norte  <XY>     2020-04-02    43      0           0
#> 2 AL    Alag~ AL        27 Norde~ <XY>     2020-04-02    18      1           0
#> 3 AM    Amaz~ AM        13 Norte  <XY>     2020-04-02   229      3          29
#> 4 AP    Amapá AP        16 Norte  <XY>     2020-04-02    11      0           0
#> 5 BA    Bahia BA        29 Norde~ <XY>     2020-04-02   267      3          21
#> 6 CE    Ceará CE        23 Norde~ <XY>     2020-04-02   550     20         106
#> # ... with 3 more variables: delta_deaths <dbl>, log_cases <dbl>,
#> #   log_deaths <dbl>
# plot(spatial_br_states)
```

``` r
head(spatial_br_cities)
#> # A tibble: 6 x 7
#>   date       city             cases deaths geometry log_cases log_deaths
#>   <date>     <chr>            <dbl>  <dbl> <list>       <dbl>      <dbl>
#> 1 2020-04-03 Abaetetuba           1      0 <XY>         0           -Inf
#> 2 2020-04-02 Açailândia           1      0 <XY>         0           -Inf
#> 3 2020-04-02 Acrelândia           8      0 <XY>         0.903       -Inf
#> 4 2020-04-02 Açu                  1      0 <XY>         0           -Inf
#> 5 2020-04-02 Afonso Cláudio       1      0 <XY>         0           -Inf
#> 6 2020-04-02 Águas de Lindóia     1      0 <XY>         0           -Inf
#plot(spatial_br_states)
```

# Data Sources

  - States: [Ministério da Saúde](https://covid.saude.gov.br/)
  - Cities: [brasil.io](https://brasil.io/dataset/covid19/caso)
