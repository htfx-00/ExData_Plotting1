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
data_hpc_plot4=data_hpc[(data_hpc$Date>="2007-02-01" & data_hpc$Date<="2007-02-02"),]

##Plot graphs
png("plot4.png", width = 480, height = 480)

  layout(matrix(1:4,2,2))
  
  plot(data_hpc_plot4$Time,data_hpc_plot4$Global_active_power, ylim=c(0,6),xlab="",
             ylab="Global Active Power",main= " ","l")
   
  
  plot(data_hpc_plot4$Time,data_hpc_plot4$Sub_metering_1,xlab="",ylab="energy sub metering",main= " ","l")
  lines(data_hpc_plot4$Time,data_hpc_plot4$Sub_metering_2,col="red")
  lines(data_hpc_plot4$Time,data_hpc_plot4$Sub_metering_3,col="blue")
  legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"),
         text.col = "black", lty = c(1, 1, 1),
         merge = TRUE)
  
  plot(data_hpc_plot4$Time,data_hpc_plot4$Voltage,xlab="datetime",
       ylab="Voltage",main= " ","l")
  
  
  plot(data_hpc_plot4$Time,data_hpc_plot4$Global_reactive_power,xlab="datetime",
       ylab="Global_reactive_power",main= " ","l")



dev.off()


