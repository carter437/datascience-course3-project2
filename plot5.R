library("dplyr")
library("ggplot2")

NEI <- function(){
  readRDS(paste(getwd(),"/datasets/summarySCC_PM25.rds",sep=""))
}

SCC <- function(){
  readRDS(paste(getwd(),"/datasets/Source_Classification_Code.rds",sep=""))
}

vehicleScc <- (SCC() %>% filter(grepl("mobile",EI.Sector,ignore.case=T)) %>% select(SCC) %>% unique %>% sapply(as.character))[,1]
vehicleNei <- NEI() %>% filter(fips == "24510") %>% filter(SCC %in% vehicleScc) %>% select(-SCC,-fips,-type,-Pollutant) %>% group_by(year) %>% summarize(totalEmissions=sum(Emissions))
ggplot(data=vehicleNei, aes(x=year, y=totalEmissions)) + labs(title="Total Emissions in Balitmore\n from Motor Vehicle Sources") + 
  xlab("Year") + ylab("Fine Particulate Matter (PM2.5)") + geom_line() + geom_point()
dev.copy(png,file="plot5.png",width=480,height=480)
dev.off()