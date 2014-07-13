library(sqldf)
#Load the required data 
data <- read.csv.sql(file="power.txt", sql = "select * from file where Date='1/2/2007'
     or Date='2/2/2007'", header = TRUE, sep=";")
#Convert dates and time
data[,'Date'] <- as.Date(data[,'Date'],"%d/%m/%Y")
data[,'Time'] <- format(strptime(data[,'Time'], "%H:%M:%S"),"%H:%M:%S")
#Add a new column to plot easier
data[,'Datetime'] <- NA
data$Datetime <- strptime(paste(data$Date, " ", data$Time), "%Y-%m-%d %H:%M:%S")

#Add the plot
png('plot4.png')#, width = 480, height = 480
par(mfrow = c(2, 2))
with(data,{
  #Graph 1
  plot(strptime(paste(data$Date, " ", data$Time), "%Y-%m-%d %H:%M:%S"), Global_active_power, type="l",  ylab="Global Active Power", xlab="")    
  #Graph 2
  plot(strptime(paste(data$Date, " ", data$Time), "%Y-%m-%d %H:%M:%S"), Voltage, type="l",  ylab="Voltage ", xlab="datetime")     
  #Graph 3
  plot(strptime(paste(data$Date, " ", data$Time), "%Y-%m-%d %H:%M:%S"), Sub_metering_1, type="l",  ylab="Energy sub metering ", xlab="")
  lines(strptime(paste(data$Date, " ", data$Time), "%Y-%m-%d %H:%M:%S"), Sub_metering_2, type="l", col="red")
  lines(strptime(paste(data$Date, " ", data$Time), "%Y-%m-%d %H:%M:%S"), Sub_metering_3, type="l", col="blue")
  legend("topright",lty=c(1,1,1), col = c("black", "blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  #Graph 4
  plot(strptime(paste(data$Date, " ", data$Time), "%Y-%m-%d %H:%M:%S"), Global_reactive_power, type="l",  ylab="Global_reactive_power", xlab="datetime")
})
dev.off()



