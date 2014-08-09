#Read header and only read a subset of the data
household_name <- read.csv2(file = "household_power_consumption.txt",
                            na.strings = "?",
                            comment.char = "",
                            stringsAsFactors = FALSE,
                            nrows = 3)

household <- read.csv2(file = "household_power_consumption.txt",
                       na.strings = "?",
                       comment.char = "",
                       stringsAsFactors = FALSE,
                       skip = 66637,
                       nrows = 2879)

names(household) <- names(household_name)
rm(household_name)


#Type convert
household$DateTime <- as.POSIXct(paste(as.Date(household$Date, "%d/%m/%Y"),
                                       household$Time,
                                       sep = " ")
)

# Set LC_TIME to en_US to show proper weekday
Sys.setlocale(category = "LC_TIME", locale = "en_US.UTF-8")

#Initialize png device as dev.copy seems to have problem
png(filename = 'plot4.png', width = 480, height = 480, units = 'px')

#Devide canvas into 2*2
par(mfrow = c(2,2))

# #1 Global Active Power
plot(household$DateTime, household$Global_active_power, type="l",
     ylab = "Global Active Power (kilowatts)",
     xlab = "")

# #2 Voltage
plot(household$DateTime, household$Voltage, type="l",
     ylab = "Voltage",
     xlab = "datetime")

# #3 Sub_metering
plot(x = household$DateTime,
     y = household$Sub_metering_1,
     col = "black",
     type = "l",
     ylab = "Energy sub metering",
     xlab = "")
lines(x = household$DateTime, y = household$Sub_metering_2, col="red")
lines(x = household$DateTime, y = household$Sub_metering_3, col="blue")
legend("topright", lty = 1, col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       bty = "n"
       )

# #4 Global_reactive_power
plot(household$DateTime, household$Global_reactive_power, type="l",
     ylab = "Global_reactive_power",
     xlab = "datetime")

#Close device to conclude the png
dev.off()

#Some cleaning
rm(household)