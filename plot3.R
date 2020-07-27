##Loading required Packages

library(dplyr)

##Download data


filezip="HPC.zip" #Name of zipfile in my working repository

if (!file.exists(filezip)){
  link_Url_data <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(link_Url_data, filezip)
}


# Checking if folder exists and to unzip into under folder named HPC
if (!file.exists("HPC")) { 
  unzip(filezip) 
}


##Import  data frame

data_hpc = read.table("household_power_consumption.txt", sep=";", dec = ".", header = TRUE,na.strings = "?")


##convert the Date and Time variables to Date/Time classes 
Sys.setlocale("LC_TIME", "C") 
data_hpc$Time=strptime(paste(data_hpc$Date,data_hpc$Time), "%d/%m/%Y %H:%M:%S",tz = "")
data_hpc$Date=as.Date(data_hpc$Date,"%d/%m/%Y")
data_hpc$day=weekdays(data_hpc$Date,abbreviate = TRUE)

##Select appropriated range 
data_hpc_plot3=data_hpc[(data_hpc$Date>="2007-02-01" & data_hpc$Date<="2007-02-02"),]

##Plot graphs
png("plot3.png", width = 480, height = 480)

plot(data_hpc_plot3$Time,data_hpc_plot3$Sub_metering_1,xlab="",
                      ylab="energy sub metering",main= " ","l")
lines(data_hpc_plot3$Time,data_hpc_plot3$Sub_metering_2,col="red")
lines(data_hpc_plot3$Time,data_hpc_plot3$Sub_metering_3,col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"),
       text.col = "black", lty = c(1, 1, 1),
       merge = TRUE)

dev.off()


