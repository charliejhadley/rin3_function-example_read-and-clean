library(tidyverse)
library(gapminder)

export_gapminder_year <- function(year){
  
  gapminder %>% 
    filter(year == {{ year }}) %>% 
    select(-year) %>% 
    janitor::clean_names() %>% 
    pivot_longer(life_exp:gdp_percap) %>% 
    mutate(name = str_replace(name, "_", " "),
           name = str_to_title(name),
           name = str_replace(name, "Gdp", "GDP")
    ) %>% 
    pivot_wider(names_from = name,
                values_from = value) %>% 
    write_csv(file.path("data", str_glue("gapminder_all-data_{year}.csv")))
  
  
}


walk(unique(gapminder$year), export_gapminder_year)


