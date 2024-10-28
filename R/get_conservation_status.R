#' Get Conservation Status of Species
#'
#' This function retrieves the conservation status of species from the iucn_data dataset.
#' It is vectorized to handle multiple species names and optimized using data.table for performance.
#'
#' @param splist A character vector of species names to search for in the iucn_data dataset.
#' @return A data.table with species names and their corresponding conservation status or "no match found".
#' @export
get_conservation_status <- function(splist) {
  # Load data
  data <- iucnrdata::iucn_2024  # Keep as tibble

  # Validate input
  if (missing(splist) || !is.character(splist) || length(splist) == 0) {
    stop("Please provide a non-empty character vector of species names.")
  }

  # Normalize species names to lowercase and trim whitespace
  species_names <- stringr::str_squish(splist) |>
    stringr::str_trim() |>
    stringr::str_to_sentence()

  # Perform the join
  result <- data.frame(scientific_name = species_names) |>
    dplyr::left_join(data, by = "scientific_name") |>
    dplyr::mutate(threat_status = ifelse(is.na(threat_status),
                                         "no match found",
                                         threat_status))

  return(result$threat_status)  # Return as a tibble
}
