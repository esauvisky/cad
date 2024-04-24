include <threads.scad>;
include <hinge.scad>;
include <bosl/shapes.scad>;

texture_depth = 1; // depth of the texture cutout
texture_width = 2.5; // width of each textured segment

main_diameter = 25; // diameter of the peg
main_length = 80; // length of the peg
clearance_diameter = 20; // diameter of the peg clearance_diameter
clearance_height = 10;

clearance_cone_height = 10;

$fn = 50;

// Function to create a knurled texture
module knurling() {
    for (angle = [0:360/15:360]) { // create 20 textured segments around the cylinder
        rotate([0, 0, angle])
        translate([main_diameter/2 - texture_depth, -texture_width/2, 0])
        cube([texture_depth, texture_width, main_length]);
    }
}

module coisinha() {
    // Horizontal knurling
    for (position = [5:texture_width*2:main_length-5]) { // create horizontal bands along the length of the cylinder
        translate([0, 0, position])
        tube(od=main_diameter+texture_depth, id=main_diameter-texture_depth*2, h=texture_width);
    }
}

// Create the peg cylinder with texture
difference() {
    union() {
        cyl(h = clearance_height, d = clearance_diameter, center=false);

        translate([0,0,clearance_height])
            cyl(h = clearance_cone_height, d1 = clearance_diameter, d2 = main_diameter, center=false);

        translate([0,0,clearance_height + clearance_cone_height])
            cyl(h = main_length, d = main_diameter, chamfer2=3, center=false);
    }
    // Thread hole - assuming metric_thread() cuts the thread into the cylinder
    metric_thread(diameter=5.5, length=25, test=true);

    // Apply the texture
    // coisinha();
    translate([0,0,clearance_height + clearance_cone_height]) knurling();
}

// Note: The metric_thread() function is commented out because it's from an external library not present in this environment.
// You will need to uncomment and ensure it's correctly applied in your local environment where the `threads.scad` library is included.
