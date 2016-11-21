#!/usr/bin/php
<?php
if ($argc < 3) {
  echo "Usage: resize <src.jpg> <dst.jpg> [width=1000] [quality=80]\n";
  exit;
}

$src = $argv[1];
$dst = $argv[2];
$w = $argv[3];
if (!isset($w)) $w = 1000;

function image_resize($src, $dst, $w) {

  list($width, $height, $type) = getimagesize($src);

  $new = imagecreatetruecolor($width, $height);
  $scale = $w / $width;
  $h = round($height * $scale, 0);

  switch($type) {
    case IMAGETYPE_PNG:  $img = imagecreatefrompng($src); break;
    case IMAGETYPE_GIF:  $img = imagecreatefromgif($src); break;
    case IMAGETYPE_JPEG: $img = imagecreatefromjpeg($src); break;
    default: return "Unsupported image format!";
  }

  if ($type == IMAGETYPE_PNG or $type == IMAGETYPE_PNG) {
    imagecolortransparent($new, imagecolorallocatealpha($new, 0, 0, 0, 127));
    imagealphablending($new, false);
    imagesavealpha($new, true);
  }

  imagecopyresampled($new, $img, 0, 0, 0, 0, $w, $h, $width, $height);

  switch($type) {
    case IMAGETYPE_PNG:  imagepng($new, $dst, 2); break;
    case IMAGETYPE_GIF:  imagegif($new, $dst); break;
    case IMAGETYPE_JPEG: imagejpeg($new, $dst, 80); break;
    default: return "Unsupported image format!";
  }

  // echo "src    : $src\n";
  // echo "dst    : $dst\n";
  // echo "width  : $width\n";
  // echo "height : $height\n";
  // echo "type   : $type\n\n";
  // echo "scale  : $scale\n";
  // echo "w      : $w\n";
  // echo "h      : $h\n";
  // echo "img    : $img\n";
  // echo "new    : $new\n";

  return true;
}

image_resize($src, $dst, $w);

?>
