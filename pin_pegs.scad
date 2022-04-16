//// The protuberance that clicks
//// The slack/space/tolerance between holes and pegs (very sensitive)
//// The thickness of the outer layer
//// Radius of the peg
//// Length of the peg
//// Distance from the base of the peg to the nub_size
//// The length of the hole

module make_nub(r, nub_size) {
    union() {
        translate([0, 0, -nub_size - 0.5]) cylinder(r1 = r - nub_size, r2 = r, h = nub_size);
        cylinder(r = r, h = 1.02, center = true);
        translate([0, 0, 0.5]) cylinder(r1 = r, r2 = r - nub_size, h = 5);
    }
}

module pin(radius = 3.5, length = 13, nub_separation = 2.4, slot = 10, nub_size = 0.4, thickness = 2.2, clearance = 0.5) {
    flat = 0;
    translate(flat * [0, 0, radius / sqrt(2) - clearance]) rotate((1 - flat) * [90, 0, 0]) difference() {
        rotate([-90, 0, 0]) intersection() {
            union() {
                translate([0, 0, -0.01]) cylinder(r = radius - clearance, h = length - radius - 0.98);
                translate([0, 0, length - radius - 1]) cylinder(r1 = radius - clearance, r2 = 0, h = radius - clearance / 2 + 1);
                translate([nub_size + clearance, 0, nub_separation]) make_nub(radius - clearance, nub_size + clearance);
                translate([-nub_size - clearance, 0, nub_separation]) make_nub(radius - clearance, nub_size + clearance);
            }
            cube([3 * radius, radius * sqrt(2) - clearance, 2 * length + 3 * radius], center = true);
        }
        translate([0, nub_separation, 0]) cube([2 * (radius - thickness - clearance), slot, 2 * radius], center = true);
        translate([0, nub_separation - slot / 2, 0]) cylinder(r = radius - thickness - clearance, h = 2 * radius, center = true, $fn = 12);
        translate([0, nub_separation + slot / 2, 0]) cylinder(r = radius - thickness - clearance, h = 2 * radius, center = true, $fn = 12);
    }
}

module make_nub(radius, nub_size) union() {
    translate([0, 0, -nub_size - 0.5]) cylinder(r1 = radius - nub_size, r2 = radius, h = nub_size);
    cylinder(r = radius, h = 1.02, center = true);
    translate([0, 0, 0.5]) cylinder(r1 = radius, r2 = radius - nub_size, h = 5);
}

module pinhole(radius = 3.5, length = 13, nub_separation = 2.5, nub_size = 0.4, square_hole = true, fins = true) intersection() {
    union() {
        translate([0, 0, -0.1]) cylinder(r = radius, h = length - radius + 0.1);
        translate([0, 0, length - radius - 0.01]) cylinder(r1 = radius, r2 = 0, h = radius);
        translate([0, 0, nub_separation]) make_nub(radius + nub_size, nub_size);
        if (fins) translate([0, 0, length - radius]) {
                cube([2 * radius, 0.01, 2 * radius], center = true);
                cube([0.01, 2 * radius, 2 * radius], center = true);
            }
    }
    if (square_hole) cube([3 * radius, radius * sqrt(2), 2 * length + 3 * radius], center = true);
}

module pinpeg(radius = 3.5, length = 13, nub_separation = 2.4, nub_size = 0.4, thickness = 1.8, clearance = 0.3) union() {
    pin(radius = radius, length = length, nub_separation = nub_separation, nub_size = nub_size, thickness = thickness, clearance = clearance);
    mirror([0, 1, 0]) pin(radius = radius, length = length, nub_separation = nub_separation, nub_size = nub_size, thickness = thickness, clearance = clearance);
}







