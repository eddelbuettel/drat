## Script component of travis.yml
if (!requireNamespace("remotes")) install.packages("remotes")
remotes::install_github("jumpingrivers/inteRgrate")
inteRgrate::check_via_env(default = "true")

## Don't need until the end
install.packages("drat")
