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

#Add the Plot
png('plot3.png', width = 480, height = 480)
with(data, plot(Datetime, Sub_metering_1, type="l",  ylab="Energy sub metering ", xlab=""))
with(data, lines(Datetime, Sub_metering_2, type="l", col="red"))
with(data, lines(Datetime, Sub_metering_3, type="l", col="blue"))
legend("topright",lty=c(1,1,1), lwd=c(2.5,2.5,2.5),  col = c("black", "blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()