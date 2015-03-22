library("dplyr")
library("ggplot2")

NEI <- function(){
  readRDS(paste(getwd(),"/datasets/summarySCC_PM25.rds",sep=""))
}

SCC <- function(){
  readRDS(paste(getwd(),"/datasets/Source_Classification_Code.rds",sep=""))
}

baltimoreNEI <- NEI() %>% filter(fips == "24510")
dataWithEmissionsYear <- baltimoreNEI %>% select(Emissions,year,type)
#Rearrange Columns, Rename Columns, Group By Year and Pollution Type, Sum up Emissions
dataWithEmissionsYear <- dataWithEmissionsYear[,c(2,3,1)] %>% rename(pollutionType=type) %>% 
  group_by(year, pollutionType) %>% summarize(totalEmissions=sum(Emissions))
ggplot(data=dataWithEmissionsYear, aes(x=year, y=totalEmissions, group=pollutionType, color=pollutionType)) + 
  xlab("Year") + ylab("Fine Particulate Matter (PM2.5)") + labs(title="Baltimore City\n Total Emmissions by Type") + geom_line() + geom_point()
dev.copy(png,file="plot3.png",width=480,height=480)
dev.off()  