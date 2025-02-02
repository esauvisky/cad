include <BOSL/constants.scad>
include <BOSL/shapes.scad>
include <BOSL/threading.scad>
include <knurl_knob.scad>

// Key Parameters
base_length = 70;
base_width = 40;
hole_length = 53;
hole_angle = 25;
hole_thickness = 3.3;
base_bevel = 6;

// Derived Values (for readability)
hole_fillet = 1;
thread_diameter = 15;
thread_length = 15;

// Knob Parameters
knob_height = 15;
knob_dia = 22;
knurl_width = 4;
knurl_height = 5;

$fn = 20;

// Define points for base shape (with angle applied)
base_height = base_width * sin(hole_angle) + base_bevel;
base_points = [
    [0, 0],
    [0, base_bevel],
    [base_width * cos(hole_angle), base_height],
    [base_width * cos(hole_angle) + base_bevel, base_height],
    [base_width * cos(hole_angle) + base_bevel, 0]
];
echo(base_points);

// --- Modules ---

module base() {
    rotate([90, 0, 0])
    linear_extrude(height = base_length)
    polygon(points = base_points);
}

module hole() {
    rotate([0, -hole_angle, 0]) // Use hole_angle parameter
    translate([-hole_thickness + base_bevel, -(base_length - hole_length) / 2, -hole_thickness / 2 + base_bevel / 2])
    cuboid([base_width + base_bevel, hole_length, hole_thickness], fillet = hole_fillet, edges = EDGE_TOP_BK + EDGE_TOP_FR, align = V_BEFORE + V_RIGHT + V_BOTTOM + V_BOTTOM);
}

module rail_groove() {
    translate([0, -6, 0])
    // cuboid([base_width * cos(hole_angle) + base_bevel, base_length - (base_length - hole_length) / 2, hole_thickness], edges = EDGE_TOP_BK + EDGE_TOP_FR, align = V_BEFORE + V_RIGHT + V_ABOVE);
    prismoid(size1=[base_width * cos(hole_angle) + base_bevel, base_length - 12], size2=[base_width * cos(hole_angle) + base_bevel, base_length - 8], h=hole_thickness, align=V_BEFORE + V_RIGHT + V_ABOVE);
}

module thread_hole() {
    translate([(base_width-(base_bevel))/2, -base_length / 2, base_height])
    rotate([0, -hole_angle, 0]) // Use hole_angle parameter
    threaded_rod(d = thread_diameter, l = thread_length, bevel = false, internal = true, align = V_BOTTOM);
}

// --- Main Objects ---
// #rail_groove();
module main() {
    difference() {
        base();
        union() {
            hole();
            rail_groove();
            thread_hole();
        }
    }
}

module knob() {
    rotate([0, 180, 0]) // Adjust angle if needed
    union() {
        threaded_rod(d = thread_diameter, l = thread_length, bevel = true, align = V_BOTTOM);
        knurled_cyl(knob_height = knob_height, knob_dia = knob_dia, knurl_width = knurl_width, knurl_height = knurl_height, knurl_depth = 2, knurl_cutoff = knob_height - 1, smooth_amount = 50);
    }
}

module rail() {
    translate([0, - 6.25, 0])
    prismoid(size1=[base_width * cos(hole_angle) + base_bevel + 100, base_length - 12.5], size2=[base_width * cos(hole_angle) + base_bevel + 100, base_length - 9 ], h=hole_thickness-0.5, align=V_BEFORE + V_RIGHT + V_ABOVE);
    // cuboid([200, base_length - (base_length - hole_length) / 2 - 0.5, hole_thickness * .75], edges = EDGE_TOP_BK + EDGE_TOP_FR, align = V_BEFORE + V_RIGHT + V_ABOVE);
}
main();
translate([10, 20, 15]) knob();
translate([0, 100, 0]) rail();
