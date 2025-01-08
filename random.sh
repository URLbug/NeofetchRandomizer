#!/bin/bash

IMAGE_DIR="/home/$(whoami)/randomizer/images"

USED_IMAGES_FILE="/home/$(whoami)/randomizer/used_images.txt"

touch "$USED_IMAGES_FILE"

IMAGES=($(ls "$IMAGE_DIR"))

UNUSED_IMAGES=()
for IMAGE in "${IMAGES[@]}"; do
    if ! grep -q "$IMAGE" "$USED_IMAGES_FILE"; then
        UNUSED_IMAGES+=("$IMAGE")
    fi
done

if [ ${#UNUSED_IMAGES[@]} -gt 0 ]; then
    RANDOM_IMAGE=${UNUSED_IMAGES[RANDOM % ${#UNUSED_IMAGES[@]}]}
    
    neofetch --kitty "$IMAGE_DIR/$RANDOM_IMAGE"
    
    echo "$RANDOM_IMAGE" >> "$USED_IMAGES_FILE"
else
    echo "" > $USED_IMAGES_FILE

    RANDOM_IMAGE=${UNUSED_IMAGES[RANDOM % 1]}
    
    neofetch --kitty "$IMAGE_DIR/$RANDOM_IMAGE"
    
    echo "$RANDOM_IMAGE" >> "$USED_IMAGES_FILE"
fi