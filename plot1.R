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

agg <- tapply(NEI$Emissions, NEI$year, sum)

png("plot1.png")
barplot(agg, 
        xlab="Year", ylab="Emissions (tons)", 
        main="US Total PM2.5 Emissions, 1999-2008")
dev.off()