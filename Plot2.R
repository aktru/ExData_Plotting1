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
tidyDataSet <- mutate(tidyDataSet, DateTime = paste(tidyDataSet$Date, tidyDataSet$Time, sep = " "))
tidyDataSet$DateTime <- strptime(tidyDataSet$DateTime, "%Y-%m-%d%H:%M:%OS")

#Opening graphics device png
png(filename = "plot2.png", width = 480, height = 480)
#Plotting the graph with necessary parameters (type of graph, names of axises)
plot(tidyDataSet$DateTime, tidyDataSet$Global_active_power, type = "l", xlab = " ", ylab = "Global Active Power (kilowatts)")
#Closing graphics device png 
dev.off()
