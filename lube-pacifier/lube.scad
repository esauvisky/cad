include <threads.scad>

$fn = 50;

module holder() {
    translate([0,0,-0.5]) minkowski() {
        hull() {
            translate([0, 0, 0]) cylinder(r = 1, h = 4, center = true);
            ;
            translate([0, 0, 0]) cylinder(r = 1, h = 4, center = true);
            translate([0, 4, 0]) cube(size = [4, 2, 4], center = true);
        }
        sphere(r = 0.2);
    }
}
difference() {
    union() {
        translate([0, 0, -31.5]) hull() {
            translate([0, 0, 0]) cylinder(r = 0.5, h = 0.1);
            translate([0, 0, 25.5]) cylinder(r = 5, h = 1);
        }
        cylinder(r = 5, h = 10, center = true);
        translate([0,-6.5,3.3]) holder();
        translate([0,6.5,3.3]) mirror([0,1,0]) holder();
        translate([-6.5,0,3.3]) mirror([1,0,0]) rotate([0,0,90]) holder();
        translate([6.5,0,3.3]) mirror([1,0,0]) rotate([0,0,270]) holder();
    }
    translate([0, 0, -11]) hull() {
        translate([0, 0, -22]) cylinder(r = 0.1, h = 0.1);
        translate([0, 0, 0]) cylinder(r = 2.4, h = 0.1);
        translate([0, 0, 7]) cylinder(r = 3.5, h = 0.1);
    }
    translate([0, 0, -4]) rotate([0,0,180]) metric_thread(7, 1, 9, taper = 0.05, internal = true, leadin = 1, test = false);
}


