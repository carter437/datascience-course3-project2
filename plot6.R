library("dplyr")
library("ggplot2")

NEI <- function(){
  readRDS(paste(getwd(),"/datasets/summarySCC_PM25.rds",sep=""))
}

SCC <- function(){
  readRDS(paste(getwd(),"/datasets/Source_Classification_Code.rds",sep=""))
}

vehicleSccBaltLa <- (SCC() %>% filter(grepl("mobile",EI.Sector,ignore.case=T)) %>% select(SCC) %>% unique %>% sapply(as.character))[,1]
vehicleNeiBaltLa <- NEI() %>% filter(fips %in% c("24510","06037")) %>% filter(SCC %in% vehicleSccBaltLa) %>% select(-SCC,-type,-Pollutant) %>% group_by(fips,year) %>% summarize(totalEmissions=sum(Emissions))
ggplot(data=vehicleNeiBaltLa, aes(x=year, y=totalEmissions, group=fips, color=fips)) + labs(title="Total Emissions\n from Motor Vehicle Sources") + 
  xlab("Year") + ylab("Fine Particulate Matter (PM2.5)") + scale_color_manual("Cities\n",labels = c("Los Angeles", "Baltimore"), values=c("blue","red")) + 
  geom_line() + geom_point()
dev.copy(png,file="plot6.png",width=480,height=480)
dev.off()