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
baltimore <- NEI %>% filter(fips == "24510") %>% select(year, type, Emissions)
agg <- aggregate(Emissions ~ year+type, FUN=sum, data=baltimore)

if(!require(ggplot2)) install.packages("ggplot2")
bar <- ggplot(agg, aes(x=factor(year), y=Emissions, fill=type))
bar + geom_bar(stat="identity", position="dodge") + guides(fill=guide_legend(reverse=TRUE)) + 
  labs(x="Year", y="Emissions (tons)", title="Total PM 2.5 Emissions in Baltimore City, MD by Type", fill="Type")
ggsave(file="plot3.png")