## This script downloads the UCI Individual household electric power 
## consumption Data Set and plots the Global Active Power against
## frequency.

plot1 <- function() {
    
    # Set constants
    fileName="household_power_consumption.txt"
    fileURL="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    
    # Download and uncompress data from Internet 
    if(!file.exists(fileName)) {
        myTemp <- tempfile()
        download.file(fileURL, myTemp)
        unzip(myTemp, overwrite = TRUE)
        unlink(myTemp)
    }
    
    # Identify column classes and load data
    myClasses <- sapply(read.table(fileName, nrows=1, sep=";", header=TRUE),
                class)
    myData<-read.table(fileName, na.strings="?", header = TRUE, sep = ";", 
                colClasses = myClasses)
    myRows<-myData$Date=="1/2/2007"|myData$Date=="2/2/2007"
    myData<-myData[myRows,]

    #display chart and save to file
    hist(myData$Global_active_power, col="red", main="Global Active Power", 
                xlab="Global Active Power (kilowatts)")
    dev.copy(png, file="plot1.png", width = 480, height = 480)
    dev.off()

}