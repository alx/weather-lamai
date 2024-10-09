#!/usr/bin/env bash

convert_latest_radar_image () {

    RADAR_NAME=$1
    FILE_EXTENSION=$2
    CROP_DIMENSION=$3
    RESIZE_DIMENSION=$4
    FINAL_CROP=$5

    RADAR_URL="https://data.rainviewer.com/images/${RADAR_NAME}/"

    DEST_DIR="./public/${RADAR_NAME}_frames/"
    DEST_DONE_FILE="./public/${RADAR_NAME}.webm"

    # Create the destination directory for frames if it doesn't exist
    mkdir -p ${DEST_DIR}

    # Get the latest 10 scans
    LATEST_SCANS=$(curl -s ${RADAR_URL}0_products.json | jq -r ".products[0].scans[-10:] | .[].name")

    COUNTER=0
    for SCAN in ${LATEST_SCANS}; do
        # Generate image URLs
        IMG_URL_FROM_JSON=${RADAR_URL}${SCAN/_2_map.png/_0_source.${FILE_EXTENSION}}
        echo $IMG_URL_FROM_JSON

        # Set destination file for each frame
        DEST_SOURCE_FILE="${DEST_DIR}${RADAR_NAME}_source_${COUNTER}.${FILE_EXTENSION}"
        DEST_DONE_FRAME="${DEST_DIR}${RADAR_NAME}_frame_${COUNTER}.png"

        # Download the image
        # wget -O ${DEST_SOURCE_FILE} ${IMG_URL_FROM_JSON}

        # Crop and resize each radar image
        magick ${DEST_SOURCE_FILE}      \
            -crop ${CROP_DIMENSION} +repage     \
            -resize ${RESIZE_DIMENSION} +repage \
            ${DEST_DONE_FRAME}

        echo "magick ${DEST_SOURCE_FILE}      \
            -crop ${CROP_DIMENSION} +repage     \
            -resize ${RESIZE_DIMENSION} +repage \
            ${DEST_DONE_FRAME}"

        # Resize to 450x450 and center
        magick ${DEST_DONE_FRAME} \
            -resize 450x450       \
            -background Black     \
            -gravity center       \
            -extent 450x450       \
            ${DEST_DONE_FRAME}

        # Final crop
        magick ${DEST_DONE_FRAME} \
            -crop ${FINAL_CROP} \
            +repage             \
            -resize 450x450       \
            ${DEST_DONE_FRAME}

        # Remove the source file to clean up
        # rm ${DEST_SOURCE_FILE}

        COUNTER=$((COUNTER+1))
    done
    # Create an animated GIF from the frames
    ffmpeg -y -framerate 1 -i ${DEST_DIR}${RADAR_NAME}_frame_%d.png -c:v libvpx-vp9 -b:v 1M -auto-alt-ref 0 ${DEST_DONE_FILE}

    # Clean up the frames directory
    # rm -rf ${DEST_DIR}

}

# THMP3 radar
# https://data.rainviewer.com/images/THMP3/
convert_latest_radar_image \
    "THMP3"                \
    "gif"                  \
    "767x786+32+0"         \
    "767x786"              \
    "130x130+243+263"

# org content into website
emacs -Q --script build-site.el

# THNN radar
# https://data.rainviewer.com/images/THNN/
# convert_latest_radar_image "THNN" "webp" "607x607+0+0" "614x614" 100

# THTR radar
# https://data.rainviewer.com/images/THTR/
# convert_latest_radar_image "THTR" "webp" "799x799+0+0" "799x799" 100

# THTP3 radar
# https://data.rainviewer.com/images/THTP3/
# convert_latest_radar_image "THTP3" "gif" "614x614+0+0" "614x614" 100

# THKT2 radar
# https://data.rainviewer.com/images/THKT2/
# convert_latest_radar_image "THKT1" "jpeg" "756x787+43+0" "756x787" 100
