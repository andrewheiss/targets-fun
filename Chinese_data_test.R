

library(tidyverse)

# the "in English" column is not in the actual data
# it's put in the example just for the reference for English speakers

term_data <- tribble(
  ~term_in_cn, ~term_in_en,
  "永续", "Eternal",
  "无固定期限", "No limit",
  "36个月", "36 months",
  "5年", "5 years"
)

###### help needed for this part!

term_clean <- term_data %>% 
  mutate(term_limit_raw = parse_number(term_in_cn)) %>% 
  mutate(term_limit = case_when(
    str_detect(term_in_cn, "月") ~ term_limit_raw / 12,
    TRUE ~ term_limit_raw))
  
# data regarding registration location and level 
# register means the authority that the charitable trusts are registered with 

location_data <- tribble(
  ~register_in_cn, ~register_in_en,
  "郑州市民政局", "Zhengzhou Municipal Civial Affairs Bureau",
  "广东省民政厅", "Guangdong Provincial Civial Affairs Bureau",
  "成都市民政局", "Chengdu Municipal Civial Affairs Bureau",
)

location_clean <- location_data %>% 
  mutate(level_cn = str_sub(register_in_cn,3,3),
         level_en = fct_recode(level_cn,
                               "municipal"="市",
                               "provincial"="省"),
         location_cn = str_sub(register_in_cn,1,2),
         location_en = fct_recode(location_cn,
                               "Zhengzhou"="郑州",
                               "Guangdong"="广东",
                               "Chengdu" = "成都"),
         province = fct_recode(location_en,
                               "Henan" = "Zhengzhou",
                               "Sichuan" = "Chengdu"))


