include <math.scad>

length = 170;   // length of the holder
height = 100;   // height of the holder
header = 30;    // height of the top part
steepeness = 8; // radius of the parabola used to create the curve
depth = 40;     // distance from the wall
wall_width = 3;
// width of the walls
$fn = 100;

// temp variables
circle_height = height - header;
spool_wall_width = 4 * wall_width;
radius = length / 2 - spool_wall_width - wall_width;
total_diameter = radius * 2 + depth + spool_wall_width;

module spool() {
    difference() {
        union() {
            difference() {
                rotate_extrude() {
                    translate([radius - spool_wall_width, 0, 0]) parabola(depth, steepeness);
                }
                rotate_extrude() {
                    translate([radius, 0, 0]) parabola(depth, steepeness);
                }
            }
            // makes a solid body against the wall
            difference() {
                cylinder(r = radius + depth, h = depth * sqrt(2), center = true);
                rotate_extrude() {
                    translate([radius, 0, 0]) parabola(depth, steepeness);
                }
                translate([0, 0, depth * sqrt(2) / 2]) cube(size = [1000, 1000, depth * sqrt(2)], center = true);
            }
        }
    translate([0, 0, -depth / 2 - wall_width * 4 - 100]) cube(size = [height * 5, length * 5, wall_width + 200], center = true);
    }
}

difference() {
    union() {
        translate([total_diameter / 2 - header, 0, depth / 2 + wall_width * 2]) difference() {
            spool();
            // translate([0,height/2,0]) rotate([0,0,45]) cube(size=[1500, height, height], center=true);
        }
        minkowski() {
            cube(size = [height - 20 - wall_width, length - 20, wall_width * 2], center = true);
            cylinder(r = 20, h = wall_width, center = true);
        }
    }
    translate([total_diameter / 2 - header, 0, depth / 2 + wall_width]) {
        cylinder(r = length / 2 - spool_wall_width * 2 - wall_width, h = depth + spool_wall_width * 2, center = true);
        translate([total_diameter / 3, -depth + total_diameter, 0]) rotate([0, 0, -60])
            cube(size = [total_diameter + depth * 4, total_diameter + depth, height], center = true);
        translate([total_diameter / 3, depth - total_diameter, 0]) rotate([0, 0, 60])
            cube(size = [total_diameter + depth * 4, total_diameter + depth, height], center = true);
    }
    translate([-height / 2 + 10, -length / 2 + 10, 0]) cylinder(r = 3, h = 10, center = true);
    translate([-height / 2 + 10, +length / 2 - 10, 0]) cylinder(r = 3, h = 10, center = true);}
