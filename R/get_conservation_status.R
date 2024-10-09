#' Get Conservation Status of Species
#'
#' This function retrieves the conservation status of species from the iucn_data dataset.
#' It is vectorized to handle multiple species names and optimized using data.table for performance.
#'
#' @param species_names A character vector of species names to search for in the iucn_data dataset.
#' @return A data.table with species names and their corresponding conservation status.
#' @export

get_conservation_status <- function(species_names) {
  # Convertir el tibble iucn_data a data.table para optimización
  data.table::as.data.table(iucn_2024)
  # Validar entrada
  if (missing(species_names) || !is.character(species_names) || length(species_names) == 0) {
    stop("Please provide a non-empty character vector of species names.")
  }

  # Convertir species_names a minúsculas
  species_names_lower <- trimws(tolower(species_names))

  # Inicializar un vector para almacenar los estados de conservación
  conservation_status_vector <- character(length(species_names_lower))

  # Búsqueda y asignación de estados de conservación
  for (i in seq_along(species_names_lower)) {
    match_index <- which(tolower(iucn_2024$scientific_name) == species_names_lower[i])  # Convertir a minúsculas para la comparación

    if (length(match_index) > 0) {
      conservation_status_vector[i] <- iucn_2024$threat_status[match_index][1]  # Obtener el primer estado de conservación
    } else {
      conservation_status_vector[i] <- "no match found"  # Asignar mensaje de no coincidencia
    }
  }

  return(conservation_status_vector)
}
