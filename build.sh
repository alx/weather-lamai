#!/bin/bash

convert_latest_radar_image () {

    # rotate image files (from oldest to newest)
    if [ -f "./public/${RADAR_NAME}_4.png" ]; then
        rm ./public/${RADAR_NAME}_4.png
    fi
    mv ./public/${RADAR_NAME}_3.png ./public/${RADAR_NAME}_4.png
    mv ./public/${RADAR_NAME}_2.png ./public/${RADAR_NAME}_3.png
    mv ./public/${RADAR_NAME}_1.png ./public/${RADAR_NAME}_2.png
    mv ./public/${RADAR_NAME}_0.png ./public/${RADAR_NAME}_1.png
    cp ./public/${RADAR_NAME}.png   ./public/${RADAR_NAME}_0.png

    # create animated GIF
    convert -delay 100 -loop 0 ./public/${RADAR_NAME}_*.png ./public/${RADAR_NAME}_animated.gif

    RADAR_NAME=$1
    FILE_EXTENSION=$2

    CROP_DIMENSION=$3
    RESIZE_DIMENSION=$4

    RADAR_URL="https://data.rainviewer.com/images/${RADAR_NAME}/"

    DEST_SOURCE_FILE="./public/${RADAR_NAME}_source.${FILE_EXTENSION}"
    DEST_DONE_FILE="./public/${RADAR_NAME}.png"

    LATEST_SCAN=`curl -0 ${RADAR_URL}0_products.json | jq -r ".products[0].scans | last | .name"`
    IMG_URL_FROM_JSON=${RADAR_URL}${LATEST_SCAN/_2_map.png/_0_source.${FILE_EXTENSION}}

    wget -O ${DEST_SOURCE_FILE} ${IMG_URL_FROM_JSON}

    # Crop and resize radar image on file
    convert ${DEST_SOURCE_FILE}             \
        -crop ${CROP_DIMENSION} +repage     \
        -resize ${RESIZE_DIMENSION} +repage \
        ${DEST_DONE_FILE}

    # Resize images
    # to 450x450
    convert ${DEST_DONE_FILE} \
        -resize 450x450       \
        -background Black     \
        -gravity center       \
        -extent 450x450       \
        ${DEST_DONE_FILE}

    rm ${DEST_SOURCE_FILE}

}

# THTP3 radar
# https://data.rainviewer.com/images/THTP3/
convert_latest_radar_image "THTP3" "gif" "614x614+0+0" "614x614"

# THKT2 radar
# https://data.rainviewer.com/images/THKT2/
convert_latest_radar_image "THKT2" "jpeg" "756x787+43+0" "756x787"

# THMP3 radar
# https://data.rainviewer.com/images/THMP3/
convert_latest_radar_image "THMP3" "gif" "767x786+32+0" "767x786"

# THNN radar
# https://data.rainviewer.com/images/THNN/
convert_latest_radar_image "THNN" "webp" "607x607+0+0" "614x614"

# THTR radar
# https://data.rainviewer.com/images/THTR/
convert_latest_radar_image "THTR" "webp" "799x799+0+0" "799x799"

emacs -Q --script build-site.el
