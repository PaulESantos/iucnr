utils::globalVariables(c(
  "iucn_data", "search_name",
  ".", ":=", "core_id", "submitted_name", "vernacular_name",
  "search_name_lower","iucn_2024"
))

# ---------------------------------------------------------------


.onAttach <- function(lib, pkg) {
  packageStartupMessage("This is iucnr ",
                        utils::packageDescription("iucnr",
                                                  fields = "Version"
                        ),
                        "\nThe iucnr package is compatible with IUCN Red List version 2024-1,\nproviding tools to access and analyze the latest conservation status data.",
                        appendLF = TRUE
  )
}


# -------------------------------------------------------------------------

show_progress <- function() {
  isTRUE(getOption("iucnr.show_progress")) && # user disables progress bar
    interactive() # Not actively knitting a document
}



.onLoad <- function(libname, pkgname) {
  opt <- options()
  opt_iucnr <- list(
    iucnr.show_progress = TRUE
  )
  to_set <- !(names(opt_iucnr) %in% names(opt))
  if (any(to_set)) options(opt_iucnr[to_set])
  invisible()
}

