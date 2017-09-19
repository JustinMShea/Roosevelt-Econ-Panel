
#Fisher Real Index computation
Fisher <- function(component, price, quantity, base  = 249) {
        ## component= component series
        ## price = price index, 
        ## quantity  = quantity index 
        ## base  = base period of objects. ie 249 for Q1 2009, per standard FED.
        
        require(micEconIndex)
        require(xts)
        ## Merge Price and Quantity XTS objects
        QP <- merge(price, quantity)
        ## Extract data frame for using priceIndex function
        f_QP <- data.frame(coredata(QP))
        colnames(f_QP) <- c("PRICE","QUANTITY")
        ## Now, call priceIndex() and set the method to "Fisher". ##
        
        Fisher_index <- priceIndex("PRICE", "QUANTITY", base = base, data = f_QP, method = "Fisher")
        # Calculate Real 
        Real <- merge(component/Fisher_index)
        return(Real)
}

# Hamilton Filter


HLfilter <- function(x, h = 8) {
        require(xts)
        DF <- merge(x,
                    lag.xts(x, k = h, na.pad = TRUE),
                    lag.xts(x, k = h+1, na.pad = TRUE),
                    lag.xts(x, k = h+2, na.pad = TRUE),
                    lag.xts(x, k = h+3, na.pad = TRUE))
        
        colnames(DF) <- c("x_h", "x", "x_1", "x_2", "x_3")
        
        HL_filter <- lm(x_h ~ x + x_1 + x_2 + x_3, data = DF)
        
        
        HL_fit <- as.xts(unname(HL_filter$fitted.values),
                         order.by = as.yearqtr(names(HL_filter$fitted.values)))
        
        HL_resid <- as.xts(unname(HL_filter$residuals),
                           order.by = as.yearqtr(names(HL_filter$residuals)))
        
        
        merge(DF$x_h, DF$x_h-DF$x, HL_fit, HL_resid)
        
}
