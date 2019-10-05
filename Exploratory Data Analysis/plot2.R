# Question 2
## Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question.

# Load libraries
library(plyr)

# Read in data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Get data for Baltimore City,  Maryland data
NEI.byYear.Baltimore = ddply(NEI[which(NEI$fips == "24510"),],.(year),summarise,Emissions=sum(Emissions))

# Plot
plot(NEI.byYear.Baltimore$year,NEI.byYear.Baltimore$Emissions,main="Total emissions, Baltimore City, Maryland",xlab="Year",ylab="PM2.5 emitted (tons)")
