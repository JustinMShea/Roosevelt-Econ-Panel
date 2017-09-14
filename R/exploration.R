
library(xts)
library(forecast)
library(ggplot2)

#forecast package
arima_GDP <- auto.arima(Real_GDP["/2007"])
tbats_GDP <- tbats(log(Real_GDP["/2007"]))

arima_GDP %>% forecast(h = 40) %>% autoplot()

tbats_forecast <- forecast(tbats_GDP, h = 4 * 10)
tbats_GDP %>% forecast(h = 40) %>% autoplot()


# Hamilton Leff

HL_GDP_actual <- HLfilter(Real_GDP, h = 36)
sum(HL_GDP_actual["2017"]$HL_resid) / sum(HL_GDP_actual["2017"]$x_h)

# log real gdp for plots
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


## Card and Krueger
library(wooldridge)
data("discrim")
str(discrim)

lm(discrim$emp ~ discrim$wagest)
plot(x=discrim$emp, y = discrim$wagest)

ggplot(data=discrim, aes(x=emp, y=wagest)) + 
        geom_point() +
        geom_smooth(method = "lm")

ggplot(data=discrim, aes(y=emp2, x=wagest2)) + 
        geom_point() +
        facet_grid(. ~ state) +
        geom_smooth(method = "lm")

sum(discrim$emp, na.rm=TRUE)
sum(discrim$emp2, na.rm=TRUE)


## various ages of participation
library(ggplot2)
ggplot(employment_wide, aes(x=date)) +
        geom_line(aes(y=LNS11324230)) +
        geom_line(aes(y=employment_ages_api[2])) +
        geom_line(aes(y=employment_ages_api[3])) +
        geom_line(aes(y=employment_ages_api[4])) +
        geom_line(aes(y=employment_ages_api[5])) +
        labs(title = "Employment Level - Civ. Labor Force")


df <- get_bls_county()

#Use map function with arguments.
map_bls(map_data = df, fill_rate = "unemployed_rate", 
        labtitle = "Unemployment Rate by County")

