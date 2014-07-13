library(sqldf)
#Load the required data 
data <- read.csv.sql(file="power.txt", sql = "select * from file where Date='1/2/2007'
     or Date='2/2/2007'", header = TRUE, sep=";")
#Convert dates and time
data[,'Date'] <- as.Date(data[,'Date'],"%d/%m/%Y")
data[,'Time'] <- format(strptime(data[,'Time'], "%H:%M:%S"),"%H:%M:%S")

#Create the first plot
png('plot1.png',width = 480, height = 480)
hist(data$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power")
dev.off()
