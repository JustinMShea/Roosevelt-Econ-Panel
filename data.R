
# Data Sources

# GDP
Real_GDP_URL <- "https://research.stlouisfed.org/fred2/data/GDPC96.txt"

Real_Per_Capita_GDP <- "https://fred.stlouisfed.org/data/A939RX0Q048SBEA.txt"

# Employment Statistics
Unemployment_url <- "https://fred.stlouisfed.org/data/UNRATE.txt"

labor_participation_url <- "https://fred.stlouisfed.org/data/CIVPART.txt"

civilian_employment_url <- "https://fred.stlouisfed.org/data/CE16OV.txt"

#bls data by ages
library(blscrapeR)
library(tidyr)
api <- "dfc9f26b6f0c4e849169c98182b75781"
set_bls_key(api)

employment_series <- c("LNS11324230", "LNS11300093", "LNS11300091", "LNS11300089", "LNS11324887" )

employment_ages <- bls_api(employment_series, registrationKey = Sys.getenv("BLS_KEY")) %>% 
        dateCast()

employment_wide <- employment_ages %>% spread(seriesID, value)

# Government Spending

### Government Consumption Expenditures
Federal_GCE <- "https://fred.stlouisfed.org/data/FGCE.txt"
State_Local_GCE <- "https://fred.stlouisfed.org/data/SLCE.txt"

## GCE Quantity & Price Indexes
Federal_Quantity_Index <- "https://fred.stlouisfed.org/data/B823RA3Q086SBEA.txt"
Federal_Price_Index <- "https://fred.stlouisfed.org/data/B823RG3Q086SBEA.txt"
#-------------------------------------#
State_Local_Quantity_Index <- "https://fred.stlouisfed.org/data/B829RA3Q086SBEA.txt"
State_Local_Price_Index <- "https://fred.stlouisfed.org/data/B829RG3Q086SBEA.txt"

GCE_Table <- t(data.frame(Federal_GCE, Federal_Quantity_Index, Federal_Price_Index, State_Local_GCE, State_Local_Quantity_Index, State_Local_Price_Index))

kable(GCE_Table, align = "l", caption = "GCE Nominal, Quantity, and Price index sources.")



### Download directly from FRED into xts time series object 
library(xts)
Real_GDP <- as.xts(read.zoo(Real_GDP_URL, skip = 12, index.column = 1, 
                        header = TRUE, format = "%Y-%m-%d", FUN = as.yearqtr))

###
Unemployment <- as.xts(read.zoo(Unemployment_url, skip = 24, index.column = 1, 
                            header = TRUE, format = "%Y-%m-%d", FUN = as.yearmon))

labor_participation <- as.xts(read.zoo(labor_participation_url, skip = 14, index.column = 1, 
                                   header = TRUE, format = "%Y-%m-%d", FUN = as.yearmon))
###

civilian_employment <- as.xts(read.zoo(civilian_employment_url, skip = 20, index.column = 1, 
                                       header = TRUE, format = "%Y-%m-%d", FUN = as.yearmon))



