library(forecast)
library(ggplot2)
lm_gdp <- tslm(Real_GDP)
arima_GDP <- auto.arima(Real_GDP["/2007"])
ar4_GDP <- Arima(log(Real_GDP["/2007"]), order = c(4,1,0))
hl_GDP <- HLfilter.lm(Real_GDP["/2007"])
tbats_GDP <- tbats(log(Real_GDP["/2007"]))

arima_GDP %>% forecast(h = 40) %>% autoplot(type="ar")
ar4_GDP %>% forecast(h = 40) %>% autoplot()
hl_GDP %>% forecast(h = 40) %>% autoplot()

tbats_forecast <- forecast(tbats_GDP, h = 4 * 10)
tbats_GDP %>% forecast(h = 40) %>% autoplot()


library(ggplot2)
arima_GDP %>% forecast(h = 40) %>% autoplot(type="ar") +
  geom_line(aes(y=coredata(Real_GDP))) + theme_bw()
