# Load libraries
library(dplyr)
library(lubridate)

# Download and extract the data
if (!file.exists("household_power_consumption.txt")) {
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", 
                  "E_Pow_Consumption.zip", 
                  "curl")
    unzip("E_Pow_Consumption.zip")
}

# Read file
raw <- read.delim(file = "household_power_consumption.txt", 
                  sep = ";", na.strings = "?")

# Tidy the data
tidy <- raw %>% 
    mutate(Date = as.Date(Date, "%d/%m/%Y")) %>% 
    mutate(DateTime = ymd_hms(paste(Date, Time))) %>% 
    filter(DateTime >= as_datetime("2007-02-01 00:00:00") 
           & DateTime <= as_datetime("2007-02-03 00:00:00")) %>% 
    mutate(Voltage = as.numeric(Voltage), 
           Global_reactive_power = as.numeric(Global_reactive_power),
           Global_active_power = as.numeric(Global_active_power),
           Sub_metering_1 = as.numeric(Sub_metering_1), 
           Sub_metering_2 = as.numeric(Sub_metering_2), 
           Sub_metering_3 = as.numeric(Sub_metering_3))

# Init device and set file name
png("plot4.png")

# Set plot config
par(mfrow = c(2, 2))

# Plot 1
plot(tidy$DateTime, 
     tidy$Global_active_power, 
     type = "l", 
     xlab = "",
     ylab = "Global Active Power (kilowatts)")

# Plot 2
plot(tidy$DateTime, 
     tidy$Voltage, 
     type = "l", 
     xlab = "datetime",
     ylab = "Voltage")

# Plot 3
plot(tidy$DateTime, 
     tidy$Sub_metering_1, 
     type = "l", 
     xlab = "",
     ylab = "Energy sub metering")

# Plot second metric
lines(tidy$DateTime, tidy$Sub_metering_2, type = "l", col = "Red")

# Plot third metric
lines(tidy$DateTime, tidy$Sub_metering_3, type = "l", col = "Blue")

# Put the legend
legend("topright", c("Sub_metering_1", 
                     "Sub_metering_2", 
                     "Sub_metering_3"), 
       col = c("Black", "Red", "Blue"), 
       lty = 1)

# Plot 4
plot(tidy$DateTime, 
     tidy$Global_reactive_power, 
     type = "l", 
     xlab = "datetime",
     ylab = "Global_reactive_power")

# Close the device
dev.off()