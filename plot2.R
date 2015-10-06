## This script downloads the UCI Individual household electric power 
## consumption Data Set and plots Global Active Power over time.

plot2 <- function() {

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
    
    #Add column for converted date/time
    myData$DateTime<-strptime(paste(myData$Date,myData$Time),"%d/%m/%Y %H:%M:%S")
    
    #display chart and save to file
    plot(myData$DateTime, myData$Global_active_power, type="l",
         ylab="Global Active Power (kilowatts)", xlab="")
    dev.copy(png, file="plot2.png", width = 480, height = 480)
    dev.off()    
}