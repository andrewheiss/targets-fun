library(targets)
library(tarchetypes)

# Set target-specific options such as packages.
tar_option_set(packages = c("tidyverse", "broom"))

source("R/data_stuff.R")
source("R/model_stuff.R")


# End this file with a list of target objects.
list(
  tar_target(net_data, create_mosquito_data()),
  tar_target(model_naive, make_naive_model(net_data)),
  tar_target(ipw_data, make_ipw_weights(net_data)),
  tar_target(model_ipw, make_ipw_model(ipw_data)),
  tar_render(analysis, "analysis-with-targets.Rmd")
)
