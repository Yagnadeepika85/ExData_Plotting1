df<-read.table("household_power_consumption.txt",header=TRUE,sep=";",stringsAsFactors = FALSE)
library(data.table)
dt<-data.table(df)
setkey(dt,Date)
dt_sub<-dt[c('1/2/2007','2/2/2007')]
dt_sub$Date<-as.Date(dt_sub$Date,"%d/%m/%Y")
Comb_DT<-paste(dt_sub$Date,dt_sub$Time)
dt_sub$Comb_DT_POS<-as.POSIXct(Comb_DT,"%Y-%m-%d %H:%M:%S",tz="")
df_1<-data.frame(dt_sub)
for(i in 3:9) {
  df_1[,i]=as.numeric(df_1[,i])
}
with(df_1, {
  plot(Comb_DT_POS,Global_active_power,type="n",ylab="Global Active Power (kilowatts)",xlab="")
  lines(Comb_DT_POS,Global_active_power)
})
dev.copy(png,file="plot2.png",width=480,height=480)
dev.off()
