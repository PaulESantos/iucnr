#' Retrieve Vernacular Names for a Given Species
#'
#' This function retrieves vernacular (common) names for a given species using IUCN data.
#' It filters vernacular names based on matching `core_id` and merges them with species metadata.
#'
#' @param splist A character vector containing the scientific names of species for which vernacular names are to be retrieved.
#'
#' @return A `data.table` or `data.frame` with columns:
#' \describe{
#'   \item{submitted_name}{The scientific name of the species as submitted.}
#'   \item{vernacular_names}{A character string that contains the concatenated vernacular names for each species, separated by " - ".}
#' }
#'
#' @details
#' The function retrieves IUCN data for the input species, extracts the corresponding `core_id`, filters the vernacular name dataset using the `core_id`, and concatenates all unique vernacular names for each species.
#'
#' @examples
#' \dontrun{
#' species <- c("Panthera uncia", "Cedrela odorata")
#' result <- get_vernacular_name(species)
#' print(result)
#' }
#'
#' @export
get_vernacular_name <- function(splist) {
  # Validate input
  if (missing(splist) || !is.character(splist) || length(splist) == 0) {
    stop("Please provide a non-empty character vector of species names.")
  }

  # Load data
  iucn_data <- iucnrdata::iucn_2024
  vernacular_data <- iucnrdata::vernacular_name

  normalize_species_names <- function(splist) {

    # Normalize species names: remove extra spaces, trim whitespace, and convert to "Sentence case"
    normalized_names <- stringr::str_squish(splist) |>
      stringr::str_trim() |>
      stringr::str_to_sentence()

    return(normalized_names)
  }


  # Normalize species names to lowercase and trim whitespace
  normalized_species <- normalize_species_names(splist)

  # Filter iucn_data for matching species
  result <- data.frame(submitted_name = splist,
                       normalized_species = normalized_species) |>
    dplyr::left_join(
      iucn_data,
      by = c("normalized_species" = "scientific_name")
    ) |>
    dplyr::select(submitted_name, core_id, threat_status) |>
    dplyr::mutate(
      threat_status = ifelse(is.na(threat_status),
                             "no match found",
                             threat_status),
      core_id = as.character(core_id)
    )

  # Filter vernacular data for matching core IDs
  vernacular_filtered <- vernacular_data |>
    dplyr::filter(core_id %in% result$core_id) |>
    dplyr::mutate(core_id = as.character(core_id))

  # Aggregate vernacular names for each core_id
  vernacular_aggregated <- vernacular_filtered |>
    dplyr::group_by(core_id) |>
    dplyr::summarize(vernacular_names = paste(unique(vernacular_name), collapse = " - "), .groups = "drop")

  # Merge vernacular names back to the main result
  final_result <- result |>
    dplyr::left_join(vernacular_aggregated, by = "core_id") |>
    dplyr::select(submitted_name, vernacular_names) |>
    dplyr::mutate(vernacular_names = ifelse(is.na(vernacular_names), "no match found", vernacular_names))

  return(final_result)
}
