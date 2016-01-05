#Setting locale to English because my default locale isn't english 
Sys.setlocale("LC_ALL","English")

#Loading raw data
filePath <- "./Data/RawData/household_power_consumption.txt"
expDataSet <- read.csv(filePath, header = TRUE, sep = ";", as.is = TRUE)

#Converting data (Date) to necessary format for filtering rows
expDataSet$Date <- as.Date(expDataSet$Date, "%d/%m/%Y")

#Loading library for filtering rows  
library(dplyr)

#Filtering rows for data with date from 2007-02-01 to 2007-02-02
tidyDataSet <- filter(expDataSet, Date == as.Date("2007-02-01", format = "%Y-%m-%d") | Date == as.Date("2007-02-02", format = "%Y-%m-%d"))

#Converting data to necessary format for plotting graphs
tidyDataSet$Global_active_power <- as.numeric(tidyDataSet$Global_active_power)

#Opening graphics device png
png(filename = "plot1.png", width = 480, height = 480)
#Plotting histogramm
hist(tidyDataSet$Global_active_power, col = "red", main = "Global Active Power",xlab = "Global Active Power (kilowatts)", ylab = "Frequency")
#Closing graphics device png 
dev.off()
