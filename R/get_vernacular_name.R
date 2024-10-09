#' Retrieve Vernacular Names for a Given Species
#'
#' This function retrieves vernacular (common) names for a given species using IUCN data. It filters vernacular names based on matching `core_id` and merges them with species metadata.
#'
#' @param species A character vector containing the scientific names of species for which vernacular names are to be retrieved.
#'
#' @return A `data.table` or `data.frame` with columns:
#' \describe{
#'   \item{submitted_name}{The scientific name of the species as submitted.}
#'   \item{vernacular_names}{A character string that contains the concatenated vernacular names for each species, separated by " - ".}
#' }
#'
#' @details
#' The function first retrieves IUCN data for the input species and extracts the corresponding `core_id`. It then filters the vernacular name dataset using the `core_id` and concatenates all unique vernacular names for each species. The resulting data includes the submitted species name along with the corresponding vernacular names.
#'
#' @examples
#' \dontrun{
#' # Example of retrieving vernacular names for two species
#' species <- c("Panthera uncia", "Cedrela odorata")
#' result <- get_vernacular_name(species)
#' print(result)
#' }
#'
#' @export
get_vernacular_name <- function(species) {
  # Obtiene los datos de IUCN para la especie proporcionada
  data <- get_iucn_data(species_names = species)

  # Extrae los core_id de los resultados y asegúrate de que sean de tipo character
  match_coreid <- as.character(data$core_id)

  # Filtra la tabla vernacular_name según los core_id coincidentes
  output <- vernacular_name[vernacular_name$core_id %in% match_coreid, ]

  # Asegúrate de que core_id sea character en el output
  output$core_id <-  as.character(output$core_id)

  # Agrupa y combina los nombres vernáculos únicos por core_id
  # Using aggregate
  ver_names <- stats::aggregate(vernacular_name ~ core_id,
                         output,
                         FUN = function(x) paste(x, collapse = ", "))


  # Selecciona las columnas de metadatos necesarias y convierte core_id a character
  metadata <- data[,c("submitted_name",  "core_id" )]

  # Combina los nombres vernáculos con los metadatos según el core_id
  result <- merge(metadata,
                  ver_names,
                  by = "core_id", all.x = TRUE)

  # Elimina la columna core_id del resultado final
  result <- result[,c("submitted_name", "vernacular_name")]

  return(result)
}

