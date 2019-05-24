library(googleway)
library(readr)

#directory
setwd("directory")

#LOAD csv. files:
Sites_in_the_GTA<- read_csv("Sites in the GTA.csv",col_types = cols(`#times observed/ #times visited` = col_double()))
Peak_locations_new <- read_csv("Peak_locations.csv", col_types = cols(Date = col_date(), Time = col_time(), Enhancement_ppm = col_double(), Latitude = col_double(), Longitude = col_double(), Level_of_Enhancement = col_integer()))

# defines contents of info_window to be displayed upon clicking on Facility marker:
Sites_in_the_GTA$info <- paste0('<B>', Sites_in_the_GTA$'Name of site', '</B><br />', 'Facility type : ', Sites_in_the_GTA$'Facility Category', '<br />', 'Reported emission rate : ', Sites_in_the_GTA$'Emission Magnitude', ' Mg/year CH', '<sub>', '4', '</sub>')
Sites_in_the_GTA$info[c(2,16,37,75)]  <- paste0('<B>', Sites_in_the_GTA$'Name of site'[c(2,16,37,75)], '</B><br />', 'Facility type : ', Sites_in_the_GTA$'Facility Category'[c(2,16,37,75)], '<br />', 'Reported emission rate : ', ' * Emissions not reported')

# defines contents of info_window to be displayed upon clicking on circle/enhancement marker:
Peak_locations_new$info <- paste0('<B>', 'CH', '<sub>', '4', '</sub>', ' enhancement : ', '</B>', Peak_locations_new$'Enhancement_ppm', ' ppm', '<br />', 'Date Observed : ', Peak_locations_new$'Date')

################
# assigns a seperate color to each facility catagory, then a URL to each respective colored marker:
Sites_in_the_GTA$colour <- NA
Sites_in_the_GTA$iconURL <- NA
Sites_in_the_GTA$colour[Sites_in_the_GTA$`Facility Category`=="Solid waste"] <- "grey"
Sites_in_the_GTA$colour[Sites_in_the_GTA$`Facility Category`=="Wetland"] <- "blue"
Sites_in_the_GTA$colour[Sites_in_the_GTA$`Facility Category`=="Agriculture"] <- "green"
Sites_in_the_GTA$colour[Sites_in_the_GTA$`Facility Category`=="Power plant"] <- "orange"
Sites_in_the_GTA$colour[Sites_in_the_GTA$`Facility Category`=="Manufacturing"] <- "purple"
Sites_in_the_GTA$colour[Sites_in_the_GTA$`Facility Category`=="Wastewater"] <- "brown"
Sites_in_the_GTA$colour[Sites_in_the_GTA$`Facility Category`=="Natural gas"] <- "yellow"
#Sites_in_the_GTA$colour[Sites_in_the_GTA$`Facility Category`=="Transportation"] <- "red"

Sites_in_the_GTA$iconURL[Sites_in_the_GTA$`Facility Category`== "Solid waste"] <- "http://www.atmosp.physics.utoronto.ca/GTA-Emissions/Routes/markers/grey.png"
Sites_in_the_GTA$iconURL[Sites_in_the_GTA$`Facility Category`== "Wetland"] <- "http://www.atmosp.physics.utoronto.ca/GTA-Emissions/Routes/markers/blue.png"
Sites_in_the_GTA$iconURL[Sites_in_the_GTA$`Facility Category`== "Agriculture"] <- "http://www.atmosp.physics.utoronto.ca/GTA-Emissions/Routes/markers/green.png"
Sites_in_the_GTA$iconURL[Sites_in_the_GTA$`Facility Category`== "Power plant"] <- "http://www.atmosp.physics.utoronto.ca/GTA-Emissions/Routes/markers/orange.png"
Sites_in_the_GTA$iconURL[Sites_in_the_GTA$`Facility Category`== "Manufacturing"] <- "http://www.atmosp.physics.utoronto.ca/GTA-Emissions/Routes/markers/purple.png"
Sites_in_the_GTA$iconURL[Sites_in_the_GTA$`Facility Category`== "Wastewater"] <- "http://www.atmosp.physics.utoronto.ca/GTA-Emissions/Routes/markers/brown.png"
Sites_in_the_GTA$iconURL[Sites_in_the_GTA$`Facility Category`== "Natural gas"] <- "http://www.atmosp.physics.utoronto.ca/GTA-Emissions/Routes/markers/yellow.png"
#Sites_in_the_GTA$iconURL[Sites_in_the_GTA$`Facility Category`== "Transportation"] <- "http://www.atmosp.physics.utoronto.ca/GTA-Emissions/Routes/markers/red.png"


#creating colour palette for the 'add_circles' function: yellow, orange, red
myPalette <- list(fill_colour = colorRampPalette(c("#fce302", "#fca402", "#ed2f1a")), stroke_colour = colorRampPalette(c("#fce302", "#fca402", "#ed2f1a")))


my_api_key <- "AIzaSyDDN2l8jaTP9h4bZGH9hQi4x9pJpHgkycw"

google_map(location =  c(43.71, -79.35), zoom = 11, key= my_api_key, search_box = TRUE) %>% 
  # identified Facilities
  googleway::add_markers(data = Sites_in_the_GTA, lon='Longitude', lat = 'Latitude', info_window = 'info', marker_icon = 'iconURL') %>% 

  # observed enhancements/peaks
  add_circles(data = Peak_locations_new, lat="Latitude", lon="Longitude", fill_colour = "Level_of_Enhancement", fill_opacity = 0.5, stroke_weight = 8, stroke_colour = "Level_of_Enhancement", stroke_opacity = 0.7, palette = myPalette, radius = 8, legend = F, info_window = 'info') %>%
  
  # All campaign routes 
  add_polylines(data = May_21_2019, lat = "lat",lon = "lon", stroke_weight = 4) %>%
  add_polylines(data = Apr_25_2019[1:332,1:26], lat = "lat",lon = "lon", stroke_weight = 4) %>%
    add_polylines(data = Apr_25_2019[333:15020,1:26], lat = "lat",lon = "lon", stroke_weight = 4) #%>%

