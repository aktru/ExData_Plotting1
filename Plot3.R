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

#Creating a complex variable DateTime and converting it to time format
tidyDataSet <- mutate(tidyDataSet, DateTime = paste0(tidyDataSet$Date, tidyDataSet$Time, sep = " "))
tidyDataSet$DateTime <- strptime(tidyDataSet$DateTime, "%Y-%m-%d%H:%M:%OS")

#Opening graphics device png
png(filename = "plot3.png", width = 480, height = 480)
#Plotting the graph and defining of legend
with(tidyDataSet, plot(tidyDataSet$DateTime, tidyDataSet$Sub_metering_1, col = "black", xlab = "", ylab = "Energy sub metering", type = "l"))
with(tidyDataSet, lines(tidyDataSet$DateTime, tidyDataSet$Sub_metering_2, col = "red"))
with(tidyDataSet, lines(tidyDataSet$DateTime, tidyDataSet$Sub_metering_3, col = "blue"))
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
#Closing graphics device png 
dev.off()
