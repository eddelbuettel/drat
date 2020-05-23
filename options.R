options(repos =
            c(CRAN = 'https://packagemanager.rstudio.com/all/__linux__/bionic/latest'),
        HTTPUserAgent = sprintf('R/%s R (%s)', getRversion(),
                                paste(getRversion(), R.version['platform'],
                                      R.version['arch'], R.version['os'])),
        download.file.extra = sprintf('--header \"User-Agent: R (%s)\"',
                                      paste(getRversion(), R.version['platform'],
                                            R.version['arch'], R.version['os'])))

