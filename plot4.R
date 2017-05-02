#download file
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile="./data/Dataset.zip",method="curl")

#unzip the file
unzip(zipfile="./data/Dataset.zip",exdir="./data")

#Read File with only including rows from date 1/2/2007 to 2/2/2007
header <- read.table("./data/household_power_consumption.txt", nrows = 1, header = FALSE, sep =';', stringsAsFactors = FALSE,na.strings="?")
dat  <- read.table("./data/household_power_consumption.txt", sep =';', skip =66637 , nrows=2880)
colnames(dat) <- unlist(header)
head(dat)
tail(dat)

#Combine date and time and convert to date time classes
dat$DateTime <- strptime(paste(dat$Date, dat$Time, sep = ""), "%d/%m/%Y %H:%M:%S")

#Plot 3 and save as file device
par(mfrow = c(2,2))
par(mar = c(4,4,2,2))
plot(dat$DateTime, dat$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")
plot(dat$DateTime, dat$Voltage, type = "l", ylab = "Voltage", xlab = "")
plot(dat$DateTime, dat$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(dat$DateTime, dat$Sub_metering_2, col = "red")
lines(dat$DateTime, dat$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = 1, lwd = 1, col = c("black", "red", "blue"))
plot(dat$DateTime, dat$Global_reactive_power, type = "l", xlab = "", ylab = "Global Reactive Power (kilowatts)")

dev.copy(png, file = "plot4.png" ,width = 480, height = 480)  
dev.off()