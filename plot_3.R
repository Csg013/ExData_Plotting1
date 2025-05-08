#colby grames
#EDA mod 1 proj 1

library(readr)
df<- read_delim("household_power_consumption.txt", delim = ";", col_types = cols())


#format and load data as feb df to be tidy

feb <- subset(df, Date %in% c('1/2/2007', '2/2/2007'))
feb$Global_active_power <- as.numeric(feb$Global_active_power)
date_string <- paste(feb$Date, feb$Time)
feb$DateTime <- as.POSIXct(date_string, format = "%d/%m/%Y %H:%M:%S", tz = "UTC")
feb$Sub_metering_1 <- as.numeric(feb$Sub_metering_1)
feb$Sub_metering_2 <- as.numeric(feb$Sub_metering_2)
feb$Sub_metering_3 <- as.numeric(feb$Sub_metering_3)

#open png device
png(filename = "plot3.png", units ="px", width=480, height = 480)

#plot initial then add 2 additional series
plot(feb$DateTime, feb$Sub_metering_1, type = "l", xaxt = "n", xlab = "", ylab = "Global Active Power (kilowatts)" )
lines(feb$DateTime, feb$Sub_metering_2, col = "red")
lines(feb$DateTime, feb$Sub_metering_3, col = "blue")

#add and modfy legend
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c('black', "blue", "red"), lty = 1)

#edit tick/axis to make like example image

ticks <- as.POSIXct(c("2007-02-01","2007-02-02","2007-02-03"))
axis(1, at = ticks, labels = c("Thu","Fri","Sat"))
axis(1, at = max(feb$DateTime), labels = "Sat", tick = TRUE)
dev.off()
