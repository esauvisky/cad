include <threads.scad>

body_diameter = 31;
thickness = 4;
diameter = 35.35;
thread_pitch = 1;
thread_length = 7.5;
height = 70;

$fn = 100;

module rounded_cylinder(r, h, n) {
    rotate_extrude(convexity = 1) {
        offset(r = n) offset(delta = -n) square([r, h]);
        square([n, h]);
    }
}

module body() {
    difference() {
        union() {
            rounded_cylinder(r = body_diameter / 2, h = height, n = 7);
            rotate([180, 0, 0]) translate([0, 0, -thread_length - 6]) {
                metric_thread(diameter, 1.5, thread_length, taper = 0.05, internal = false, leadin = 1, test = false);
            }
            translate([0, 0, 15]) cylinder(3, body_diameter / 2 + thread_pitch * 2, body_diameter / 2, center = true);
        }
        translate([0, 0, -thickness / 2 - 10]) {
            rounded_cylinder(r = body_diameter / 2 - thickness / 2, h = height + 10, n = 7 - thickness / 2);
        }
        cylinder(r = body_diameter / 2, h = 6, center = true);
    }
}

body();





