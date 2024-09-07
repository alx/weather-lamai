#!/bin/bash

# THTP3 radar
# https://data.rainviewer.com/images/THTP3/
RADAR_URL="https://data.rainviewer.com/images/THTP3/"
LATEST_SCAN=`curl -0 ${RADAR_URL}0_products.json | jq -r ".products[0].scans | last | .name"`
wget -O ./content/THTP3_source.gif ${RADAR_URL}${LATEST_SCAN/_2_map.png/_0_source.gif}
magick ./content/THTP3_source.gif -crop 614x614+0+0 +repage -resize x614 +repage ./content/THTP3.webp
magick ./content/THTP3.webp -resize 450x450 -background Black -gravity center -extent 450x450 ./content/THTP3.webp
rm ./content/THTP3_source.gif

# THKT2 radar
# https://data.rainviewer.com/images/THKT2/
RADAR_URL="https://data.rainviewer.com/images/THKT2/"
LATEST_SCAN=`curl -0 ${RADAR_URL}0_products.json | jq -r ".products[0].scans | last | .name"`
wget -O ./content/THKT2_source.jpeg ${RADAR_URL}${LATEST_SCAN/_2_map.png/_0_source.jpeg}
magick source.jpeg -crop 756x787+43+0 +repage -resize 756x787 +repage ./content/THKT2.webp
magick ./content/THKT2.webp -resize 450x450 -background Black -gravity center -extent 450x450 ./content/THKT2.webp
rm ./content/THKT2_source.jpeg

# THMP3 radar
# https://data.rainviewer.com/images/THMP3/
RADAR_URL="https://data.rainviewer.com/images/THMP3/"
LATEST_SCAN=`curl -0 ${RADAR_URL}0_products.json | jq -r ".products[0].scans | last | .name"`
wget -O ./content/THMP3_source.gif ${RADAR_URL}${LATEST_SCAN/_2_map.png/_0_source.gif}
magick ./content/THMP3_source.gif -crop 767x786+32+0 +repage -resize 767x786 +repage ./content/THMP3.webp
magick ./content/THMP3.webp -resize 450x450 -background Black -gravity center -extent 450x450 ./content/THMP3.webp
rm ./content/THMP3_source.gif

# THNN radar
# https://data.rainviewer.com/images/THNN/
RADAR_URL="https://data.rainviewer.com/images/THNN/"
LATEST_SCAN=`curl -0 ${RADAR_URL}0_products.json | jq -r ".products[0].scans | last | .name"`
wget -O ./content/THNN_source.webp ${RADAR_URL}${LATEST_SCAN/_2_map.png/_0_source.webp}
magick ./content/THNN_source.webp -crop 607x607+0+0 +repage -resize x614 +repage ./content/THNN.webp
magick ./content/THNN.webp -resize 450x450 -background Black -gravity center -extent 450x450 ./content/THNN.webp
rm ./content/THNN_source.webp

# THTR radar
# https://data.rainviewer.com/images/THTR/
RADAR_URL="https://data.rainviewer.com/images/THTR/"
LATEST_SCAN=`curl -0 ${RADAR_URL}0_products.json | jq -r ".products[0].scans | last | .name"`
wget -O ./content/THTR_source.webp ${RADAR_URL}${LATEST_SCAN/_2_map.png/_0_source.webp}
magick ./content/THTR_source.webp -crop 799x799+0+0 +repage -resize x799 +repage ./content/THTR.webp
magick ./content/THTR.webp -resize 450x450 -background Black -gravity center -extent 450x450 ./content/THTR.webp
rm ./content/THTR_source.webp $

emacs -Q --script build-site.el
