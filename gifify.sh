#EXAMPLE: ./gifify.sh $HOME/DockerVolume/seg4art/data/scenes/green_woman1

INPUT_DIR=$1

ffmpeg -i $INPUT_DIR/out_opencv/%03d.png -vf palettegen=reserve_transparent=1 $INPUT_DIR/palette.png
ffmpeg -framerate 30 -i $INPUT_DIR/out_opencv/%03d.png -i $INPUT_DIR/palette.png -lavfi paletteuse=alpha_threshold=128 -gifflags -offsetting $INPUT_DIR/out.gif