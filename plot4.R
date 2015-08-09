#This code reads the data from the "household_power_consumption.txt" file and subsets the data required. 
#It then creates a panel of 4 plots 
 
df<-read.table("household_power_consumption.txt",header=TRUE,sep=";",stringsAsFactors = FALSE) #Reading data from file
library(data.table)
dt<-data.table(df) #converting to data.table()
setkey(dt,Date)
dt_sub<-dt[c('1/2/2007','2/2/2007')] #subsetting the data of interest
dt_sub$Date<-as.Date(dt_sub$Date,"%d/%m/%Y") #Converting the Date column to Date class
Comb_DT<-paste(dt_sub$Date,dt_sub$Time) #Combining the date and time fields to use as.POSIXct() command
dt_sub$Comb_DT_POS<-as.POSIXct(Comb_DT,"%Y-%m-%d %H:%M:%S",tz="")
df_1<-data.frame(dt_sub)
for(i in 3:9) {
  df_1[,i]=as.numeric(df_1[,i])
}

##Creating a panel of 4 plots
png("plot4.png",width=480,height=480) #Printing plot directly to the png graphics device
par(mfcol=c(2,2))
with(df_1, {
  plot(Comb_DT_POS,Global_active_power,type="n",ylab="Global Active Power (kilowatts)",xlab="") #Plot#1
  lines(Comb_DT_POS,Global_active_power)
  
  plot(Comb_DT_POS,Sub_metering_1,type="n",ylab="Energy sub metering",xlab="") #Plot#2
  lines(Comb_DT_POS,Sub_metering_1,col="black")
  lines(Comb_DT_POS,Sub_metering_2,col="red")
  lines(Comb_DT_POS,Sub_metering_3,col="blue")
  legend("topright",bty="n",lty=c(1,1,1),col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  
  plot(Comb_DT_POS,Voltage,type="n",ylab="Voltage",xlab="datetime") #Plot#3
  lines(Comb_DT_POS,Voltage)
  
  plot(Comb_DT_POS,Global_reactive_power,type="n",ylab="Global_reactive_power",xlab="datetime") #Plot#4
  lines(Comb_DT_POS,Global_reactive_power)
})
dev.off()
