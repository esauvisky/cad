include <BOSL/constants.scad>
use <BOSL/metric_screws.scad>
// translate([-15.8, -14,-2.6]) %import("xiaomi.stl");
$fn = 100;
union() {
    difference() {
        cylinder(r = 7.5, h = 40);

        difference() {
            translate([-11, 0, 0]) cylinder(r = 10.5, h = 40);
            translate([-11, 0, 0]) cylinder(r = 8.2, h = 40);
        }
    }
    intersection() {
        translate([-8.5, 0, 10]) cube(size = [8, 7.7, 60], center = true);
        translate([1, 0, 20]) cylinder(r = 12, h = 40, center = true, $fn = 100);
    }
}

// "nut"
translate([0, 0, 20]) difference() {
    translate([0, 0, 27]) cylinder(r = 11.5, h = 14, center = true);
    // translate([0, 0, 42.5]) metric_bolt(size = 9, l = 20, coarse = true, details = true);
    translate([0, 0, 23]) cylinder(r = 3.5, h = 20);
    translate([8, 0, 25.5]) {
        union() {
            cube(size = [20, 14, 5.5], center = true);
            translate([-8.5, 0, 0]) cylinder(r = 8, h = 5, center = true, $fn = 6);
        }
    }
}

//
// translate([0, 0, 15]) difference() {
//     translate([0, 0, -2.5]) cylinder(r = 11.5, h = 5, center = true);
//     // cylinder(r = 7.5, h = 10, center = true);
//     // translate([0, 10, 0]) cube(size = [2, 5, 10], center = true);
// }










