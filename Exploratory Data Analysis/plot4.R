# Question 4
## Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?

# Load libraries
library(plyr)
library(ggplot2)

# Read in data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Coal sources
coal = grep(levels(SCC$SCC.Level.Three),pattern="Coal",value=TRUE)
SCC.coal = as.vector(SCC[which(SCC$SCC.Level.Three %in% coal),]$SCC)

# Aggregate by year
NEI.byYear.Coal = ddply(NEI[which(NEI$SCC %in% SCC.coal),],.(year),summarise,Emissions=sum(Emissions))

# Plot
ggplot(NEI.byYear.Coal,aes(x=year,y=Emissions)) + geom_point() + ggtitle("Total emissions, United States, Coal-related") + xlab("Year") + ylab("PM2.5 emitted (tons)") + theme_classic()
