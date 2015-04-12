
#Load The Data
hh_power <- read.table("./household_power_consumption.txt",
                       header = TRUE,
                       sep = ";",
                       stringsAsFactor= FALSE,
                       na.strings="?")


#Add DateTime Variable
hh_power$Date <- as.Date(hh_power$Date,"%d/%m/%Y")
hh_power$DateTime <-  paste(hh_power$Date,hh_power$Time)
hh_power$DateTime <- strptime(hh_power$DateTime,"%Y-%m-%d %H:%M:%S")


#Subset the data by the date
hh_power <- hh_power[hh_power$Date >= as.Date("2007-02-01","%Y-%m-%d") & hh_power$Date <= as.Date("2007-02-02","%Y-%m-%d"),]
hh_power <- na.omit(hh_power)

#Tidying the data
hh_power[,3:8] <- lapply(hh_power[,3:8],FUN = function(x){as.numeric(x)})

#Create and export the plot to png
png(filename = "plot1.png",width = 480, height = 480, units = "px")
with(hh_power, hist(Global_active_power,
                    xlab = "Global Active Power (kilowatts)",
                    main = "Global Active Power",
                    col="red"),) ## Create plot on screen device
dev.off() ## Don't forget to close the PNG device!

