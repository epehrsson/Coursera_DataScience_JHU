# Question 6
## Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?

# Load libraries
library(plyr)
library(ggplot2)

# Read in data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Motor vehicle sources
mv = grep(levels(SCC$SCC.Level.Two),pattern="Vehicle",value=TRUE)
SCC.mv = as.vector(SCC[which(SCC$SCC.Level.Two %in% mv),]$SCC)

# Get data for Baltimore City, Maryland and Los Angelos County, California, motor vehicle sources
NEI.byYear.BM.LA.MV = ddply(NEI[which(NEI$fips %in% c("24510","06037") & NEI$SCC %in% SCC.mv),],.(year,fips),summarise,Emissions=sum(Emissions))

# Plot
ggplot(NEI.byYear.BM.LA.MV,aes(x=year,y=Emissions,color=fips,group=fips)) + geom_point() + geom_line() + ggtitle("Total emissions, Motor vehicle sources") + xlab("Year") + ylab("PM2.5 emitted (tons)") + theme_classic() + scale_color_discrete(name="Location",labels=c("Los Angeles","Baltimore"))
