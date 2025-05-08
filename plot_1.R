#colby grames
#EDA mod 1 proj 1

library(readr)
df<- read_delim("household_power_consumption.txt", delim = ";", col_types = cols())


#format and load data as feb df to be tidy

feb <- subset(df, Date %in% c('1/2/2007', '2/2/2007'))
feb$Global_active_power <- as.numeric(feb$Global_active_power)

#open png device
png(filename = "plot1.png", units ="px", width=480, height = 480)
#plot into device
hist(feb$Global_active_power, col = "red", xlab = "Global Active Power (Kilowatts)", main = "Global Active Power")

#close device to save
dev.off()
