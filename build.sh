#!/bin/bash

# THTP3 radar
# https://data.rainviewer.com/images/THTP3/
RADAR_URL="https://data.rainviewer.com/images/THTP3/"
LATEST_SCAN=`curl -0 ${RADAR_URL}0_products.json | jq -r ".products[0].scans | last | .name"`
wget -O ./public/THTP3_source.gif ${RADAR_URL}${LATEST_SCAN/_2_map.png/_0_source.gif}
magick ./public/THTP3_source.gif -crop 614x614+0+0 +repage -resize x614 +repage ./public/THTP3.webp
magick ./public/THTP3.webp -resize 450x450 -background Black -gravity center -extent 450x450 ./public/THTP3.png
rm ./public/THTP3_source.gif

# THKT2 radar
# https://data.rainviewer.com/images/THKT2/
RADAR_URL="https://data.rainviewer.com/images/THKT2/"
LATEST_SCAN=`curl -0 ${RADAR_URL}0_products.json | jq -r ".products[0].scans | last | .name"`
wget -O ./public/THKT2_source.jpeg ${RADAR_URL}${LATEST_SCAN/_2_map.png/_0_source.jpeg}
magick source.jpeg -crop 756x787+43+0 +repage -resize 756x787 +repage ./public/THKT2.webp
magick ./public/THKT2.webp -resize 450x450 -background Black -gravity center -extent 450x450 ./public/THKT2.png
rm ./public/THKT2_source.jpeg

# THMP3 radar
# https://data.rainviewer.com/images/THMP3/
RADAR_URL="https://data.rainviewer.com/images/THMP3/"
LATEST_SCAN=`curl -0 ${RADAR_URL}0_products.json | jq -r ".products[0].scans | last | .name"`
wget -O ./public/THMP3_source.gif ${RADAR_URL}${LATEST_SCAN/_2_map.png/_0_source.gif}
magick ./public/THMP3_source.gif -crop 767x786+32+0 +repage -resize 767x786 +repage ./public/THMP3.webp
magick ./public/THMP3.webp -resize 450x450 -background Black -gravity center -extent 450x450 ./public/THMP3.png
rm ./public/THMP3_source.gif

# THNN radar
# https://data.rainviewer.com/images/THNN/
RADAR_URL="https://data.rainviewer.com/images/THNN/"
LATEST_SCAN=`curl -0 ${RADAR_URL}0_products.json | jq -r ".products[0].scans | last | .name"`
wget -O ./public/THNN_source.webp ${RADAR_URL}${LATEST_SCAN/_2_map.png/_0_source.webp}
magick ./public/THNN_source.webp -crop 607x607+0+0 +repage -resize x614 +repage ./public/THNN.webp
magick ./public/THNN.webp -resize 450x450 -background Black -gravity center -extent 450x450 ./public/THNN.png
rm ./public/THNN_source.webp

# THTR radar
# https://data.rainviewer.com/images/THTR/
RADAR_URL="https://data.rainviewer.com/images/THTR/"
LATEST_SCAN=`curl -0 ${RADAR_URL}0_products.json | jq -r ".products[0].scans | last | .name"`
wget -O ./public/THTR_source.webp ${RADAR_URL}${LATEST_SCAN/_2_map.png/_0_source.webp}
magick ./public/THTR_source.webp -crop 799x799+0+0 +repage -resize x799 +repage ./public/THTR.webp
magick ./public/THTR.webp -resize 450x450 -background Black -gravity center -extent 450x450 ./public/THTR.png
rm ./public/THTR_source.webp $

emacs -Q --script build-site.el
