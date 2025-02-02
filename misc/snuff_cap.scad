// Screw cap for squeeze bottles with spout
//
// 2019 Reven Sanchez
// This code is released in the Public Domain

// This object uses Gael Lafond's library
// https://www.thingiverse.com/thing:2200395
// include <helix_extrude.scad>
include <bosl / shapes.scad>
include <bosl / threading.scad>
// params
$fn = 100;                 // detail level
Cd = 18.6;                 // Cap internal diameter
Ch = 12;                   // Cap internal height (depth)
Ct = 1;                    // Cap wall thickness
Sa = 7.2;                  // Spout major diameter
Sm = 5.2;                  // Spout minor diameter
Sh = 20;                   // Spout height
St = 0.8;                  // Spout thickness at base
Sp = 0.8;                  // Spout thickness at top
Bh = 4;                    // Height of the bevel
Cw = Cd + Ct * 4 + St * 2; // Cap width

height = Cd;           // Height of the cylinder
outer_radius = Cd * 5; // Outer radius of the cylinder
hole_radius = 1;       // Radius of each hole
hole_spacing = 5;      // Spacing between centers of holes

module snap_lock(pin_height = 5, snap_height = 3, width = 2, thickness = 3) {
    // Create the 2D shape and extrude it
    rotate([90,0,0])
    linear_extrude(thickness)
    polygon(points=[[0,0], [- width / 2, 0], [- width / 2, pin_height + snap_height], [width / 2, pin_height], [0, pin_height], [0, 0]]);
}

// Function to create a grid of holes on a circular pattern
module circular_hole_pattern() {
    for (angle = [0:360 / hole_spacing : 360]) {
        for (radius = [sqrt(5):4 : Cd / 2]) {
            translate([radius * cos(angle), radius * sin(angle), 0])
                cylinder(h = height, r = hole_radius, center = true, $fn = $fn);
        }
    }
}

module cap() {
    union() {

        translate([0, 0, Ch / 2 + Ct]) difference() {
            union() {
                metric_trapezoidal_threaded_nut(od = 30, id = Cd + Ct, h = Ch + Ct * 2, pitch = 3, bevel = true);
                // lid cover

                difference() {
                    translate([0, 0, Ch / 2 + Ct]) cyl(h = Ch, d = Cw, fillet = (Ch) / 2);
                    union() {
                        translate([0, 0, Ch / 2 + Ct])
                            cyl(h = Ch - Ct * 2, d = Cd - Ct + St * 2, fillet = (Ch - Ct * 2) / 2);
                        translate([0, 0, Ch / 2 + Ct * 2]) cyl(h = Ct * 2, d = Cd - Ct / 2 + St * 2);
                        cube([Cw, Cw, Ch + Ct * 2], center = true);
                    }
                }
                // cylinder with holes
                // translate([ 0, 0, Ch / 2 + Ct ]) difference()
                // {
                //     cyl(h = Ct, d = Cd + Ct);
                //     circular_hole_pattern();
                // }
            }
            translate([0, 0, -(Ch + Ct * 2) / 2]) difference() {
                cylinder(h = Ch * 2, d = 40);
                cylinder(h = Ch * 2, d = Cw);
            }
        }

        // Bucket
        // translate([ 0, 0, 2 * - Ch - Ct ])
        // difference() {
        //     cylinder(h = Ch + Ct, d1 = Sa + Ct, d2 = Sa + Sp * 2 + Ct);
        //     cylinder(h = Ch + Ct, d1 = Sa - Sp * 2 + Ct, d2 = Sa + Ct);
        // }
        // translate([ 0, 0,  2 * - Ch - Ct])
        // cylinder(h = Ct, d = Sa - Sp * 2 + Ct);

        // // connecting rod
        // translate([ 0, 0, -Ch * 2 - St])
        // cylinder(h = Sh, d = Ct * 2);

        // difference() {
        //     cylinder(h = Ct, d = Sa - Sp * 2 + Ct);
        // }
    }
}

cube([5,7,5]);
translate([2,5,5])
snap_lock(pin_height = 5.5, snap_height=4.5, width = 4, thickness=4);

difference() {
translate([0, -10, 0])
cube([10,7,10]);

translate([5, -5, -3])
snap_lock(pin_height = 5, snap_height=5, width = 4.5, thickness=4);
}
