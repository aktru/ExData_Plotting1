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
tidyDataSet$Global_reactive_power <- as.numeric(tidyDataSet$Global_reactive_power)
tidyDataSet$Voltage <- as.numeric(tidyDataSet$Voltage)

#Creating a complex variable DateTime and converting it to time format
tidyDataSet <- mutate(tidyDataSet, DateTime = paste0(tidyDataSet$Date, tidyDataSet$Time, sep = " "))
tidyDataSet$DateTime <- strptime(tidyDataSet$DateTime, "%Y-%m-%d%H:%M:%OS")

#Opening graphics device png
png(filename = "plot4.png", width = 480, height = 480)
#Setting parameters of graph (size of matrix)
par(mfrow = c(2,2))
with(tidyDataSet,{
  #Plotting the graph (1,1)
  plot(tidyDataSet$DateTime, tidyDataSet$Global_active_power, type = "l", xlab = " ", ylab = "Global Active Power")
  #Plotting the graph (2,1)
  plot(tidyDataSet$DateTime, tidyDataSet$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
  #Plotting the graph (1,2)
  with(tidyDataSet, plot(tidyDataSet$DateTime, tidyDataSet$Sub_metering_1, col = "black", xlab = "", ylab = "Energy sub metering", type = "l"))
  with(tidyDataSet, lines(tidyDataSet$DateTime, tidyDataSet$Sub_metering_2, col = "red"))
  with(tidyDataSet, lines(tidyDataSet$DateTime, tidyDataSet$Sub_metering_3, col = "blue"))
  legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n")
  #Plotting the graph (2,2)
  plot(tidyDataSet$DateTime, tidyDataSet$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
})
#Closing graphics device png 
dev.off()

