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
power$Date<-dmy(power$Date)
p21<-subset(power,Date==mdy("2/1/2007")|Date==mdy("2/2/2007"))
p21$Global_active_power<-as.numeric(p21$Global_active_power)
png(filename = "plot1.png")
hist(p21$Global_active_power,breaks=13,col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)")
dev.off()


