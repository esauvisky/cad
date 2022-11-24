height = 23;
width = 40;
depth = 9;
end_radius = 5.1;
screw_holes_distance = 25;
plug_diameter = 11;
tolerance = 0.5;

$fn = 100;
// square(size=[height, width-2*end_radius], center=true);

module hole() {
    translate([0, 0, -depth / 2]) {
        hull() {
            translate([0, 0, depth]) {
                linear_extrude(height = 0.0001) {
                    minkowski() {
                        square(size = [height - 3.5, end_radius / 2], center = true);
                        circle(d = end_radius * 4);
                    }
                }
            }
            linear_extrude(height = 0.0001) {
                minkowski() {
                    square(size = [height - 3.5 - tolerance, end_radius / 2], center = true);
                    circle(d = end_radius * 4 - tolerance);
                }
            }
        }

        // hull() {
        //     translate([width / 2 - height / 2, 0, 0]) circle(r = height / 2);
        //     translate([-width / 2 + height / 2, 0, 0]) circle(d = height);
        // }
        // }
    }
}

module corner() {
    difference() {
        cube(size = [30, height * 1.2, depth * 1.2], center = true);
        translate([-10, 10, 0]) cylinder(r = 20, h = depth * 1.2, center = true);
        translate([0, height / 2 + 2.9, 0]) cube(size = [50, height, depth * 1.2], center = true);
    }
}

module base(top = false, incline = 1) {
    if (top) {
        translate([0, 5, 0]) cube(size = [width * 1.5, 15, depth * 1.2], center = true);
    } else {
        cube(size = [width * 1.5, 12, depth * 1.2], center = true);
    }
}

module support_hole() {
    rotate([90, 0, 0]) {
        cylinder(r = 2.5, h = 50, center = true);
        translate([0, 0, -4]) cylinder(r = 5, h = 20, center = true);
    }
}

module cleanup() {
    translate([-48, -10, 0]) cube(size = [10, 30, 50], center = true);
    translate([-48, -10, 0]) rotate([0, 0, -45]) cube(size = [10, 30, 50], center = true);
}

difference() {
    difference() {
    translate([0, 0, -1]) union() {
            hull() {
                minkowski() {
                    scale([1.2, 1.2, 1.2]) {
                        hole();
                    }
                    cylinder(r = 2, h = 0.0001, center = true);
                }
                translate([0, -12, 0]) base(false);
            }
        // translate([-width/2-13,0,0]) {
        //     corner();
        // }

        // mirror([1,0,0])
        // translate([-width/2-13,0,0]) {
        //     corner();
        // }

        translate([0, -17, 0]) base(false, -1);
    }
    // translate([0, -72, 0]) rotate([12, 0, 0]) cylinder(r = 55, h = 50, center = true, $fn = 100);
    translate([0, -72, 0]) cylinder(r = 55, h = 50, center = true, $fn = 100);
    }
    hole();

    // translate([0, -48, 0]) cylinder(r = 48, h = 50, center = true, $fn = 100);

    // light screw holes
    translate([-screw_holes_distance / 2, 0, -5]) cylinder(r = 1.5, h = 30, center = true, $fn = 100);
    translate([screw_holes_distance / 2, 0, -5]) cylinder(r = 1.5, h = 30, center = true, $fn = 100);
    // main cable hole
    translate([0, 5, -5]) cylinder(d = plug_diameter, h = 30, center = true, $fn = 100);

    // supporting screw holes
    translate([0, -15, 10]) rotate([90, 0, 0]) union() {
        translate([width / 2 + 3, 0, -tolerance * 2]) support_hole();
        mirror([1, 0, 0]) translate([width / 2 + 3, 0, -tolerance * 2]) support_hole();
    }

    // cleanup
    cleanup();
    mirror([1, 0, 0]) cleanup();
}





