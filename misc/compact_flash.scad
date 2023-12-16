use <bosl2/rounding.scad>;

$fn=60;

module card_body(size_x, size_y, size_z, tolerance) {
    translate([0, (size_y + tolerance)/2])
    cube([size_x + tolerance * 2, size_y + tolerance, size_z + tolerance * 1.5], center = true);
}

module rail_groove(size_x, tolerance) {
    rail_x = 1;
    rail_y = 25.7;
    rail_z = 1.6;
    translate([0, (rail_y)/2]) {
        translate([-size_x/2 + rail_x / 2 - tolerance - tolerance / 2, 0, 0])
            cube([rail_x - tolerance, rail_y + tolerance, rail_z], center = true);
        translate([+size_x/2 - rail_x / 2 + tolerance + tolerance / 2, 0, 0])
            cube([rail_x - tolerance, rail_y + tolerance, rail_z], center = true);
    }
}

module compact_flash_card() {
    tolerance = 0.4;
    size_x = 42.7;
    size_y = 36.4;
    size_z = 3.2;
    rotate([270,180,0])
    difference() {
        card_body(size_x, size_y, size_z, tolerance);
        rail_groove(size_x, tolerance);
    }
}

module usb_card() {
    tolerance = 0.2;
    size_x = 13.2;
    size_y = 13;
    size_z = 4.5;
    rotate([270,180,90])
    card_body(size_x, size_y, size_z, tolerance);
}

module micro_sd_card() {
    tolerance = 0.2;
    size_x = 12;
    size_y = 12;
    size_z = 0.8;
    rotate([270,180,90])
    card_body(size_x, size_y, size_z, tolerance);
}

module sd_card() {
    tolerance = 0.3;
    size_x = 24;
    size_y = 24;
    size_z = 2;
    rotate([270,180,0])
    card_body(size_x, size_y, size_z, tolerance);
}


profile_points = [
    [0, 0],     // Bottom-left
    [28, 0],    // Bottom-right (assuming 20 units width)
    [28, 16],   // Top-right of the slanted part
    [23, 36],   // Top-right of the slanted part
    [23, 55],   // Top-right of the slanted part
    [18, 80],   // Top-left of the slanted part (assuming 10 units width and 90 units height)
    [8, 100],   // Top-left of the slanted part (assuming 10 units width and 90 units height)
    [0, 100]     // Top-left
];

length=100;

module base() {
    translate([length/2,0])
    rotate([0, 270, 0])        // Align the extrusion with the correct viewport
    linear_extrude(length) {   // Assuming a depth of 100 units for the base
        polygon(profile_points);
    }
}

difference() {
    color("brown", 0.5) base();

    // microSD cards in the third steep slanted part
    for(i = [-5, -4, -3, -2, -1, 0, 1, 2, 3, 4, 5]) {
        translate([i * 8, 83, 13]) rotate([243, 0]) micro_sd_card();
    }

    // USB slots at the topmost flat area
    for(i = [-2, -1, 0, 1, 2]) {
        translate([i * 19, 45.5, 10.8]) usb_card();
        translate([i * 19, 26, 25.55]) rotate([166, 0]) usb_card();
    }

    // CF cards
    translate([length/4 - 1, 8, 4]) compact_flash_card();
    translate([-length/4 + 1, 8, 4]) compact_flash_card();

    // SD cards in the second slanted part
    for(i = [-1, 0, 1]) {
        translate([(length / 4 + 5) * i, 60, 4]) sd_card();
        translate([(length / 4 + 5) * i, 68, 3]) sd_card();
        translate([(length / 4 + 5) * i, 75, 2]) sd_card();
    }
}
