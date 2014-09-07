# Download the data
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", 
              "household_power_consumption.zip")

#Read the data
data <- read.table(unz("household_power_consumption.zip", "household_power_consumption.txt"), 
                   header = T, sep = ";", stringsAsFactors=F)

# Convert and select dates
data[,1]<-as.Date(data[,1], format= "%d/%m/%Y")
data <- data[data$Date >= "2007-02-01" & data$Date <= "2007-02-02",]
data[,2] <-as.POSIXct(strptime(paste(data[,1],data[,2]), format="%Y-%m-%d %H:%M:%S")) 

# Convert characters to numeric
for(i in 1:6){data[,i+2]=as.numeric((data[,i+2]))}

#plot
png("C:/Users/Nacho/Documents/plot4.png")
par(mfrow=c(2,2))
plot(data$Time, data$Global_active_power, type= "l", ylab = "Global Active Power (kilowatts)", xlab = "")
plot(data$Time, data$Voltage, type= "l", ylab = "Voltage", xlab = "daytime")
plot(data$Time, data$Sub_metering_1, type= "l", ylab = "Energy sub metering", xlab = "")
lines(data$Time, data$Sub_metering_2, type= "l", col = "red")
lines(data$Time, data$Sub_metering_3, type= "l", col = "blue")
legend("topright", legend=names(data[7:9]), lwd=c(1,1,1), col=c("black", "red", "blue"), bty= "n")
plot(data$Time, data$Global_reactive_power, type= "l", ylab = "Global_reactive_power", xlab = "daytime")
dev.off()