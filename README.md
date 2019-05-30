# README

These scripts were developped by J.L. Phillips (jlee.phillips@mail.utoronto.ca).

# What is this repository for?
This repository contains the scripts needed to create the Where We Measured Map. It processes the data outputs collected during each day of measurements to create a web map with the roads where we did measurements represented by blue lines and the location of the observed enhancements of methane concentrations represented by coloured dots: yellow for small enhancements (between 0.04 ppm and 0.4 ppm), orange for medium enhancements (between 0.4 ppm and 1 ppm) and red for large enhancements (above 1 ppm). 

# How do I get set up?  
To set it up, clone the entire repository to your local machine. All the scripts were written using R and requires the following packages: readr and googleway. 

# ‘files to be loaded.R’
Copy all the sync_data files into the ‘Raw Data’ directory. Complete the ‘files to be loaded.R’ script with the proper directory and all the days of campaign by adding them on the ‘All bike & truck campaign routes data’ part as follows:

May_21_2019 <- read_csv("Directory/Raw Data/sync_data_2019-05-21.csv", col_types = cols(gps_time = col_datetime()))

Run the script to load all the data into your global environment. 

# ‘Peak_locations.csv’
This file indicates the location, the amplitude and the classification of enhancements observed during each campaign. Complete it with the data obtained with the ‘SURF_peakfinder_program.py’. 

# ‘Route_Facility_Enhancement_map.R’
Adjust the directory and complete the ‘Route_Facility_Enhancement_Map.R’ script by adding on the ‘All campaign routes’ parts for each day of measurements:

add_polylines(data = May_21_2019, lat = "lat",lon = "lon", stroke_weight = 4) %>%

In case of missing data in the dataset, plot separately the different part of the time series using the index. In the following example, data are missing between the indexes 283 and 284:

add_polylines(data = May_21_2019[1:283,1:26], lat = "lat",lon = "lon", stroke_weight = 4) %>%

add_polylines(data = May_21_2019[284:865,1:26], lat = "lat",lon = "lon", stroke_weight = 4) %>%

Make sure that the last line add_polylines line does not end with %>%. 
Run the script to create the map gathering the location of the main sources of methane, your routes represented as blue lines and the location of methane enhancements represented as coloured dots: yellow for small enhancements (between 0.04 ppm and 0.4 ppm), orange for medium enhancements (between 0.4 ppm and 1 ppm) and red for large enhancements (above 1 ppm).
Save the map as a web page by clicking on export in the viewer window of RStudio. 

# Display the map on the website
Transfer your new map from your local system to the remote server in the appropriate directory and run the ‘route_record_creator.sh’ script to add legends to the map:

bash route_record_creator.sh new_map index.html
