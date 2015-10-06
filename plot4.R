## This script downloads the UCI Individual household electric power 
## consumption Data Set and plots ...

plot4 <- function() {

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
    
    #Initialise graph
    png("plot4.png", width=480, height=480)
    par(mfcol=c(2,2))
    
    #Graph 1
    plot(myData$DateTime, myData$Global_active_power, type="l",
         ylab="Global Active Power (kilowatts)", xlab="")

    #Graph 2
    plot(myData$DateTime, myData$Sub_metering_1, type="l",
         ylab="Energy sub metering", xlab="")
    lines(myData$DateTime, myData$Sub_metering_2,col="red")
    lines(myData$DateTime, myData$Sub_metering_3,col="blue")
    legend("topright",names(myData)[7:9], lty=c(1,1,1), 
           col = c("black", "red","blue"), xjust="right")

    #Graph 3
    plot(myData$DateTime, myData$Voltage, type="l",
         ylab="Voltage", xlab="datetime")
    
    #Graph 4
    plot(myData$DateTime, myData$Global_reactive_power, type="l",
         ylab="Global_reactive_power", xlab="datetime")
    
    dev.off()
    }