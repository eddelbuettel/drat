pkg <- "drat"
nrdfile <- system.file("NEWS.Rd", package = pkg)
if (file.exists(nrdfile)) {
    nrd <- readLines(nrdfile)
    ver <- as.package_version(gsub(".* ([0-9\\.]+) .*", "\\1", nrd[grepl("\\{Changes", nrd)]))
    dcf <- read.dcf(system.file("DESCRIPTION", package = pkg))
    cur <- as.package_version(dcf[[1,"Version"]])
    if (cur != ver[1]) stop("Expected NEWS entry for ", cur, " but saw ", ver[1], call. = FALSE)
}
