#' IUCN Red List Taxon Data
#'
#' This dataset contains taxonomic information from the IUCN Red List
#' of Threatened Species, downloaded from the GBIF website. It includes
#' taxonomic details and conservation status, for species across
#' multiple kingdoms, providing a comprehensive view of the species
#' included in the Red List.
#'
#' @format A tibble with 150,490 rows and 12 variables:
#' \describe{
#'   \item{search_name}{\code{character}. A search-friendly version of the scientific name.}
#'   \item{scientific_name}{\code{character}. The full scientific name of the taxon, including authorship.}
#'   \item{family}{\code{character}. The taxonomic family to which the taxon belongs.}
#'   \item{genus}{\code{character}. The genus of the taxon.}
#'   \item{specific_epithet}{\code{character}. The specific epithet of the taxon, forming the species name together with the genus.}
#'   \item{infraspecific_epithet}{\code{character}. The epithet of infraspecific taxa, such as subspecies or varieties, if applicable.}
#'   \item{infrasp_tag}{\code{character}. Indicator of the rank for infraspecific taxa (e.g., subspecies, variety, forma).}
#'   \item{taxon_rank}{\code{character}. The taxonomic rank of the taxon (e.g., species, subspecies, variety).}
#'   \item{taxonomic_status}{\code{character}. The taxon's status, indicating whether it is accepted or a synonym.}
#'   \item{accepted_name_usage_id}{\code{integer}. Identifier of the accepted name for synonyms, or the same as the core ID for accepted names.}
#'   \item{core_id}{\code{character}. A unique identifier linking taxon data with distribution data.}
#'   \item{threat_status}{\code{character}. The IUCN conservation status of the species, such as "Endangered", "Vulnerable", or "Least Concern".}
#' }
#'
#' The data is sourced from two files:
#' 1. `taxon.txt`: Provides taxonomic information including scientific names, taxon ranks, and accepted name usage IDs.
#' 2. `distribution.txt`: Contains information of the IUCN threat status for each taxon.
#'
#' @source
#' The IUCN Red List of Threatened Species, available through GBIF: \url{https://www.gbif.org/dataset/19491596-35ae-4a91-9a98-85cf505f1bd3}
#'
#' @examples
#' # Load the data
#' data(iucn_data)
#'
#' # View the first few rows of the dataset
#' head(iucn_data)
#'
"iucn_data"
