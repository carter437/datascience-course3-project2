library("dplyr")
library("ggplot2")

NEI <- function(){
  readRDS(paste(getwd(),"/datasets/summarySCC_PM25.rds",sep=""))
}

SCC <- function(){
  readRDS(paste(getwd(),"/datasets/Source_Classification_Code.rds",sep=""))
}

coalScc <- (SCC() %>% filter(grepl("coal",EI.Sector,ignore.case=T)) %>% select(SCC) %>% unique %>% sapply(as.character))[,1]
coalNei <- NEI() %>% filter(SCC %in% coalScc) %>% select(-SCC,-fips,-type,-Pollutant) %>% group_by(year) %>% summarize(totalEmissions=sum(Emissions))
ggplot(data=coalNei, aes(x=year, y=totalEmissions)) + labs(title="Total Emissions in the US\n from Coal Combustion Related Sources") + 
  xlab("Year") + ylab("Fine Particulate Matter (PM2.5)") + geom_line() + geom_point()
dev.copy(png,file="plot4.png",width=480,height=480)
dev.off()