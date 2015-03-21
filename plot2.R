library("dplyr")

NEI <- function(){
  readRDS(paste(getwd(),"/datasets/summarySCC_PM25.rds",sep=""))
}

SCC <- function(){
  readRDS(paste(getwd(),"/datasets/Source_Classification_Code.rds",sep=""))
}

baltimoreNEI <- NEI() %>% filter(fips == "24510")
dataWithEmissionsYear <- baltimoreNEI %>% select(Emissions,year)
summary <- aggregate(Emissions ~ year, dataWithEmissionsYear, FUN=sum)
barplot(summary$Emissions, summary$year, xlab="Year", ylab="Fine Particulate Matter (PM2.5)", names.arg=summary$year, ylim=range(0,max(summary$Emissions)), 
        main="Total PM2.5 Emissions in Baltimore")
dev.copy(png,file="plot2.png",width=480,height=480)
dev.off()  