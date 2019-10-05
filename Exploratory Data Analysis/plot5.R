# Question 5
## How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

# Load libraries
library(plyr)
library(ggplot2)

# Read in data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Motor vehicle sources
mv = grep(levels(SCC$SCC.Level.Two),pattern="Vehicle",value=TRUE)
SCC.mv = as.vector(SCC[which(SCC$SCC.Level.Two %in% mv),]$SCC)

# Get data for Baltimore City,  Maryland, motor vehicle sources
NEI.byYear.Baltimore.MV = ddply(NEI[which(NEI$fips == "24510" & NEI$SCC %in% SCC.mv),],.(year),summarise,Emissions=sum(Emissions))

# Plot
ggplot(NEI.byYear.Baltimore.MV,aes(x=year,y=Emissions)) + geom_point() + ggtitle("Total emissions, Baltimore City, Maryland, Motor vehicle sources") + xlab("Year") + ylab("PM2.5 emitted (tons)") + theme_classic() 
