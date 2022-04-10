include <dovetail.scad>
include <pin_pegs.scad>
pcb_length = 130;
pcb_thickness = 1.6;

width = 30;
height = 10;
length = 130;
number_of_joints = 3;     // needs to be odd
triangles_positions = [30, -10]; //[40, 10]; // positions on X axis in where to place the triangles supports
$fn = 10;


module logos() {
    translate([-28,0,0])
    resize([10,10,2])
    import(file = "pokemod.svg", center = true, dpi = 96);
    text("Pokemod",
            size=8,
            font="Hacked",
            halign="center",
            valign="center");
}
module make_holes() {
    // make your custom holes here
    // make_hole(-22, 30, 10);
}

/* custom holes */
module make_hole(x_offset, hole_length, hole_width = 10) {
    translate([x_offset, width / 10, height / 2 + minkowski_triangles])
    cube([hole_length, hole_width, height - height / 2 + 6], center=true);
}

// main pcb slot
module pcb_slot() {
    translate([pcb_length / 2, width / 10, height / 2 + 0.5]) rotate([270, 0, 90]) dovetail_3d(
        pcb_thickness + minkowski_triangles * 2 * 2, pcb_thickness + minkowski_triangles * 2 * 1.4, height / 2 + minkowski_triangles * 4, pcb_length);
}

// temp variables
minkowski_triangles = 0.5;
min_width = 5.9;
max_width = 6;
depth = 6;
n_joints = (number_of_joints % 2 == 1) ? (number_of_joints == 1 ? 0 : number_of_joints) : number_of_joints + 1;
number_of_supports = n_joints == 1 ? 1 : floor(n_joints / 2);
spacing_between_joints = (length - (max_width * n_joints)) / (number_of_joints == 1 ? 1 : n_joints - 1);

// main thing
difference() {
    union() {
    translate([length/2-27,-width/4-1,height/2])
    rotate([0,0,0])
    linear_extrude(height=.9) logos();
        intersection() {
            minkowski() {
                difference() {
                    cube([length - minkowski_triangles * 2, width, height - minkowski_triangles * 2], center = true);
                    pcb_slot();
                    make_holes();
                    // cube([pcb_length, pcb_thickness + minkowski_triangles * 2 * 2, height / 2 + 1]);
                }
                rotate([180, 0, 0]) cylinder(minkowski_triangles * 2, 0, center = true);
            }
            cube([length, width, height], center = true);
        }
        for (i = [-number_of_supports:number_of_supports]) {
            translate([i * spacing_between_joints, width / 2, 0]) rotate([270, 0, 0]) pin(flat = 0);
        }
    }
    // translate([-length / 2, -(pcb_thickness) / 2, -1]) cube([pcb_length, pcb_thickness, height / 2]);
    for (i = [-number_of_supports:number_of_supports]) {
        translate([i * spacing_between_joints, -width / 2, -height / 2 + height / 2]) rotate([-90, 180, 0]) pinhole();
    }
}

/* triangle thingie */
module triangle_pin() {
    translate([0, 0, height / 2]) {
        triangle_extrusion(3, 5, minkowski_triangles / 3, 1.7);
    }
}
module triangle_extrusion(side1, side2, corner_radius, triangle_height) {
    rotate([0, 270, 0])
    translate([-corner_radius * 2, corner_radius]) {
        hull() {
            translate([0, 0, -triangle_height]) cylinder(r = corner_radius, h = triangle_height * 4);
            translate([side1 - corner_radius * 2, -.5, triangle_height / 2]) cylinder(r = corner_radius * 2, h = triangle_height);
            translate([0, side2 - corner_radius * 2]) cylinder(r = corner_radius, h = triangle_height * 2);
        }
    }
}
// triangles positioning
translate([0, width / 10, 0])
for (pos = triangles_positions) {
    for (m = [0:1]) {
        mirror([0, m, 0]) {
            translate([pos, pcb_thickness / 2 + minkowski_triangles, 0]) triangle_pin();
        }
    }
}



















