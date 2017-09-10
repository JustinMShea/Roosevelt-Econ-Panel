
library(xts)
library(forecast)
library(ggplot2)

#forecast package
lm_gdp <- tslm(Real_GDP)
arima_GDP <- auto.arima(Real_GDP["/2007"])
tbats_GDP <- tbats(log(Real_GDP["/2007"]))

arima_GDP %>% forecast(h = 40) %>% autoplot()

tbats_forecast <- forecast(tbats_GDP, h = 4 * 10)
tbats_GDP %>% forecast(h = 40) %>% autoplot()


# Hamilton Leff
Hlm_GDP <- HLfilter.lm(Real_GDP["/2007"], h = 80)
HL_GDP <- HLfilter(100*log(Real_GDP), h = 36)
View(HL_GDP)

# plot GDP
plot(HL_GDP$HL_fit, col = "red", grid.col = "white")
lines(HL_GDP$x_h, col = "black")

plot(HL_GDP$HL_fit["1984/"], col = "red", grid.col = "white")
lines(HL_GDP$x_h["1984/"], col = "black")



# plot resid
plot(HL_GDP$HL_resid["1956/"], index(employ_hlf), col = "black", grid.col = "white")
abline(v = .index(HL_GDP["2001"])[1], lty = 2, col = "green")
abline(v = .index(HL_GDP["2009"])[1], lty = 2, col = "red")
#abline(h = 415, lty = 2, col = "green")
abline(h = 0, lty = 2, col = "black")
#abline(h= -515, lty = 2, col = "red")

# plot absolute reside
plot(HL_GDP$HL_resid, index(employ_hlf), col = "red", grid.col = "white")
abline(v = .index(HL_GDP["2009"])[1], lty = 2, col = "darkgreen")

# Max resid
max(Hlm_GDP$residuals)


