# Question 3
## Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? Which have seen increases in emissions from 1999-2008? Use the ggplot2 plotting system to make a plot answer this question.

# Load libraries
library(plyr)
library(ggplot2)

# Read in data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Get data for Baltimore City,  Maryland
NEI.byYearType.Baltimore = ddply(NEI[which(NEI$fips == "24510"),],.(year,type),summarise,Emissions=sum(Emissions))

# Plot
ggplot(NEI.byYearType.Baltimore,aes(x=year,y=Emissions,color=type,group=type)) + geom_point() + geom_line() + ggtitle("Total emissions, Baltimore City, Maryland") + xlab("Year") + ylab("PM2.5 emitted (tons)") + theme_classic() + scale_color_discrete(name="Type")
