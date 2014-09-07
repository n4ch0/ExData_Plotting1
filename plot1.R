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
png("C:/Users/Nacho/Documents/plot1.png")
hist(data$Global_active_power,col="red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()