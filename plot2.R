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

if(!require(dplyr)) install.packages("dplyr")
baltimore <- filter(NEI, fips == "24510")
agg <- aggregate(Emissions ~ year, FUN=sum, data=baltimore)

png("plot2.png")
barplot(agg$Emissions, names.arg=agg$year, 
        xlab="Year", ylab="Emissions (tons)", 
        main="Total PM2.5 Emissions in Baltimore City, MD")
dev.off()