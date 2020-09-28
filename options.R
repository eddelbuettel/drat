local({
  sys = system2("lsb_release", args = "-c", stdout = TRUE)
  dist = strsplit(sys, "\t")[[1]][2]
  repo = paste0("https://packagemanager.rstudio.com/all/__linux__/", dist, "/latest")
  options(repos = c(CRAN = repo), Ncpus = 2,
          HTTPUserAgent = sprintf('R/%s R (%s)', getRversion(),
                                  paste(getRversion(), R.version['platform'], R.version['arch'], R.version['os'])),
          download.file.extra = sprintf('--header \"User-Agent: R (%s)\"',
                                        paste(getRversion(), R.version['platform'], R.version['arch'], R.version['os'])))
})
