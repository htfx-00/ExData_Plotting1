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

data_hpc$Time=strptime(paste(data_hpc$Date,data_hpc$Time), "%d/%m/%Y %H:%M:%S")
data_hpc$Date=as.Date(data_hpc$Date,"%d/%m/%Y")

##Select appropriated range 

data_hpc_plot1=data_hpc[(data_hpc$Date>="2007-02-01" & data_hpc$Date<="2007-02-02"),]

##Plot graph
png("plot1.png", width = 480, height = 480)
plot1=hist(data_hpc_plot1$Global_active_power, col=2, xlab="Global Active Power (kilowatts)",main= "Global Active Power")
dev.off()