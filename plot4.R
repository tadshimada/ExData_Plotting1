#######################################################################################
## filename: plot4.R
## - This R script generates 4 different line plot. Then, it saves the image output
## into a PNG file (plot4.R) in the same directory where the script is executed.
#######################################################################################

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

# create datetime from "Date" and "Time" columns
datetime <- strptime(paste(hpc$Date, hpc$Time), "%d/%m/%Y %H:%M:%S")

# open the PNG graphic device to save the image into a file.
png(filename = "./plot4.png", width = 480, height = 480, units = "px")

# remember the original mfcol setting so that we can set it back.
default_mfcol <- par("mfcol")

# set up 2x2 plotting region. With mfcol, first plot shows up in the top left,
# followed by bottom left, then, top right, then bottom right.
par(mfcol = c(2, 2))

#------------------------------------
# draw the first plot (top left)
#------------------------------------
plot(timestamps, hpc$Global_active_power,
    type = "l",  ## for lines
    lty = "solid",
    xlab = "", ## no label for x-axis
    ylab = "Global Active Power"
)

#--------------------------------------
# draw the second plot (bottom left)
#--------------------------------------
# draw the multi-line plot. first set up the plotting region by specifying type = "n"
plot(datetime, hpc$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
lines(datetime, hpc$Sub_metering_1, type = "l", lty = "solid", col = "black")
lines(datetime, hpc$Sub_metering_2, type = "l", lty = "solid", col = "red")
lines(datetime, hpc$Sub_metering_3, type = "l", lty = "solid", col = "blue")

# create legend text
colnames <- names(hpc)
legendlabs <- colnames[grepl("Sub_metering", colnames)]
# add the legend with no box around it. Also adjust the text size slightly.
legend("topright", legend = legendlabs, lty = "solid", col = c("black", "red", "blue"), bty = "n")

#------------------------------------
# draw the third plot (top right)
#------------------------------------
with(hpc, plot(datetime, Voltage, type = "l", lty = "solid"))

#--------------------------------------------------
# draw the fourth and last plot (bottom right)
#--------------------------------------------------
with(hpc, plot(datetime, Global_reactive_power, type = "l", lty = "solid"))

# turn off the PNG graphic device to flush the data into the file.
dev.off()

# reset the mfcol to the original value
par(mfcol = default_mfcol)

