#######################################################################
## Filename: plot3.R
## Author: Tad Shimada
## Description:
## - This R script generates multi-line plots with legend and saves
## the image into PNG file (plot3.R).
#######################################################################

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

# just to make sure that we set "mfcol" to the default setting
par("mfcol" = c(1,1))

# create datetime from "Date" and "Time" columns
datetime <- strptime(paste(hpc$Date, hpc$Time), "%d/%m/%Y %H:%M:%S")

# open the PNG graphic device to save the image into a file.
png(filename = "./plot3.png", width = 480, height = 480, units = "px")

# draw the multi-line plot. first set up the plotting region by specifying type = "n"
plot(datetime, hpc$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
lines(datetime, hpc$Sub_metering_1, type = "l", lty = "solid", col = "black")
lines(datetime, hpc$Sub_metering_2, type = "l", lty = "solid", col = "red")
lines(datetime, hpc$Sub_metering_3, type = "l", lty = "solid", col = "blue")

# create legend text
colnames <- names(hpc)
legendlabs <- colnames[grepl("Sub_metering", colnames)]
legend("topright", legend = legendlabs, lty = "solid", col = c("black", "red", "blue"))

# close the PNG graphic device. This also flushes the data into the file.
dev.off()
