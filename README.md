
<!-- README.md is generated from README.Rmd. Please edit that file -->

# iucnr

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![CRAN
status](https://www.r-pkg.org/badges/version/iucnr)](https://CRAN.R-project.org/package=iucnr)
[![R-CMD-check](https://github.com/PaulESantos/iucnr/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/PaulESantos/iucnr/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/PaulESantos/iucnr/graph/badge.svg)](https://app.codecov.io/gh/PaulESantos/iucnr)
<!-- badges: end -->

Welcome to the `iucnr` package, a comprehensive tool designed for
researchers and conservationists to access and analyze data from the
**IUCN Red List of Threatened Species**. This package allows users to
retrieve and integrate taxonomic and vernacular name data, empowering
them to conduct thorough assessments of species status and threats. With
a strong emphasis on enhancing biodiversity research, `iucnr` offers a
user-friendly interface for navigating the extensive datasets available
through the Global Biodiversity Information Facility (GBIF).

The `iucnr` package enables access to Red List data on threatened
species without the need for an internet connection, making it a
valuable resource for evaluating the conservation status of various
species. The information is sourced from the GBIF repository
(<https://www.gbif.org/dataset/19491596-35ae-4a91-9a98-85cf505f1bd3>).

While there are other packages available for similar purposes, they
typically require an API key to access the IUCN API, which can be a
barrier for some users.

### Spanish Version

Bienvenido al paquete `iucnr`, una herramienta integral diseñada para
investigadores y conservacionistas que desean acceder y analizar datos
de la Lista Roja de Especies Amenazadas de la IUCN. Este paquete permite
a los usuarios recuperar e integrar datos taxonómicos y nombres
vernáculos, empoderándolos para realizar evaluaciones exhaustivas sobre
el estado y las amenazas a las especies. `iucnr` ofrece una interfaz
amigable para navegar a través de los extensos conjuntos de datos
disponibles a través de la Global Biodiversity Information Facility
(GBIF) de la **Lista Roja de Especies Amenazadas** sin necesidad de
estar conectado a internet, lo que lo convierte en un recurso valioso
para evaluar el estado de conservación de diversas especies. La
información se obtiene del repositorio de GBIF
(<https://www.gbif.org/dataset/19491596-35ae-4a91-9a98-85cf505f1bd3>).

Si bien existen otros paquetes disponibles para objetivos similares,
estos generalmente requieren una clave de API para acceder al API de la
IUCN, lo que puede ser un obstáculo para algunos usuarios.

## Installation

``` r
install.packages("iucnr")
# or
pak::pak("iucnr")
```

Also you can install the `iucnr` package from GitHub using the following
command:

``` r
pak::pak("PaulESantos/iucnr")
```

# Example

- Define a vector of species names

``` r
species_names <- c("Panthera uncia", "Lynx lynx", "Ara militaris", "Zonotrichia capencis")
```

- Example usage of the get_conservation_status function This retrieves
  the conservation status for the specified species

``` r
conservation_status <- get_conservation_status(species_names = species_names)
conservation_status
#> [1] "Vulnerable"     "Least concern"  "Vulnerable"     "no match found"
```

- Example usage of the get_conservation_status function within a tibble
  This creates a tibble and adds a new column with the conservation
  status of each species

``` r
species_data <- tibble::tibble(species = species_names) |> 
  dplyr::mutate(iucn = get_conservation_status(species))
species_data
#> # A tibble: 4 × 2
#>   species              iucn          
#>   <chr>                <chr>         
#> 1 Panthera uncia       Vulnerable    
#> 2 Lynx lynx            Least concern 
#> 3 Ara militaris        Vulnerable    
#> 4 Zonotrichia capencis no match found
```

- Example usage of the get_iucn_data function This retrieves detailed
  IUCN data for the specified species names

``` r
iucn_data_result <- get_iucn_data(species_names)
iucn_data_result
#>         submitted_name  core_id                 scientific_name  kingdom
#> 1        Ara militaris 22685548  Ara militaris (Linnaeus, 1766) ANIMALIA
#> 2            Lynx lynx    12519      Lynx lynx (Linnaeus, 1758) ANIMALIA
#> 3       Panthera uncia    22732 Panthera uncia (Schreber, 1775) ANIMALIA
#> 4 Zonotrichia capencis     <NA>                            <NA>     <NA>
#>     phylum    class          order      family    genus specific_epithet
#> 1 CHORDATA     AVES PSITTACIFORMES PSITTACIDAE      Ara        militaris
#> 2 CHORDATA MAMMALIA      CARNIVORA     FELIDAE     Lynx             lynx
#> 3 CHORDATA MAMMALIA      CARNIVORA     FELIDAE Panthera            uncia
#> 4     <NA>     <NA>           <NA>        <NA>     <NA>             <NA>
#>   scientific_name_authorship taxon_rank infraspecific_epithet taxonomic_status
#> 1           (Linnaeus, 1766)    species                  <NA>         accepted
#> 2           (Linnaeus, 1758)    species                  <NA>         accepted
#> 3           (Schreber, 1775)    species                  <NA>         accepted
#> 4                       <NA>       <NA>                  <NA>             <NA>
#>   accepted_name_usage_id
#> 1               22685548
#> 2                  12519
#> 3                  22732
#> 4                     NA
#>                                                                                                                                                                                                 bibliographic_citation
#> 1                                        BirdLife International 2020. Ara militaris (Linnaeus, 1766). The IUCN Red List of Threatened Species 2020: https://doi.org/10.2305/IUCN.UK.2020-3.RLTS.T22685548A179407584.en
#> 2                               Breitenmoser, U., Breitenmoser-Würsten, C., Lanz, T., von Arx, M., Antonevich, A., Bao, W. & Avgan, B. 2015. Lynx lynx (Linnaeus, 1758). The IUCN Red List of Threatened Species 2015:
#> 3 McCarthy, T., Mallon, D., Jackson, R., Zahler, P. & McCarthy, K. 2017. Panthera uncia (Schreber, 1775). The IUCN Red List of Threatened Species 2017: https://doi.org/10.2305/IUCN.UK.2017-2.RLTS.T22732A50664030.en
#> 4                                                                                                                                                                                                                 <NA>
#>                                                    references
#> 1 https://apiv3.iucnredlist.org/api/v3/taxonredirect/22685548
#> 2    https://apiv3.iucnredlist.org/api/v3/taxonredirect/12519
#> 3    https://apiv3.iucnredlist.org/api/v3/taxonredirect/22732
#> 4                                                        <NA>
#>                                                                                                                                                                                                                 source
#> 1                                        BirdLife International 2020. Ara militaris (Linnaeus, 1766). The IUCN Red List of Threatened Species 2020: https://doi.org/10.2305/IUCN.UK.2020-3.RLTS.T22685548A179407584.en
#> 2                               Breitenmoser, U., Breitenmoser-Würsten, C., Lanz, T., von Arx, M., Antonevich, A., Bao, W. & Avgan, B. 2015. Lynx lynx (Linnaeus, 1758). The IUCN Red List of Threatened Species 2015:
#> 3 McCarthy, T., Mallon, D., Jackson, R., Zahler, P. & McCarthy, K. 2017. Panthera uncia (Schreber, 1775). The IUCN Red List of Threatened Species 2017: https://doi.org/10.2305/IUCN.UK.2017-2.RLTS.T22732A50664030.en
#> 4                                                                                                                                                                                                                 <NA>
#>   threat_status occurrence_status infrasp_tag
#> 1    Vulnerable           Present        <NA>
#> 2 Least concern           Present        <NA>
#> 3    Vulnerable           Present        <NA>
#> 4          <NA>              <NA>        <NA>
```

- Example usage of the get_vernacular_name function This retrieves the
  vernacular names for the specified species

``` r
vernacular_names_result <- get_vernacular_name(species = species_names)
vernacular_names_result
#>         submitted_name
#> 1            Lynx lynx
#> 2        Ara militaris
#> 3       Panthera uncia
#> 4 Zonotrichia capencis
#>                                                                                                                                                                                                                   vernacular_name
#> 1                                                                                                                                           Lynx, Evroasiin Shiluus, Eurasian Lynx, Lince, Shiluus Mii, Lince Boreal, Lynx Boréal
#> 2                                                                                                                                                             Guacamaya Verde, Guacamayo Militar, Military Macaw, Guacamayo Verde
#> 3 Léopard des neiges, Irvis, Ilbirs, Snow Leopard, Hiun chituwa, Pantera de la Nieves, Akilbirs, Sah, Babri barfi, Baral he, Snezhniy bars, Xue bào, Barfani chita, Schneeleopard, Ounce, Irbis, Irbis, Once, Panthère des neiges
#> 4                                                                                                                                                                                                                            <NA>
```

### Citation

- IUCN (2022). The IUCN Red List of Threatened Species. Version 2022-2.
  <https://www.iucnredlist.org>. Downloaded on 2023-05-09.
  <https://doi.org/10.15468/0qnb58> accessed via GBIF.org on 2023-11-17.
  accessed via GBIF.org on 2024-10-08.
