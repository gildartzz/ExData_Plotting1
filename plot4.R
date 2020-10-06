# Plot 4

# Use sqldf to subset the data when reading it
library(sqldf)
f <- file("./data/household_power_consumption.txt")

# Date is in format d/m/yyyy while it's passing though sqldf
# sqldf deals with NAs (in this file expressed as "?") converting them to 0/blank
measurements <- 
    sqldf("select * from  f where Date = '1/2/2007' or Date = '2/2/2007'", 
          dbname = tempfile(), 
          file.format = list(header = TRUE, row.names = FALSE, sep = ";"))

close(f)

library(lubridate)
measurements$datetime <- dmy_hms(paste(measurements$Date, measurements$Time))

# Plot must be saved as PNG files of 480x480 pixels
png(filename = "./ExData_Plotting1/plot4.png", 
    width = 480, 
    height = 480, 
    units = "px")

# Panel of 2 x 2 plots is setted with mfcol, so the plots are added column-wise
par(mfcol = c(2, 2), mar = c(4, 4, 3, 2))

# Please note that my environment is in spanish, so the day names are 
# "jueves" (thursday), "viernes" (friday) and "sabado" (saturday) in x labels
with(measurements, {
    # Plot of Global active power through days
    plot(datetime,
         Global_active_power, 
         type = "l",
         ylab = "Global Active Power",
         xlab = "")

    # Plot of energy sub metering
    plot(datetime,
         Sub_metering_1, 
         type = "l",
         ylab = "Energy sub metering",
         xlab = "")
    lines(datetime,
          Sub_metering_2, 
          type = "l",
          col = "red")
    lines(datetime,
          Sub_metering_3, 
          type = "l",
          col = "blue")
    legend("topright", 
           c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
           col = c("black", "red", "blue"),
           lty = c(1, 1, 1),
           bty = "n")
    
    # Plot of Voltage through days
    plot(datetime,
         Voltage, 
         type = "l",
         ylab = "Voltage")
    
    # Plot of Global reactive power through days
    plot(datetime,
         Global_reactive_power, 
         type = "l")
})

dev.off()
