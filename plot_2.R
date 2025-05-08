#colby grames
#EDA mod 1 proj 1

library(readr)
df<- read_delim("household_power_consumption.txt", delim = ";", col_types = cols())

#format and load data as feb df to be tidy

feb <- subset(df, Date %in% c('1/2/2007', '2/2/2007'))
feb$Global_active_power <- as.numeric(feb$Global_active_power)
date_string <- paste(feb$Date, feb$Time)
feb$DateTime <- as.POSIXct(date_string, format = "%d/%m/%Y %H:%M:%S", tz = "UTC")

#open png device
png(filename = "plot2.png", units ="px", width=480, height = 480)


#plot data into device
plot(feb$DateTime, feb$Global_active_power, type = "l", xaxt = "n", xlab = "", ylab = "Global Active Power (kilowatts)" )

#fix axis and ticks to be like example
axis.POSIXct(1, at = seq(from = as.POSIXct("2007-02-01"), to = as.POSIXct("2007-02-04"), by = 'day'), format = "%a")
axis(1, at = max(feb$DateTime), labels = "Sat", tick = TRUE)

#close device to save
dev.off()
