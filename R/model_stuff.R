

make_naive_model <- function(df) {
  model_naive <- lm(malaria_risk ~ net, data = df)
  return(model_naive)
}

make_ipw_weights <- function(df) {
  # Logit model predicting net use
  model_net <- glm(net ~ income + temperature + health,
                   data = df,
                   family = binomial(link = "logit"))
  
  # Create propensity scores and weights
  net_ipw <- augment_columns(model_net,
                             df,
                             type.predict = "response") %>%
    rename(propensity = .fitted) %>% 
    mutate(ipw = (net_num / propensity) + ((1 - net_num) / (1 - propensity)))
  
  return(net_ipw)
}

make_ipw_model <- function(df) {
  model_ipw <- lm(malaria_risk ~ net,
                  data = df,
                  weights = ipw)
}
