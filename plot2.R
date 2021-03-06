######################################################################################
## Filename: plot2.R
## Author: Tad Shimada
## Description:
## - This R script generates the line plot and saves it into PNG file, 'plot2.png',
## in the same directory where the script is run.
######################################################################################

#----------------------------------------
# function to load the input data file
#----------------------------------------
read.hpc <- function() {
    hpc <- read.table("./data/household_power_consumption.txt",
        header = TRUE,
        sep = ";",
        stringsAsFactors = FALSE)

    # only keep the data from 2007-02-01 to 2007-02-02.
    hpc <- subset(hpc, Date == "1/2/2007" | Date == "2/2/2007")
    # return the filtered data for plotting
    hpc
}

# read the input file
hpc <- read.hpc()

# open PNG graphic device to store the line plot in 480x480 PNG file
png(filename = "./plot2.png", width = 480, height = 480, units = "px")

# concatenate 'Date' and 'Time' field to create the complete timestamp.
timestamps <- strptime(paste(hpc$Date, hpc$Time), "%d/%m/%Y %H:%M:%S")

plot(timestamps, hpc$Global_active_power,
    type = "l",  ## for lines
    lty = "solid",
    xlab = "", ## no label for x-axis
    ylab = "Global Active Power (kilowatts)"
    )

dev.off()

