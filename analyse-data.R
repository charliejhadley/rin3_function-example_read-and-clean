library(tidyverse)
library(janitor)

gapminder_1952 <- read_csv("data/gapminder_all-data_1952.csv")

gapminder_1957 <- read_csv("data/gapminder_all-data_1957.csv")

gapminder_1962 <- read_csv("data/gapminder_all-data_1962.csv")

gapminder_1967 <- read_csv("data/gapminder_all-data_1967.csv")

gapminder_1967 %>% 
  clean_names() %>% 
  pivot_longer(life_exp:gdp_percap)


clean_data <- function(data, data_year){
  
  data %>% 
    mutate(year = data_year) %>% 
    clean_names() %>% 
    pivot_longer(life_exp:gdp_percap)
  
}

gapminder_1952 <- clean_data(gapminder_1952, "1952")

gapminder_1957 <- clean_data(gapminder_1957, "1957")

gapminder_1962 <- clean_data(gapminder_1962, "1962")

gapminder_1967 <- clean_data(gapminder_1967, "1967")

bind_rows(gapminder_1952, gapminder_1957, gapminder_1962, gapminder_1967)

# ==== Alternative ====

read_and_clean <- function(data_file){
  
  data_year <- str_extract(data_file, "[0-9]{4}")
  
  data_file %>% 
    read_csv() %>% 
    mutate(year = data_year) %>% 
    clean_names() %>% 
    pivot_longer(life_exp:gdp_percap)
  
  
}

map(
  list.files("data", pattern = "gapminder.{1,}.csv", full.names = TRUE),
  ~ read_and_clean(.)
) %>%
  bind_rows()




