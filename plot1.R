##
## filename: plot1.R
## - This R script generates the histogram and saves it into PNG file, 'plot1.png',
## in the same directory where the script is run.
##
library(dplyr)

read.hpc <- function() {
    hpc <- read.table("./data/household_power_consumption.txt",
        header = TRUE,
        sep = ";",
        stringsAsFactors = FALSE)

    # only keep the data from 2007-02-01 to 2007-02-02.
    hpc <- filter(hpc, Date == "1/2/2007" | Date == "2/2/2007")
    # return the filtered data for plotting
    hpc
}

# read the input file
hpc <- read.hpc()
# open PNG graphic device to store the histogram in 480x480 PNG file
png(filename = "./plot1.png", width = 480, height = 480, units = "px")

# generate the histogram
hist(as.numeric(hpc$Global_active_power),
    col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

# close PNG graphic device. This also flushes the image into the file.
dev.off()
