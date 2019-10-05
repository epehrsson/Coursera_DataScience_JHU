# Question 1
## Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

# Load libraries
library(plyr)

# Read in data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Aggregate by year
NEI.byYear = ddply(NEI,.(year),summarise,Emissions=sum(Emissions))

# Plot
plot(NEI.byYear$year,NEI.byYear$Emissions,main="Total emissions, United States",xlab="Year",ylab="PM2.5 emitted (tons)")
