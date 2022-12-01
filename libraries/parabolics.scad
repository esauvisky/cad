/**
 * Returns a parabolic 2D shape with the given focal point and length
 */
module parabola(length, focus) {
    rotate([0,0,-90])
    projection(cut = true)                                                                       // reduce from 3D cone to 2D parabola
        translate([0, 0, focus * 2]) rotate([45, 0, 0])                                          // rotate cone 45° and translate for cutting
        translate([0, 0, -length / 2]) cylinder(h = length , r1 = length, r2 = 0, center = true); // center cone on tip
}

module paraboloid(height = 10, focus = 5, radius = 0) {
    // height = height of paraboloid
    // focus = focus distance
    // radius = radius of the focus area : 0 = point focus

    hi = (height + 2 * focus) / sqrt(2); // height and radius of the cone -> alpha = 45° -> sin(45°)=1/sqrt(2)
    x = 2 * focus * sqrt(height / focus);    // x  = half size of parabola

    translate([0, 0, -focus])              // center on focus
        // rotate_extrude(convexity = 10) // extrude paraboild
        translate([radius, 0, 0])       // translate for fokus area
        difference() {
        union() {                                                                            // adding square for focal area
            projection(cut = true)                                                           // reduce from 3D cone to 2D parabola
                translate([0, 0, focus * 2]) rotate([45, 0, 0])                                  // rotate cone 45° and translate for cutting
                translate([0, 0, -hi / 2]) cylinder(h = hi, r1 = hi, r2 = 0, center = true); // center cone on tip
            translate([-(radius + x), 0]) square([radius + x, height]);                             // focal area square
        }
        translate([-(2 * radius + x), -1 / 2]) square([radius + x, height + 1]); // cut of half at rotation center
    }
}
// paraboloid(height = 50, focus = 10, radius = 10);



