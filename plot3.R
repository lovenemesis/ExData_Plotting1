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
png(filename = 'plot3.png', width = 480, height = 480, units = 'px')

#Plot lines with legend
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
       )

#Close device to conclude the png
dev.off()

#Some cleaning
rm(household)