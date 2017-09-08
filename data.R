
# Data Sources
Real_GDP_URL <- "https://research.stlouisfed.org/fred2/data/GDPC96.txt"

Unemployment_u6_url <- "https://fred.stlouisfed.org/data/U6RATE.txt"

labor_participation_url <- "https://fred.stlouisfed.org/data/CIVPART.txt"

civilian_employment_url <- "https://fred.stlouisfed.org/data/CE16OV.txt"

### Download directly from FRED into xts time series object 
library(xts)
Real_GDP <- as.xts(read.zoo(Real_GDP_URL, skip = 12, index.column = 1, 
                        header = TRUE, format = "%Y-%m-%d", FUN = as.yearqtr))

###
Unemployment_u6 <- as.xts(read.zoo(Unemployment_u6_url, skip = 14, index.column = 1, 
                            header = TRUE, format = "%Y-%m-%d", FUN = as.yearmon))

labor_participation <- as.xts(read.zoo(labor_participation_url, skip = 14, index.column = 1, 
                                   header = TRUE, format = "%Y-%m-%d", FUN = as.yearmon))
###

civilian_employment <- as.xts(read.zoo(civilian_employment_url, skip = 20, index.column = 1, 
                                       header = TRUE, format = "%Y-%m-%d", FUN = as.yearmon))
