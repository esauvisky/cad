// The protuberance that clicks
nub = 0.4;
// The slack/space/tolerance between holes and pegs (very sensitive)
space = 0.3;
// The thickness of the outer layer
thickness = 2.2;
// Radius of the peg
radius = 3.5;
// Length of the peg
size = 15;
// Distance from the base of the peg to the nub
nub_dist = size / 5;
// The length of the hole
slot = (size - radius - space) * 0.9;

// pin(flat=0);
//%pinhole(fixed=true);

// pinpeg();
// translate([10,0,0])difference(){
//	cylinder(r=5.5,h=14);
//	pinhole(fixed=true);
// }
// translate([-10,0,0])difference(){
//	cylinder(r=5.5,h=14);
//	pinhole(fixed=false);
// }

module pin(r = radius, size = size, d = nub_dist, slot = slot, nub = nub, thickness = thickness, space = space, flat = 1) {
    translate(flat * [0, 0, r / sqrt(2) - space]) rotate((1 - flat) * [90, 0, 0]) difference() {
        rotate([-90, 0, 0]) intersection() {
            union() {
                translate([0, 0, -0.01]) cylinder(r = r - space, h = size - r - 0.98);
                translate([0, 0, size - r - 1]) cylinder(r1 = r - space, r2 = 0, h = r - space / 2 + 1);
                translate([nub + space, 0, d]) nub(r - space, nub + space);
                translate([-nub - space, 0, d]) nub(r - space, nub + space);
            }
            cube([3 * r, r * sqrt(2) - 2 * space, 2 * size + 3 * r], center = true);
        }
        translate([0, d, 0]) cube([2 * (r - thickness - space), slot, 2 * r], center = true);
        translate([0, d - slot / 2, 0]) cylinder(r = r - thickness - space, h = 2 * r, center = true, $fn = 12);
        translate([0, d + slot / 2, 0]) cylinder(r = r - thickness - space, h = 2 * r, center = true, $fn = 12);
    }
}

module nub(r, nub) {
    union() {
        translate([0, 0, -nub - 0.5]) cylinder(r1 = r - nub, r2 = r, h = nub);
        cylinder(r = r, h = 1.02, center = true);
        translate([0, 0, 0.5]) cylinder(r1 = r, r2 = r - nub, h = 5);
    }
}
module pinhole(r = radius, size = size, d = nub_dist, nub = nub, fixed = true, fins = true) {
	r = radius + 0.2;
	_size = size + 0.1;
    intersection() {
        union() {
            translate([0, 0, -0.1]) cylinder(r = r, h = _size - r + 0.1);
            translate([0, 0, _size - r - 0.01]) cylinder(r1 = r, r2 = 0, h = r);
            translate([0, 0, d]) nub(r + nub, nub);
            if (fins) translate([0, 0, _size - r]) {
                    cube([2 * r, 0.01, 2 * r], center = true);
                    cube([0.01, 2 * r, 2 * r], center = true);
                }
        }
        if (fixed) cube([3 * r, r * sqrt(2), 2 * _size + 3 * r], center = true);
    }
}

module pinpeg(r = radius, size = size, d = nub_dist, nub = nub, thickness = thickness, space = space) {
    union() {
        pin(r = r, size = size, d = d, nub = nub, thickness = thickness, space = space, flat = 1);
        mirror([0, 1, 0]) pin(r = r, size = size, d = d, nub = nub, t = t, space = space, flat = 1);
    }
}

