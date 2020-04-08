
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
were obtained from [Ministerio da Saúde](https://covid.saude.gov.br/),
[brasil.io](https://brasil.io/dataset/covid19/caso) and [Secretaria de
Saúde - RJ](http://painel.saude.rj.gov.br/monitoramento/covid19.html).

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
library(ggplot2)


data("coronavirus_br")
head(coronavirus_br) 
#> # A tibble: 6 x 10
#>   date       cases deaths new_cases new_deaths death_rate percent_case_in~
#>   <date>     <dbl>  <dbl>     <dbl>      <dbl>      <dbl>            <dbl>
#> 1 2020-02-25     0      0        NA         NA        NaN               NA
#> 2 2020-02-26     1      0         1          0          0              Inf
#> 3 2020-02-27     1      0         0          0          0                0
#> 4 2020-02-28     1      0         0          0          0                0
#> 5 2020-02-29     2      0         1          0          0              100
#> 6 2020-03-01     2      0         0          0          0                0
#> # ... with 3 more variables: percent_death_increase <dbl>, days_gt_10 <dbl>,
#> #   days_gt_100 <dbl>
```

``` r
plot_coronavirus(coronavirus_br, xaxis = "date", yaxis = "cases", log_scale = F, linear_smooth = F)
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
plot_coronavirus(coronavirus_br_states, yaxis = "percent_case_increase", color = "state", filter_variable = "state", facet = "state", filter_values = c("RJ", "SP", "DF", "CE", "RS", "MG"), log_scale = TRUE, linear_smooth = TRUE)
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
#> $ date                   <date> 2020-04-08, 2020-04-08, 2020-04-08, 2020-04...
#> $ cases                  <dbl> 54, 37, 804, 107, 497, 1291, 509, 227, 158, ...
#> $ deaths                 <dbl> 2, 2, 30, 2, 15, 43, 12, 6, 7, 11, 14, 2, 1,...
#> $ new_cases              <dbl> 4, 5, 168, 59, 41, 240, 17, 18, 25, 58, 55, ...
#> $ new_deaths             <dbl> 1, 0, 7, 0, 3, 12, 0, 0, 2, 7, 3, 0, 0, 1, 0...
#> $ death_rate             <dbl> 0.03703704, 0.05405405, 0.03731343, 0.018691...
#> $ percent_case_increase  <dbl> 8.000000, 15.625000, 26.415094, 122.916667, ...
#> $ percent_death_increase <dbl> 100.00000, 0.00000, 30.43478, 0.00000, 25.00...
#> $ log_cases              <dbl> 1.732394, 1.568202, 2.905256, 2.029384, 2.69...
#> $ log_deaths             <dbl> 0.3010300, 0.3010300, 1.4771213, 0.3010300, ...
ggplot2::ggplot(spatial_br_states, ggplot2::aes(color=cases, size=cases)) + ggplot2::geom_sf()
```

<img src="man/figures/README-unnamed-chunk-6-1.png" width="100%" />

``` r
dplyr::glimpse(spatial_br_cities)
#> Observations: 850
#> Variables: 7
#> $ date       <date> 2020-04-07, 2020-04-04, 2020-04-07, 2020-04-07, 2020-04...
#> $ city       <chr> "Abaetetuba", "Abaiara", "Açailândia", "Acrelândia", "Aç...
#> $ cases      <dbl> 2, 1, 1, 9, 8, 0, 1, 1, 1, 1, 1, 1, 5, 1, 1, 1, 1, 3, 1,...
#> $ deaths     <dbl> 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,...
#> $ geometry   <POINT> POINT (-48.8788 -1.72183), POINT (-39.0416 -7.34588), ...
#> $ log_cases  <dbl> 0.3010300, 0.0000000, 0.0000000, 0.9542425, 0.9030900, -...
#> $ log_deaths <dbl> -Inf, -Inf, -Inf, -Inf, -Inf, -Inf, 0, -Inf, -Inf, -Inf,...
ggplot2::ggplot(spatial_br_cities, ggplot2::aes(color=cases, size=cases)) + ggplot2::geom_sf()
```

<img src="man/figures/README-unnamed-chunk-7-1.png" width="100%" />

# Data Sources

  - States: [Ministerio da Saúde](https://covid.saude.gov.br/)
  - Cities: [brasil.io](https://brasil.io/dataset/covid19/caso)
  - Rio de Janeiro: [Secretaria de Saúde -
    RJ](http://painel.saude.rj.gov.br/monitoramento/covid19.html)
