# Load libraries
library(dplyr)

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
    select(Date, Global_active_power) %>% 
    filter(Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02")) %>% 
    mutate(Global_active_power = as.numeric(Global_active_power))

# Init device and set file name
png("plot1.png")

# Plot
with(tidy, 
     hist(Global_active_power, 
          col = "Red", 
          xlab = "Global Active Power (kilowatts)", 
          ylab = "Frequency", 
          main = "Global Active Power"))

# Close the device
dev.off()