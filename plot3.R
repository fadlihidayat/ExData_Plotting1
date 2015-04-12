
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

png(filename = "plot3.png",width = 480, height = 480, units = "px")
plot(hh_power$DateTime,hh_power$Sub_metering_1,
     xlab ="",
     ylab = "Energy Sub metering",
     type="n",
)
lines(hh_power$DateTime,hh_power$Sub_metering_1,type = "l",col="black",lty=1)
lines(hh_power$DateTime,hh_power$Sub_metering_2,type = "l",col="red",lty=1)
lines(hh_power$DateTime,hh_power$Sub_metering_3,type = "l",col="blue",lty=1)
legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1,col=c("black","red","blue"))

dev.off() ## Don't forget to close the PNG device!
