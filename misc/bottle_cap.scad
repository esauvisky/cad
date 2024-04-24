// Screw cap for squeeze bottles with spout
//
// 2019 Reven Sanchez
// This code is released in the Public Domain

// This object uses Gael Lafond's library
// https://www.thingiverse.com/thing:2200395
// include <helix_extrude.scad>
include <bosl/threading.scad>
include <bosl/shapes.scad>
// params
$fn = 50;  // detail level
Cd = 18.6; // Cap internal diameter
Ch = 6;  // Cap internal height (depth)
Ct = 0.8;  // Cap wall thickness
Sa = 7.2;  // Spout major diameter
Sm = 5.2;  // Spout minor diameter
Sh = 20;   // Spout height
St = 0.8;  // Spout thickness at base
Sp = 0.8;  // Spout thickness at top
Bh = 4; // Height of the bevel

union()
{

    translate([ 0, 0, Ch / 2 ])
    difference() {
        metric_trapezoidal_threaded_nut(od = 30, id = Cd + Ct, h = Ch + Ct * 2, pitch = 3, bevel = true);
        translate([ 0, 0, -(Ch + Ct * 2) / 2 ])
            difference() {
                cylinder(h = Ch * 2, d = 40);
                cylinder(h = Ch * 2, d = Cd + Ct + St * 2);
    }}


    translate([0,0,Ch + Ct + Bh])
    difference() {
        cylinder(h = Sh, d1 = Sa + Sp * 2 + Ct, d2 = Sm + Sp * 2);
        //cylinder(h = Sh, d1 = Cd + Ct - St * 2, d2 = Sm);
        cylinder(h = Sh, d1 = Sa - Sp * 2 + Ct, d2 = Sm);
    }

    translate([ 0, 0, Ct + Ch])
    difference() {
        cylinder(h = Bh, d1 = Cd + Ct + St * 2, d2 = Sa + Sp * 2 + Ct);
        cylinder(h = Bh, d1 = Cd + Ct - St * 2, d2 = Sa - Sp * 2 + Ct);
    }
    // difference() {
    //     cylinder(h = Ct, d = Cd + Ct + St * 2);
    //     cylinder(h = Ct, d = Sa - Sp * 2 + Ct);
    // }
}
