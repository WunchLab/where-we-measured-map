#!/bin/bash

# The following script takes the index.html file created by R and
# adds code to it to add features and make it mobile friendly.
#
# Usage:
# $ bash route_record_creator.sh input_file output_file
# NOTE: input_file and output_file must have different names
#
# Example:
# $ bash route_record_creator.sh index1.html index2.html



input_file=$1
output_file=$2
cp $input_file $output_file

# Code blocks to be inserted
code1='<!--**** START OF ADDED CODE 1 ****-->
  <!-- Add title to tab -->
  <title>Measurement Record</title>

  <!-- Disable Browser caching -->
  <meta name="description" content="Gas Concentration Measurement">
  <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
  <meta http-equiv="Pragma" content="no-cache" />
  <meta http-equiv="Expires" content="0" />

  <!-- Improve mobile compatability -->
  <meta name="viewport" content="width=device-width, initial-scale=1" />

  <!-- Import files -->
    <script src="//cdnjs.cloudflare.com/ajax/libs/moment.js/2.7.0/moment.min.js" type="text/javascript"></script>
    <script src="../LiveMaps/script/jquery.min.js"></script>
    <script src="../LiveMaps/bootstrap-3.3.7/js/bootstrap.min.js"></script>
    <link href="../LiveMaps/bootstrap-3.3.7/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/css/datepicker.min.css" />
    <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/css/datepicker3.min.css" />
    <script src="//cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/js/bootstrap-datepicker.min.js"></script>
    <link href="styles/style.css" rel="stylesheet"></style>
<!--**** END OF ADDED CODE 1****-->
'
code2='  <!--**** START OF ADDDED CODE 2 ****-->
  <!--Navigation bar-->
  <div id="nav-placeholder">

  </div>

  <script>
  $(function(){
    $("#nav-placeholder").load("../About/navbar.html");
  });
  </script>
  <!--end of Navigation bar-->
  <!--**** END OF ADDED CODE 2 **** -->
  '
code3='  <!--**** START OF ADDED CODE 3 ****-->
  <!-- Custom legend starts here -->
  <div class="custom_legend">

    <!-- Routes title
    <div class="custom_legend_title">Routes</div>-->

    <!-- Contents of routed taken legend -->
    <div class="custom_legend_contents">
      <div class="custom_legend_line">
        <div class="route_line"></div>Where we measured
      </div>

    <hr> 

    <!-- Facility category title -->
    <div class="custom_legend_title">Facility Category</div>

    <!-- Contents of facility category legend -->
    <div class="custom_legend_contents">
      <div class="custom_legend_line"><img src="markers/green.png" width="15px" height="15px">-  Agriculture</div>
      <div class="custom_legend_line"><img src="markers/purple.png" width="15px" height="15px">-  Industrial Sources</div>
      <div class="custom_legend_line"><img src="markers/yellow.png" width="15px" height="15px">-  Natural Gas Transmission & Distribution</div>
      <div class="custom_legend_line"><img src="markers/orange.png" width="15px" height="15px">-  Power Generation</div>
      <div class="custom_legend_line"><img src="markers/grey.png" width="15px" height="15px">-  Solid Waste</div>
      <div class="custom_legend_line"><img src="markers/brown.png" width="15px" height="15px">-  Wastewater</div>
      <div class="custom_legend_line"><img src="markers/blue.png" width="15px" height="15px">-  Wetlands</div>
    </div>

    <!-- Separator -->
    <hr>
     
    <!-- Enhancement Magnitude Title -->
    <div class="custom_legend_title">Enhancement</div>

    <!-- Contents of enhancement magnitude legend -->
    <div class="custom_legend_line"><span class="dot" style="background-color: red"></span> -  Large </div>
    <div class="custom_legend_line"><span class="dot" style="background-color: orange"></span> -  Medium </div>
    <div class="custom_legend_line"><span class="dot" style="background-color: yellow"></span> -  Small </div>
  </div>
  <!-- Custom legend ends here -->

  <!--**** END OF ADDED CODE 3 ****-->
  '

# Save code to files
echo "$code1" > code1.txt
echo "$code2" > code2.txt
echo "$code3" > code3.txt

# Step 1: Add "code 1" after first marker of input file
marker1="charset"
sed -i "/$marker1/ r code1.txt" $output_file
echo "Inserting meta code."


# Step 2: Add "code 2" after second marker
marker2="<body"
sed -i "/$marker2/ r code2.txt" $output_file
echo "Inserting navbar code."


# Step 3: Add "code 3" after third marker
marker3="application\/htmlwidget-sizing"
sed -i "/$marker3/ r code3.txt" $output_file
echo "Inserting legend code."

# Step 4: Change "height" from 800 to "100%" in 3 places
sed -i 's/"height":800/"height":"100%"/g' $output_file
sed -i 's/"viewer":{"width":"100%","height":"100%"/"viewer":{"position":"absolute", "width":"100%","height":"100%"/g' $output_file
sed -i 's/"browser":{"width":"100%","height":"100%"/"browser":{"position":"absolute", "width":"100%","height":"100%"/g' $output_file
echo "Changing viewport settings."

# Remove fullscreen control
echo "Removing fullscreen control."
sed -i 's/"fullscreenControl":true/"fullscreenControl":false/g' $output_file


# Remove code files
rm code1.txt code2.txt code3.txt


echo "All done!"
