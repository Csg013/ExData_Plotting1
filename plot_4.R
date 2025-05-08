#colby grames
#EDA mod 1 proj 1

library(readr)
df<- read_delim("household_power_consumption.txt", delim = ";", col_types = cols())


#format and load data as feb df to be tidy
feb <- subset(df, Date %in% c('1/2/2007', '2/2/2007'))
feb$Global_active_power <- as.numeric(feb$Global_active_power)
date_string <- paste(feb$Date, feb$Time)
feb$DateTime <- as.POSIXct(date_string, format = "%d/%m/%Y %H:%M:%S", tz = "UTC")
feb$Voltage <- as.numeric(feb$Voltage)
feb$Global_reactive_power <- as.numeric(feb$Global_reactive_power)


#open device
png(filename = "plot4.png", units ="px", width=480, height = 480)

#change settings to account for 4 graphs in pannel
par(mfrow = c(2,2))

#plot 1 from script 2
plot(feb$DateTime, feb$Global_active_power, type = "l", xaxt = "n", xlab = "", ylab = "Global Active Power (kilowatts)" )
axis.POSIXct(1, at = seq(from = as.POSIXct("2007-02-01"), to = as.POSIXct("2007-02-04"), by = 'day'), format = "%a")
axis(1, at = max(feb$DateTime), labels = "Sat", tick = TRUE)

#plot 2 new plot from scratch
plot(feb$DateTime, feb$Voltage, type = "l", xaxt = "n", xlab = "datetime", ylab = "Voltage")

#change axis/ticks
axis.POSIXct(1, at = seq(from = as.POSIXct("2007-02-01"), to = as.POSIXct("2007-02-04"), by = 'day'), format = "%a")
axis(1, at = max(feb$DateTime), labels = "Sat", tick = TRUE)


#plot 3 from script 3
plot(feb$DateTime, feb$Sub_metering_1, type = "l", xaxt = "n", xlab = "", ylab = "Global Active Power (kilowatts)" )
lines(feb$DateTime, feb$Sub_metering_2, col = "red")
lines(feb$DateTime, feb$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c('black', "blue", "red"), lty = 1, bty = "n")
ticks <- as.POSIXct(c("2007-02-01","2007-02-02","2007-02-03"))
axis(1, at = ticks, labels = c("Thu","Fri","Sat"))
axis(1, at = max(feb$DateTime), labels = "Sat", tick = TRUE)


#plot 4 from scratch
plot(feb$DateTime, feb$Global_reactive_power, type = "l", xaxt = 'n', xlab = "datetime", ylab = "Global_reactive_power")

#change axis/ticks
axis.POSIXct(1, at = seq(from = as.POSIXct("2007-02-01"), to = as.POSIXct("2007-02-04"), by = 'day'), format = "%a")
axis(1, at = max(feb$DateTime), labels = "Sat", tick = TRUE)


#close device to save
dev.off()
