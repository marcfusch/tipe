#!/bin/zsh

#install path
slicerpath=/Applications/Original\ Prusa\ Drivers/PrusaSlicer.app/Contents/MacOS/PrusaSlicer
stl=./cube.stl
declare -a infills=("line" "cubic" "adaptivecubic" "rectilinear" "alignedrectilinear" "concentric" "grid" "hilbertcurve" "honeycomb" "3dhoneycomb" "archimedeanchords" "lightning" "octagramspiral" "stars" "gyroid" "triangles")


for infill in ${infills[@]}; do
    echo "Slicing with infill pattern:" $infill

    $slicerpath \
        --load ./config.ini \
        --printer-technology FFF \
        --fill-pattern $infill \
        --top-fill-pattern monotonic \
        --bottom-fill-pattern monotonic \
        --slice \
        -g \
        $stl \
        #>/dev/null 2&>1

    
    mv *.gcode output/${infill}.gcode
    sleep 2
done
