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
png("plot2.png", width = 480, height = 480)
plot(data$datetime, data$gap, type="l", xlab="", ylab="Global Active Power (kilowatts)")

## Saving
dev.off()