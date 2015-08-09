#This code reads the data from the "household_power_consumption.txt" file and subsets the data required. 
#It then creates a plot of the Global Active Power vs. datetime

df<-read.table("household_power_consumption.txt",header=TRUE,sep=";",stringsAsFactors = FALSE)#Reading data from file
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
#Creating plot of global active power vs. datetime for the period of interest.
with(df_1, {
  plot(Comb_DT_POS,Global_active_power,type="n",ylab="Global Active Power (kilowatts)",xlab="")
  lines(Comb_DT_POS,Global_active_power)
})
dev.copy(png,file="plot2.png",width=480,height=480) #creating a plot in the png graphics device
dev.off()
