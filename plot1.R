# Read header and only read a subset of the data
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
household$Global_active_power <- as.numeric(household$Global_active_power)

#Initialize png device as dev.copy seems to have problem
png(filename = 'plot1.png', width = 480, height = 480, units = 'px')

#Plot histrogram
hist(household$Global_active_power, col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")


#Close device to conclude the png
dev.off()

#Some cleaning
rm(household)