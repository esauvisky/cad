/*
 * Global parameter - minimum size of the fragment on the surface. It depends on the 3D printer, usually ranges from 0.3 to 1 mm. This value significantly affects the rendering speed of the model.
 */
$fs = 0.3;

/*
 * Global parameter - the minimum angle for a fragment. This affects the "smoothness" of circles. The typical range is 3-7 degrees. It also significantly affects rendering speed.
 */
$fa = 3;

// All sizes are in mm

// Total height of the model
total_height = 8;

// Diameter of the central sphere. It is recommended to set a value slightly larger than total_height
diam_central_sphere = 15;

// Gap between the rings. This depends on the 3D printer capabilities
gap = 0.4;

// Thickness of the rings
ring_thickness = 2;

// Thickness of the final (outer) ring
last_ring_thickness = 2;

// Indentation of the lug from the outer side of the ring
lug_indent = 1;

// Diameter of the inner hole in the central sphere
diam_central_cylinder = 15;

/*
 * Text to be placed on the outer edge of the final ring.
 * The length of the text is not controlled, which might cause issues.
 * To generate a ring without text, the variable should contain a "space" character.
 * You can manage symbol placement using spaces at the beginning and end of the text.
 * It is recommended to use only uppercase letters.
 */
lettering_text = " ";

// Thickness of the letters on the outer edge of the final ring
letter_thickness = 1;

// Default font. It is recommended to use monospaced fonts.
def_font = "Liberation Mono:style=Regular";

// Number of inner rings, i.e., between the central sphere and the final ring
number_of_rings = 5;


// Main geometry
CentralSphere();

for (i = [1 : number_of_rings]) {
    SphereN(i);
}

SphereFinal(number_of_rings);

module CentralSphere() {
    union() {
        cube(size=[4, 0.5, total_height / 2], center=true);
        translate([diam_central_sphere / 2 - (gap * 3 + ring_thickness * 2) / 2, 0, 0]) {
            cube(size=[1, 0.5, total_height / 2], center=true);
        }
        translate([0, diam_central_sphere / 2 - (gap * 3 + ring_thickness * 2) / 2, 0]) {
            cube(size=[0.5, 1, total_height / 2], center=true);
        }
        translate([- (diam_central_sphere / 2 - (gap * 3 + ring_thickness * 2) / 2), 0, 0]) {
            cube(size=[1, 0.5, total_height / 2], center=true);
        }
        translate([0, - (diam_central_sphere / 2 - (gap * 3 + ring_thickness * 2) / 2), 0]) {
            cube(size=[0.5, 1, total_height / 2], center=true);
        }
        resize([diam_central_sphere - gap * 3 - ring_thickness * 2, diam_central_sphere - gap * 3 - ring_thickness * 2, total_height], auto=true)
        linear_extrude(height=total_height, center=true) {
            import("PokemodGroupLogo.svg", center=true);
        }
        difference() {
            intersection() {
                sphere(d = diam_central_sphere, center = true);
                cube([diam_central_sphere, diam_central_sphere, total_height], center = true);
            }
            cylinder(h = total_height + 1, d = diam_central_cylinder - ring_thickness * 2 - gap * 2, center = true);
        }
    }
}

module SphereN(N) {
    cur_sphere_d = diam_central_sphere + gap * 2 * N + ring_thickness * 2 * N;
    cur_inner_sphere_d = cur_sphere_d - ring_thickness * 2;

    echo("Ring:", N, ", sphere out d=", cur_sphere_d, ", in d=", cur_inner_sphere_d);

    intersection() {
        difference() {
            sphere(d = cur_sphere_d, center = true);
            sphere(d = cur_inner_sphere_d, center = true);
        }
        cube([cur_sphere_d, cur_sphere_d, total_height], center = true);
    }
}

module SphereFinal(N) {
    cur_sphere_d = diam_central_sphere + ring_thickness * 2 * N + gap * 2 * N + last_ring_thickness * 2 + gap * 2;
    cur_inner_sphere_d = cur_sphere_d - last_ring_thickness * 2;
    lug_angle = (total_height / 3 + 6) / (cur_sphere_d / 2) * (180 / PI);

    echo("Last ring:", cur_sphere_d, "/", cur_inner_sphere_d, "N:", N, lug_angle);
    union() {
        intersection() {
            difference() {
                sphere(d = cur_sphere_d, center = true);
                sphere(d = cur_inner_sphere_d, center = true);
            }
            cube([cur_sphere_d, cur_sphere_d, total_height], center = true);
        }

        WriteOnRing(lettering_text, cur_sphere_d / 2, total_height - 2, lug_angle);

        sym_seg = (360 - lug_angle) / len(lettering_text);
        rotate([0, 0, -(90 + sym_seg / 2 + lug_angle / 2)]) {
            union() {
                translate([-total_height / 3, cur_sphere_d / 2 + lug_indent, 0]) {
                    rotate([0, 90, 0])
                    rotate_extrude(angle = 180, convexity = 10)
                    translate([total_height / 3, total_height / 3, 0])
                    scale([1, 2, 1])
                    circle(d = total_height / 3, center = true);
                }
                difference() {
                    translate([0, 0, total_height / 2 - total_height / 3 / 2]) {
                        rotate([-90, 90, 0])
                        linear_extrude(height = cur_sphere_d / 2 + lug_indent)
                        scale([1, 2, 1])
                        circle(d = total_height / 3, center = true);
                    }
                    sphere(d = cur_inner_sphere_d + last_ring_thickness * 2);
                }
                difference() {
                    translate([0, 0, -total_height / 2 + total_height / 3 / 2]) {
                        rotate([-90, 90, 0])
                        linear_extrude(height = cur_sphere_d / 2 + lug_indent)
                        scale([1, 2, 1])
                        circle(d = total_height / 3, center = true);
                    }
                    sphere(d = cur_inner_sphere_d + last_ring_thickness * 2);
                }
            }
        }
    }
}

module WriteOnRing(text, radius, h, lug_angle) {
    text_len = len(text);
    sym_seg = (360 - lug_angle) / (text_len);

    intersection() {
        for (i = [0 : text_len - 1]) {
            curangle = sym_seg * i;
            echo(i, curangle, cos(curangle) * radius, sin(curangle) * radius);
            translate([cos(curangle) * radius, sin(curangle) * radius, -total_height / 2 + 2])
                rotate([0, 0, curangle])
                PrepareSymbol(text[i], h);
        }
        intersection() {
            difference() {
                sphere(d = radius * 2 + letter_thickness * 2, center = true);
                sphere(d = radius * 2 - last_ring_thickness, center = true);
            }
            cube([radius * 2 + letter_thickness + 5, radius * 2 + letter_thickness + 5, total_height], center = true);
        }
    }
}

module PrepareSymbol(sym, sym_size) {
    rotate(90, [0, 0, 1])
    rotate(90, [1, 0, 0])
    linear_extrude(height = 10, center = true)
    text(str(sym), size = sym_size, spacing = 1, halign = "center", valign = "baseline", font = def_font);
}
