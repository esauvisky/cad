// Global Parameters
$fn = 50;

// Parameters
shaft_diameter = 5;     // Diameter of the main cylinder
shaft_length = 15;      // Total length of the cylinder
split_depth = 10;       // Depth of the split
split_width = 1.5;        // Width of the split
bottom_diameter = 6;    // Diameter of the widened top part
bottom_height = 2;      // Height of the widened top part

thread_diameter = 7.0;  // Diameter of the threaded rod
thread_pitch = 1.25;       // Pitch of the threaded rod

base_length = 15;      // Length of the base cylinder
base_diameter = 12;    // Diamter of the base cylinder

// Model
module split_cylinder() {
    difference() {
        union() {
            // Main cylinder
            cylinder(r=shaft_diameter/2, h=shaft_length-bottom_height);

            // Widened bottom part
            translate([0, 0, shaft_length - bottom_height * 2])
                cylinder(d1=shaft_diameter, d2=bottom_diameter, h=bottom_height);
        }

        cylinder(r=split_width/2 * 1.5, h=shaft_length);

        // Split 1 (120 degrees)
        for(i = [0, 120, 240]) {
            rotate([0, 0, i])
            translate([0, -split_width/2, shaft_length - split_depth - bottom_height])
                cube([bottom_diameter, split_width, split_depth]);
        }
    }
}

module shaft() {
    translate([0, 0, base_length]) {
        union() {
            cylinder(d1=thread_diameter*0.8, d2=split_width/2 * 1.4, h=2);
            cylinder(r=split_width/2 * 1.4, h=shaft_length);
            translate([0, 0, shaft_length]) cylinder(d1=split_width * 1.4, d2=0, h=1);
        }
    }
    threaded_rod(d=thread_diameter, height=base_length, pitch=thread_pitch, anchor=BOTTOM);
    translate([0,0,-base_length]) {
        difference() {
            cylinder(r=thread_diameter/2, h=base_length);
            translate([0,thread_diameter/2,thread_diameter/2]) rotate([90,0,0]) cylinder(r=thread_diameter/4, h=thread_diameter);
        }
    }
}

include <bosl2/std.scad>;
include <bosl2/metric_screws.scad>;

module tool() {
    difference() {
        union() {
            translate([0, 0, base_length * 1.25]) split_cylinder();
            cylinder(d=base_diameter, h=base_length);
            translate([0, 0, base_length]) cylinder(d1=base_diameter, d2=shaft_diameter, h=base_length*0.25);
        }
        shaft();
    }
}

translate([20, 0, 0]) tool();
translate([-20, 0, base_length]) shaft();
