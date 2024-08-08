#!/bin/zsh
#install path
slicerpath=/Applications/Original\ Prusa\ Drivers/PrusaSlicer.app/Contents/MacOS/PrusaSlicer
outdir=output/
declare -a infills=("rectilinear" "alignedrectilinear" "concentric" "grid" "honeycomb" "stars" "gyroid" "triangles")
rm $outdir*.gcode
rm stl/*.gcode
rm 1
echo "filename;time;infill_density;infill_pattern" > output.csv

if [[ $1 == "" ]]; then
    filldensity="20%"
    echo "Filling density will default to 20%"
else
    filldensity="${1}%"
    echo "Filling density is set to:" $filldensity
fi

for stl in stl/*.stl; do
    filename=$(echo $stl | cut -d '.' -f 1 | cut -d '/' -f 2)
    for infill in ${infills[@]}; do
        echo "Slicing" $filename "at" $filldensity "of" $infill
        $slicerpath \
            --load ./config.ini \
            --printer-technology FFF \
            --fill-pattern $infill \
            --fill-density $filldensity \
            --top-fill-pattern monotonic \
            --bottom-fill-pattern monotonic \
            --slice \
            -g \
            $stl \
            >/dev/null 2&>1

        time=$(echo stl/*.gcode | cut -d '_' -f 2)
        mv stl/*.gcode $outdir${filename}_${time}_${filldensity}_${infill}.gcode
        echo "$filename;$time;$filldensity;$infill" >> output.csv
    done
done
