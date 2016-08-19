# this will download the data set, if it is not found on working directory

if(!file.exists("./summarySCC_PM25.rds") & file.exists("./Source_Classification_Code.rds")) {
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
  download.file(fileUrl, destfile="./FNEI_data.zip")
  unzip(zipfile="./FNEI_data.zip")
}

# loads the files

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# plotting function

i <- grepl("[Cc]omb.*[Cc]oal", SCC$EI.Sector)
SCC_coal <- SCC[i, 1]
SCC_coal <- as.character(SCC_coal)

if(!require(dplyr)) install.packages("dplyr")

coal <- data.frame()
for (i in SCC_coal) {
  sub <- NEI %>% filter(SCC == i) %>% select(year, Emissions)
  coal <- rbind(coal, sub)
}
agg <- aggregate(Emissions ~ year, FUN=sum, data=coal)

png("plot4.png", width = 600)
barplot(agg$Emissions, names.arg=agg$year, 
        xlab="Year", ylab="Emissions (tons)", 
        main="US Total PM2.5 Emissions from Coal Combustion-related Sources")
dev.off()