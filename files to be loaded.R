library(readr)

#directory
setwd("directory")

Sites_in_the_GTA<- read_csv("Sites in the GTA.csv",col_types = cols(`#times observed/ #times visited` = col_double()))

Peak_locations_new <- read_csv("/home/sebastien/Documents/Students_Reports/JP/Peak_locations.csv", col_types = cols(Date = col_date(), Time = col_time(), Enhancement_ppm = col_double(), Latitude = col_double(), Longitude = col_double(), Level_of_Enhancement = col_integer()))

# All campaign routes data
Apr_25_2019 <- read_csv("Raw Data/sync_data_2019-04-25.csv", col_types = cols(gps_time = col_datetime()))
May_21_2019 <- read_csv("Raw Data/sync_data_2019-05-21.csv", col_types = cols(gps_time = col_datetime()))


# kml files
pipelines_url <- "http://www.atmosp.physics.utoronto.ca/GTA-Emissions/kml_files/kml files/DMTI_2016_CMCS_PipelinesLine.kml"
wetlands_url <- "http://www.atmosp.physics.utoronto.ca/GTA-Emissions/kml_files/kml files/wetlands_gta.kml"
valve_points_url <- "http://www.atmosp.physics.utoronto.ca/GTA-Emissions/kml_files/kml files/valve_points.kml"
#####agriculture_url <- "http://www.atmosp.physics.utoronto.ca/GTA-Emissions/kml_files/kml files/.kml"


