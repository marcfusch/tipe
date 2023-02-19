#! /bin/zsh

# This is where my copy is, YMMV.
slicerpath=/Applications/Original\ Prusa\ Drivers/PrusaSlicer.app/Contents/MacOS/PrusaSlicer

# "top*.stl" have to be rotate 180° on the X (or Y) axis
for file in ./top*.stl; do
    echo $file
    $slicerpath \
        --load ./config.ini \
        --printer-technology FFF \
        --rotate-x 180 \
        --center 125,105 \
        --slice \
        --export-gcode \
        $file
done


# "bottom*.stl" parts can be sliced without transformations
for file in ./bottom*.stl; do
    echo $file
    $slicerpath \
        --load ./config.ini \
        --printer-technology FFF \
        --center 125,105 \
        --slice \
        --export-gcode \
        $file
done