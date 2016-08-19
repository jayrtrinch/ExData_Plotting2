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
sub <- subset(NEI, fips == "24510" | fips == "06037")
veh <- sub[sub$SCC %in% SCC_veh, ]

if(!require(ggplot2)) install.packages("ggplot2")
bar <- ggplot(veh, aes(x=factor(year), y=Emissions, fill=fips))
bar + geom_bar(stat="identity") + facet_grid(.~fips) + 
  labs(x="Year", y="Emissions (tons)", title="Total PM 2.5 Emissions from Motor Vehicle Sources", fill="County") + 
  scale_fill_discrete(labels = c("Los Angeles, CA", "Baltimore, MD"))
ggsave(file="plot6.png")