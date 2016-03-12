#clear things out
rm(list=ls())

#set my WD
setwd('C:\\data\\exploratory-data-analysis\\ExData_Plotting1\\')

zipFileName<-"exdata-data-household_power_consumption.zip"
#Get the zip
if (!file.exists(zipFileName)) {
    fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileURL, destfile = zipFileName, extra='-L',mode='wb')
}

#extract it
fileName<-"household_power_consumption.txt"
if (!file.exists(fileName)) {   unzip(zipFileName) }

#load into a data frame
power<-read.delim(fileName,header=T,sep=";",na.strings="?")
library(lubridate)
power$Date2<-dmy(power$Date)
p21<-subset(power,Date2==mdy("2/1/2007")|Date2==mdy("2/2/2007"))
p21$DateTime<-strptime(paste(p21$Date, p21$Time),format="%d/%m/%Y %H:%M:%S")

p21$Global_active_power<-as.numeric(p21$Global_active_power)
png(filename = "plot4.png")

par(mfcol=c(2,2))

plot(p21$DateTime,p21$Global_active_power,type = "l",xlab="",ylab="Global Active Power")

plot(p21$DateTime,p21$Sub_metering_1,type="l",xlab="",ylab="Energy sub metering",col="black")
points(p21$DateTime,p21$Sub_metering_2,type="l",xlab="",ylab="",col="red")
points(p21$DateTime,p21$Sub_metering_3,type="l",xlab="",ylab="",col="blue")
legend("topright",lty=1,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

plot(p21$DateTime,p21$Voltage,type = "l",xlab="datetime",ylab="Voltage")

plot(p21$DateTime,p21$Global_reactive_power,type = "l",xlab="datetime",ylab="Global_reactive_power",ylim=c(0, 0.5))


dev.off()


