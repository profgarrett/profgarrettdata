# Analyze data from used games
# Sample used to test Azure datasource.
setwd('C:/Users/ndg00008/Dropbox/Courses/profgarrettdata')

library(tidyverse)

s <- 'BoardGameUsedMarketPrices.xlsx'
t_raw <-  readxl::read_excel(s, skip = 5)

names(t_raw) <- c('game', 'id', 'price', 'condition', 'saledate')

as.Date(t$saledate, origin = "1900-01-01")

t <- t_raw %>%
  filter(saledate != 'Sale Date') %>%
  mutate(
    saledate_fixed = as.Date(as.numeric(saledate), origin = "1900-01-01"),
    year = isoyear(saledate_fixed),
    price = as.numeric(price)) %>%
  group_by(year, game) %>%
  summarize(n = n(), median_price = median(price))

plot(x = t$median_price)
