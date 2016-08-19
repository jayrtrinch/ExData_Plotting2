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

i <- grepl("[Vv]ehicles", SCC$EI.Sector)
SCC_veh <- SCC[i, 1]
baltimore <- subset(NEI, fips == "24510") 
veh <- baltimore[baltimore$SCC %in% SCC_veh, ]
agg <- with(veh, tapply(Emissions, year, sum))

png("plot5.png", width = 600)
barplot(agg, 
        xlab="Year", ylab="Emissions (tons)", 
        main="Total PM2.5 Emissions from Motor Vehicle Sources in Baltimore City, MD")
dev.off()