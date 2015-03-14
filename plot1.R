library("dplyr")

NEI <- function(){
  readRDS(paste(getwd(),"/datasets/summarySCC_PM25.rds",sep=""))
}

SCC <- function(){
  readRDS(paste(getwd(),"/datasets/Source_Classification_Code.rds",sep=""))
}

dataWithEmissionsYear <- rawData %>% select(Emissions,year) %>% filter(year %in% c(1999,2002,2005,2008))
summary <- aggregate(Emissions ~ year, dataWithEmissionsYear, FUN=sum)
barplot(summary$Emissions, summary$year, xlab="Year", ylab="Fine Particulate Matter (PM2.5)", 
        names.arg=summary$year, ylim=range(0,max(summary$Emissions) + 1e+06))
dev.copy(png,file="plot1.png",width=480,height=480)
dev.off()  