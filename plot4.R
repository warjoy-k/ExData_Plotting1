## Downloading data if it does not exist
if (!file.exists("./household_power_consumption.txt")) {
	fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
	downloadTime <- Sys.time()
	download.file(fileUrl, destfile = "./data.zip", method = "curl")
	unzip("./data.zip", exdir=".")
	file.remove("./data.zip")	
}

## Preparing data
data = read.table("./household_power_consumption.txt", sep=";", na.strings="?", nrows=2880, skip=66637)
colnames(data) = c("datetime", "time", "gap", "grp", "voltage", "global_intensity", "sub_metering_1", "sub_metering_2", "sub_metering_3")
xxx <- strptime(paste(data$datetime, data$time, sep=" "), "%d/%m/%Y %H:%M:%S")
data$datetime <- xxx
data$time <- NULL

## Plotting
png("plot4.png", width = 480, height = 480)
par(mfcol=c(2,2))
## Plot 1
plot(data$datetime, data$gap, type="l", xlab="", ylab="Global Active Power")

## Plot 2
plot(data$datetime, data$sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(data$datetime, data$sub_metering_2, type="l", col = "red")
lines(data$datetime, data$sub_metering_3, type="l", col = "blue")
legend("topright", pch=151, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Plot 3
plot(data$datetime, data$voltage, type = "l", xlab="datetime", ylab="Voltage")

## Plot 4
plot(data$datetime, data$grp, type = "l", xlab="datetime", ylab="Global_reactive_power")

## Saving
dev.off()