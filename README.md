
<!-- README.md is generated from README.Rmd. Please edit that file -->

# coronavirusbrazil

<!-- badges: start -->

[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![License:
MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![GitHub
commit](https://img.shields.io/github/last-commit/mralbu/coronavirusbrazil)](https://github.com/mralbu/coronavirusbrazil/commit/master)
<!-- badges: end -->

The coronavirusbrazil package provides a tidy format dataset of the 2019
Novel Coronavirus COVID-19 (2019-nCoV) epidemic for Brazil. The datasets
were obtained from [Ministerio da Saúde](https://covid.saude.gov.br/)
and [brasil.io](https://brasil.io/dataset/covid19/caso).

This repository was inspired by the
[RamiKrispin/coronavirus](https://github.com/RamiKrispin/coronavirus)
package repository.

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
#>         date cases deaths new_cases new_deaths death_rate percent_case_increase
#> 1 2020-02-25     0      0        NA         NA        NaN                    NA
#> 2 2020-02-26     1      0         1          0          0                   Inf
#> 3 2020-02-27     1      0         0          0          0                     0
#> 4 2020-02-28     1      0         0          0          0                     0
#> 5 2020-02-29     2      0         1          0          0                   100
#> 6 2020-03-01     2      0         0          0          0                     0
#>   percent_death_increase days_gt_10 days_gt_100
#> 1                     NA         NA          NA
#> 2                    NaN         NA          NA
#> 3                    NaN         NA          NA
#> 4                    NaN         NA          NA
#> 5                    NaN         NA          NA
#> 6                    NaN         NA          NA
```

``` r
plot_coronavirus(coronavirus_br, xaxis = "cases", yaxis = "new_cases", log_scale = TRUE)
```

<img src="man/figures/README-unnamed-chunk-2-1.png" width="100%" />

``` r
data("coronavirus_br_states")
head(coronavirus_br_states) 
#> # A tibble: 6 x 11
#> # Groups:   state [1]
#>   state date       cases deaths new_cases new_deaths death_rate percent_case_in~
#>   <chr> <date>     <dbl>  <dbl>     <dbl>      <dbl>      <dbl>            <dbl>
#> 1 RO    2020-02-25     0      0         0          0        NaN              NaN
#> 2 RO    2020-02-26     0      0         0          0        NaN              NaN
#> 3 RO    2020-02-27     0      0         0          0        NaN              NaN
#> 4 RO    2020-02-28     0      0         0          0        NaN              NaN
#> 5 RO    2020-02-29     0      0         0          0        NaN              NaN
#> 6 RO    2020-03-01     0      0         0          0        NaN              NaN
#> # ... with 3 more variables: percent_death_increase <dbl>, days_gt_10 <dbl>,
#> #   days_gt_100 <dbl>
```

``` r
plot_coronavirus(coronavirus_br_states, yaxis = "new_cases", color = "state", filter_variable = "state", facet = "state", filter_values = c("RJ", "SP"), log_scale = TRUE)
#> Scale for 'y' is already present. Adding another scale for 'y', which will
#> replace the existing scale.
```

<img src="man/figures/README-unnamed-chunk-4-1.png" width="100%" />

``` r
data("coronavirus_br_cities")
head(coronavirus_br_cities) 
#> # A tibble: 6 x 17
#> # Groups:   city [1]
#>   city  date       state place_type cases deaths is_last estimated_popul~
#>   <chr> <date>     <chr> <chr>      <dbl>  <dbl> <lgl>              <dbl>
#> 1 Abae~ 2020-03-31 PA    city           1      0 FALSE             157698
#> 2 Abae~ 2020-04-01 PA    city           1      0 FALSE             157698
#> 3 Abae~ 2020-04-02 PA    city           1      0 FALSE             157698
#> 4 Abae~ 2020-04-03 PA    city           1      0 FALSE             157698
#> 5 Abae~ 2020-04-04 PA    city           1      0 FALSE             157698
#> 6 Abae~ 2020-04-05 PA    city           1      0 FALSE             157698
#> # ... with 9 more variables: city_ibge_code <dbl>,
#> #   confirmed_per_100k_inhabitants <dbl>, death_rate <dbl>, new_cases <dbl>,
#> #   new_deaths <dbl>, percent_case_increase <dbl>,
#> #   percent_death_increase <dbl>, days_gt_10 <dbl>, days_gt_100 <dbl>
```

There are also geospatial datasets avaiable:

``` r
dplyr::glimpse(spatial_br_states)
#> Observations: 27
#> Variables: 16
#> $ id                     <chr> "AC", "AL", "AM", "AP", "BA", "CE", "DF", "E...
#> $ name                   <chr> "Acre", "Alagoas", "Amazonas", "Amapá", "Bah...
#> $ uf                     <chr> "AC", "AL", "AM", "AP", "BA", "CE", "DF", "E...
#> $ codigo                 <int> 12, 27, 13, 16, 29, 23, 53, 32, 52, 21, 31, ...
#> $ regiao                 <chr> "Norte", "Nordeste", "Norte", "Norte", "Nord...
#> $ geometry               <list> [<-70.470805, -9.213489>, <-36.622412, -9.5...
#> $ date                   <date> 2020-04-06, 2020-04-06, 2020-04-06, 2020-04...
#> $ cases                  <dbl> 50, 31, 532, 34, 431, 1013, 473, 194, 119, 1...
#> $ deaths                 <dbl> 0, 2, 19, 2, 10, 29, 10, 6, 5, 2, 9, 1, 1, 3...
#> $ new_cases              <dbl> 2, 3, 115, 5, 30, 190, 5, 28, 4, 37, 27, 1, ...
#> $ new_deaths             <dbl> 0, 0, 5, 0, 1, 3, 3, 0, 2, 0, 3, 0, 0, 2, 0,...
#> $ death_rate             <dbl> 0.00000000, 0.06451613, 0.03571429, 0.058823...
#> $ percent_case_increase  <dbl> 4.166667, 10.714286, 27.577938, 17.241379, 7...
#> $ percent_death_increase <dbl> NaN, 0.00000, 35.71429, 0.00000, 11.11111, 1...
#> $ log_cases              <dbl> 1.698970, 1.491362, 2.725912, 1.531479, 2.63...
#> $ log_deaths             <dbl> -Inf, 0.3010300, 1.2787536, 0.3010300, 1.000...
#plot(spatial_br_states)
```

``` r
dplyr::glimpse(spatial_br_cities)
#> Observations: 744
#> Variables: 7
#> $ date       <date> 2020-04-06, 2020-04-04, 2020-04-06, 2020-04-06, 2020-04...
#> $ city       <chr> "Abaetetuba", "Abaiara", "Açailândia", "Acrelândia", "Aç...
#> $ cases      <dbl> 1, 1, 1, 9, 8, 0, 1, 1, 1, 1, 1, 1, 5, 1, 1, 1, 1, 3, 1,...
#> $ deaths     <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,...
#> $ geometry   <list> [<-48.87880, -1.72183>, <-39.04160, -7.34588>, <-47.500...
#> $ log_cases  <dbl> 0.0000000, 0.0000000, 0.0000000, 0.9542425, 0.9030900, -...
#> $ log_deaths <dbl> -Inf, -Inf, -Inf, -Inf, -Inf, -Inf, -Inf, -Inf, -Inf, -I...
#plot(spatial_br_states)
```

# Data Sources

  - States: [Ministerio da Saúde](https://covid.saude.gov.br/)
  - Cities: [brasil.io](https://brasil.io/dataset/covid19/caso)
