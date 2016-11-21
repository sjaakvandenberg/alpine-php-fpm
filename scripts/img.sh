#!/bin/sh
UPLOADS=$WP_DIR/wp-content/uploads

resize_img() {
  width="${1:-1000}"
  for image in $(find $UPLOADS -regex ".*\.\(png\|jpeg\|jpg\|gif\)"); do
    resize $image $image $width
  done
}

optimize_img() {
  DIR="${1:-$UPLOADS}"
  echo "Before: $(du -sh $DIR)"
  for png in $(find $DIR -regex ".*\.\(png\)"); do
    pngquant --force --quality=75-80 $png -o $png
  done
  for jpg in $(find $DIR -regex ".*\.\(jpeg\|jpg\)"); do
    jpegtran -optimize -copy none -progressive -outfile $jpg $jpg
  done
  echo "After: $(du -sh $DIR)"
}

clean_img() {
  DIR="${1:-$UPLOADS}"
  echo "Before: $(du -sh $DIR)"
  # find $DIR -regex ".*\d\{1,4\}x\d\{1,4\}.\(png\|jpeg\|jpg\|gif\)" -delete
  find $DIR -regex ".*\d\{1,4\}x\d\{1,4\}.\(png\|jpeg\|jpg\|gif\)" | xargs rm
  echo "After: $(du -sh $DIR)"
}

import_img() {
  DIR="${1:-$UPLOADS}"
  find $DIR -regex ".*\.\(png\|jpeg\|jpg\|gif\)" | xargs wp media import
}

if [ -z "$(which pngquant)" ]; then
  apk add --no-cache pngquant --repository "http://dl-4.alpinelinux.org/alpine/edge/testing"
fi

if [ -z "$(which jpegtran)" ]; then
  apk add --no-cache libjpeg-turbo libjpeg-turbo-utils
fi

case "$1" in
  --optimize)
    optimize_img "$2"
    echo "Optimized all images."
    ;;
  --clean)
    clean_img "$2"
    echo "Removed all WordPress generated images."
    ;;
  --resize)
    resize_img "$2"
    echo "Resized all images to a width of $2."
    ;;
  --import)
    import_img "$2"
    echo "Finished importing images to database."
    ;;
  *)
    echo "usage: img ARGS"
    echo "arguments:"
    echo "  --optimize [DIR]  Optimize images in DIR (default uploads)"
    echo "  --clean [DIR]     Remove WP generated images (default uploads)"
    echo "  --import [DIR]    Import images to database (default uploads)"
    echo "  --resize [1000]   Resize all images"
    ;;
esac
