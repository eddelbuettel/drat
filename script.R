## Script component of travis.yml
if (!requireNamespace("devtools")) install.packages("devtools")
devtools::install_github("jumpingrivers/inteRgrate")

inteRgrate::check_pkg()
inteRgrate::check_r_filenames()
inteRgrate::check_tidy_description()
inteRgrate::check_lintr()
inteRgrate::check_namespace()
inteRgrate::check_version()

## Don't need until the end
install.packages("drat")
