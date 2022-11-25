include <dovetail.scad>
include <hinge.scad>
include <tesselations.scad>

//   union() {
//     rotate([0,90,0])
//     translate([-5,0.5,0])
//     cube([70,60,7]);
//     rotate([0,90,0])
//     translate([-5,-60.5,0])
//     cube([70,60,7]);
//   }

width = 5;
size = 75.5;
height = 135 + width;
magnet_dia = 3;
magnet_width = 2;
number_of_magnets = 3;
clearance = 0.15;
extra = width - width / 3;

module magnets(wall) {
    if (wall == "primary") {
        for (i = [0:number_of_magnets - 1]) {
            translate([size + width - magnet_width, width / 2, height * ((i + 1) / (number_of_magnets + 1))]) {
                rotate([0, 90, 0]) cylinder(r = magnet_dia / 2, h = magnet_width, $fn = 50);
            }
        }
        for (i = [0:number_of_magnets - 1]) {
            translate([width / 2 + magnet_width, size + width, height * ((i + 1) / (number_of_magnets + 1))]) {
                rotate([90, 0, 0]) cylinder(r = magnet_dia / 2, h = magnet_width, $fn = 50);
            }
        }
    } else {
        for (i = [0:number_of_magnets - 1]) {
            translate([size + width, width / 2, height * ((i + 1) / (number_of_magnets + 1))]) {
                rotate([0, 90, 0]) cylinder(r = magnet_dia / 2, h = magnet_width, $fn = 50);
            }
        }
        for (i = [0:number_of_magnets - 1]) {
            translate([width / 2, size + width + magnet_width, height * ((i + 1) / (number_of_magnets + 1))]) {
                rotate([90, 0, 0]) cylinder(r = magnet_dia / 2, h = magnet_width, $fn = 50);
            }
        }
    }
}

module dovetail_slot(wall) {
    if (wall == "primary") {
        // todo
    } else {
        translate([-clearance / 2, size + width, 0]) cube([width + clearance, width / 2, height]);
        mirror([1, 0, 0]) rotate([0, 0, 90]) translate([-clearance / 2, size + width, 0]) cube([width + clearance, width / 2, height]);
    }
}

module hinges() {
    $fn = 100;
    translate([size + width, 0, 0]) rotate([0, 90, 0]) mirror([1, 0, 0]) {
        applyHinges([[0, 0, 0]], [0], width - 0.9, width + 1.5, 30, 3, 0.5);
    }
}

module primary_wall() {
    length_adjust = size + width + width / 2 - clearance * 2;
    difference() {
        union() {
            // main body
            cube(size = [width, length_adjust, height]);
            translate([0, width, 0]) rotate([0, 0, 270]) cube(size = [width, length_adjust, height]);
            // corners
            translate([0, - width + width / 3, 0]) cube(size = [width, extra, height]);
            translate([-width + width / 3, 0, 0]) cube(size = [extra, width, height]);
            translate([width + size, size + width * 2, 0]) cube(size = [width, extra, height]);
            translate([size + width * 2, width + size, 0]) cube(size = [extra, width, height]);
        }
        // dovetail_slot("primary");
        // magnets("primary");
        // decoration

        translate([width * 3 / 2, 0, 15]) mirror([0, 1, 0]) rotate([90, 0, 0]) linear_extrude(width) grid(1, rows = 5, cols = 2.4);
        translate([width, width * 3 / 2, 15]) mirror([1, 0, 0]) rotate([90, 0, 90]) linear_extrude(width) grid(1, rows = 5, cols = 2.4);
    }
}

module secondary_wall() {
    // length_adjust = size + width * 2; // for magnets
    // length_adjust = size + width +0.9; // for hinges
    length_adjust = size + width * 2 + extra; // for dovetail_slots and slots
    difference() {
        translate([size + width * 2, size + width * 2, 0]) rotate([0, 0, 180]) {
            // main body
            cube(size = [width, length_adjust, height]);
            translate([0, width, 0]) rotate([0, 0, 270]) cube(size = [width, length_adjust, height]);
            // corners
            translate([size + width, -width + width / 3, 0]) cube(size = [width, extra, height]);
            translate([-width + width / 3, size + width, 0]) cube(size = [extra, width, height]);
        }
        dovetail_slot("secondary");
        // magnets("secondary");

        // decoration
        translate([width + size, size + width / 2, height - 15]) rotate([90, 180, 90]) linear_extrude(width) grid(1, rows = 5, cols = 2.4);
        translate([size + width / 2, size + width * 2, height - 15]) rotate([0, 0, 270]) rotate([90, 180, 90]) linear_extrude(width)
            grid(1, rows = 5, cols = 2.4);
    }
}
// hinges();

primary_wall();
secondary_wall();







