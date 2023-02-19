#!/bin/zsh

#install path
slicerpath=/Applications/Original\ Prusa\ Drivers/PrusaSlicer.app/Contents/MacOS/PrusaSlicer
stl=./file.stl
declare -a infills=("monotonic" "grid" "hiulbertcurve" "honeycomb" "octagramspiral" "stars" "triangle" "gyroid")

for infill in ${infills[@]}; do
    echo "Printing with infill pattern:" $infill

    $slicerpath \
        --load ./config.ini \
        --printer-technology FFF \
        --fill_pattern $infill \
        --top_fill_pattern monotonic \
        --bottom_fill_pattern monotonic \
        --slice \
        --export-gcode \
        $stl
    sleep 5
done
