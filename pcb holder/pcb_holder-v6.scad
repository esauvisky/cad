include <BOSL/constants.scad>
use <BOSL/masks.scad>
include <../libraries/dovetail.scad>
include <pin_pegs.scad>
pcb_length = 130;
pcb_thickness = 1.6;

width = 30;
height = 10;
length = 100;
number_of_joints = 5;          // needs to be odd
triangles_positions = [30, -30]; //[40, 10]; // positions on X axis in where to place the triangles supports

$fn = 50; // for output
// $fn = 20;

module logos() {
translate([-25, 2, 0]) resize([12, 12, 2]) import(file = "pokemod.svg", center = true, dpi = 96);
// text("Pokemod", size = 8, font = "NewsCycle", halign = "center", valign = "center");
}
module make_holes() {
// make your custom holes here
// make_hole(-22, 30, 10);
}

/* custom holes */
module make_hole(x_offset, hole_length, hole_width = 10) {
translate([x_offset, width / 10, height / 2]) cube([hole_length, hole_width, height - height / 2 + 6], center = true);
}

// main pcb nub_separation
module pcb_slot() {
translate([pcb_length / 2, width / 10, height / 2]) rotate([270, 0, 90])
dovetail_3d(pcb_thickness + pcb_thickness * 0.2, pcb_thickness - pcb_thickness * 0.12, height / 2, pcb_length);
}

// temp variables
min_width = 4.9;
max_width = 8;
depth = 8;
n_joints = (number_of_joints % 2 == 1) ? (number_of_joints == 1 ? 0 : number_of_joints) : number_of_joints + 1;
number_of_supports = n_joints == 1 ? 1 : floor(n_joints / 2);
spacing_between_joints = (length - (max_width * n_joints)) / (number_of_joints == 1 ? 1 : n_joints - 1);





// main thing
difference() {
union() {
intersection() {
difference() {
cube([length, width, height * 2], center = true);
pcb_slot();
make_holes();
}

fillet(fillet = 5, size = [length, width, height], edges = EDGES_TOP - EDGE_TOP_FR - EDGE_TOP_BK) {
cube([length, width, height], center = true);
}
}
for (i = [-number_of_supports:number_of_supports]) {
translate([i * spacing_between_joints, width / 2, 0]) rotate([270, 0, 0]) {
pin();
}
}
}

for (i = [-number_of_supports:number_of_supports]) {
translate([i * spacing_between_joints, -width / 2, -height / 2 + height / 2]) rotate([-90, 180, 0]) {
pinhole();
}
}

}

translate([length / 2 - 35, -width / 4 - 1, height / 2]) rotate([0, 0, 0]) linear_extrude(height = .9) logos();

/* triangle thingie */
module triangle_pin() {
translate([0, 0, height / 2]) {
triangle_extrusion(3, 5, 0.06, 1.7);
}
}
module triangle_extrusion(side1, side2, corner_radius, triangle_height) {
rotate([0, 270, 0]) translate([-corner_radius * 2, corner_radius]) {

hull() {
translate([0, 0, -triangle_height])
cylinder(r = corner_radius, h = triangle_height * 4);
translate([side1 - corner_radius * 2, -.5, triangle_height / 2])
cylinder(r = corner_radius * 2, h = triangle_height);
translate([0, side2 - corner_radius * 2])
cylinder(r = corner_radius, h = triangle_height * 2);
}
}
}
// triangles positioning
translate([0, width / 10, 0]) for (pos = triangles_positions) {


for (m = [0:1]) {
mirror([0, m, 0]) {
translate([pos, pcb_thickness - pcb_thickness * 0.2, 0]) triangle_pin();
}
}
}

































