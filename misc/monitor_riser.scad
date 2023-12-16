
use <BOSL/transforms.scad>;
use <BOSL/shapes.scad>;size = 80; // size of the stand
thickness = 3; // thickness of the stand
height = 30; // height of the stand

// function to draw one stand
module stand() {
    // base
    cube([size, thickness, height]);
    // side
    translate([0, size-thickness, 0]) cube([size, thickness, height]);
}

// Draw two identical stands
translate([0, 0, 0]) stand();
translate([0, size*1.5, 0]) stand();
