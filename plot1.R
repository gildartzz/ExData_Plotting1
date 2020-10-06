# Plot 1

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

# Plot must be saved as PNG files of 480x480 pixels
png(filename = "./ExData_Plotting1/plot1.png", 
    width = 480, 
    height = 480, 
    units = "px")

hist(measurements$Global_active_power, 
     col = "red",
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")

dev.off()
