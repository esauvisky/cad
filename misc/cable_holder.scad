include <math.scad>

length = 150;   // length of the holder
height = 80;    // height of the holder
header = 30;    // height of the top part
steepeness = 7; // radius of the parabola used to create the curve
depth = 50;     // distance from the wall
wall_width = 10; // width of the walls
$fn = 100;

// temp variables
circle_height = height - header;
radius = length + circle_height;

module spool() {
    difference() {
        rotate_extrude() {
            translate([radius - wall_width, 0, 0]) parabola(depth, steepeness);
        }
        rotate_extrude() {
            translate([radius, 0, 0]) parabola(depth, steepeness);
        }
    }
    // cube(size=[radius + 50 * PI * 2, radius + 50 * PI * 2, depth], center=true);
}

difference() {
    cylinder(r = radius + depth, h = depth * sqrt(2), center = true);
    rotate_extrude() {
        translate([radius, 0, 0]) parabola(depth, steepeness);
    }
    translate([0,0,depth*sqrt(2)/2]) cube(size = [1000, 1000, depth * sqrt(2)], center = true);
    cylinder(r=radius - wall_width, h=depth*sqrt(2), center=true);
}
spool();
