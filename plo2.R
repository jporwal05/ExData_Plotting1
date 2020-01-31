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
    select(Date, Time, Global_active_power) %>% 
    mutate(DateTime = ymd_hms(paste(Date, Time))) %>% 
    filter(DateTime >= as_datetime("2007-02-01 00:00:00") 
           & DateTime <= as_datetime("2007-02-03 00:00:00")) %>% 
    mutate(Global_active_power = as.numeric(Global_active_power))

# Init device and set file name
png("plot2.png")

# Plot
plot(tidy$DateTime, 
     tidy$Global_active_power, 
     type = "l", 
     xlab = "",
     ylab = "Global Active Power (kilowatts)")

# Close the device
dev.off()