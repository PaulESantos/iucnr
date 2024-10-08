#' Retrieve full information from iucn_data based on species names
#'
#' This function takes a vector of species names, searches for them in the `iucn_data`
#' dataset, and returns full information about the matched species.
#'
#' @param species_names A character vector of species names to search for in the `iucn_data`.
#' @return A data.table with full information for each species found in `iucn_data`. If a species is not found, it will return NA for the respective fields.
#' @examples
#' x <- c("Cedrela odorata", "Persea americana",
#'        "Panthera uncia", "Lynx lynx", "Ara militaris", "Zonotrichia capencis")
#' get_iucn_data(x)
#'
get_iucn_data <- function(species_names) {
  # Check for valid input
  if (missing(species_names) || !is.character(species_names) || length(species_names) == 0) {
    stop("Please provide a non-empty character vector of species names.")
  }

  # Convert the iucn_data to data.table for optimization
  iucn_data <- data.table::as.data.table(iucn_data)

  # Convert species names to lowercase and trim whitespaces
  species_names_lower <- trimws(tolower(species_names))

  # Initialize a data.table with the submitted species names
  results <- data.table::data.table(submitted_name = species_names)

  # Search and retrieve full information from iucn_data based on species names
  matched_rows <- iucn_data[tolower(search_name) %in% species_names_lower]

  # Merge the matched results with the original species names
  # The merge ensures all submitted species are returned, even if no match is found
  output <- merge(results,
                   matched_rows,
                   by.x = "submitted_name",
                   by.y = "search_name",
                   all.x = TRUE)

  # If there are no matches for certain species, set "no match found" for threat_status
  #output <- output[is.na(threat_status), threat_status := "no match found"]

  # Return the final data.table with the full information
  return(output)
}
