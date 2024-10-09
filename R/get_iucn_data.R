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
#' @export
get_iucn_data <- function(species_names) {
  # Verificar que se proporcionen nombres de especies válidos

  # Convertir iucn_data a data.table si no lo es
  # Inicializar un data.table con los nombres de especies proporcionados
  results <- data.frame(submitted_name = species_names)
  data <- iucnr::iucn_data
  # Buscar y recuperar toda la información de iucn_data basada en los nombres de especies
  matched_rows <- data[data$search_name  %in% species_names,]
  matched_rows
  # Combinar los resultados encontrados con los nombres originales proporcionados
  output <- merge(results,
                  matched_rows,
                  by.x = "submitted_name",
                  by.y = "search_name",  # Usar la nueva columna en minúsculas para la búsqueda
                  all.x = TRUE)
output
  # Devolver el data.table final con la información completa
  return(output)
}
