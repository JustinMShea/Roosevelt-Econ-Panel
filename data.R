
# Data
Real_GDP_URL <- "https://research.stlouisfed.org/fred2/data/GDPC96.txt"

### Download directly from FRED into xts time series object 
library(xts)
Real_GDP <- as.xts(read.zoo(Real_GDP_URL, skip = 12, index.column = 1, 
                        header = TRUE, format = "%Y-%m-%d", FUN = as.yearqtr))

