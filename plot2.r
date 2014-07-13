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
png('plot2.png', width = 480, height = 480)
with(data, plot(Datetime , Global_active_power, type="l",  ylab="Global Active Power (kilowatts)", xlab=""))
dev.off()