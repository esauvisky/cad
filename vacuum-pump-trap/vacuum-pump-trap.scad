include <threads.scad>

body_diameter = 31;
thickness = 4;
diameter = 37;
thread_pitch = 1;
thread_length = 7.5;
height = 71;

testing = false;

// if (testing == true) {
//     $fn = 10;
// } else {
    $fn = 50;
// }

module rounded_cylinder(r, h, n) {
    rotate_extrude(convexity = 1) {
        offset(r = n) offset(delta = -n) polygon(points = [
            [0, 0],
            [0, h],
            [r, h],
            [r*1.05, 0]
        ]);
        square([n, h]);
    }
}

module body() {
    difference() {
        union() {
            rounded_cylinder(r = body_diameter / 2, h = height, n = 7.5);
            rotate([180, 0, 0]) translate([0, 0, -thread_length - 7]) {
                metric_thread(diameter, 1.5, thread_length,taper = 0.05, internal = false, leadin = 1, angle=28, test = testing);
            }
            translate([0, 0, 16]) cylinder(3, body_diameter / 2 + thread_pitch * 2, body_diameter / 2, center = true);
            translate([0, 0, 6]) rotate([0,180,0]) cylinder(2, body_diameter / 2 + thread_pitch * 1.3, body_diameter / 2 + thread_pitch * 1.2, center = true);
        }
        translate([0, 0, -thickness / 2 - 10]) {
            rounded_cylinder(r = body_diameter / 2 - thickness / 2, h = height + 10 - thickness / 2, n = 7 - thickness / 2);
        }
        cylinder(r = body_diameter / 2, h = 6, center = true);
    }
}

body();





