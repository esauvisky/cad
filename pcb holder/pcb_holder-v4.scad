include <dovetail.scad>;
include <pin_pegs.scad>;
pcb_length = 130;
pcb_thickness = 1.6;

width = 40;
height = 10;
length = 130;
number_of_joints = 5; // needs to be odd
triangles_positions = [];//[40, 10]; // positions on X axis in where to place the triangles supports

$fn=15;

module triangle_extrusion(side1,side2,corner_radius,triangle_height){
    rotate([0,270,0])
    translate([-corner_radius*2,corner_radius,]){
        hull(){
            translate([0,0,-triangle_height]) cylinder(r=corner_radius,h=triangle_height*4);
            translate([side1 - corner_radius * 2,-.5,triangle_height/2])cylinder(r=corner_radius*2,h=triangle_height);
            translate([0,side2 - corner_radius * 2])cylinder(r=corner_radius,h=triangle_height*2);
        }
    }
}

module triangle_pin() {
    translate([0,minkowski_triangles*2,height/2]){
        translate([1.3,0,0])
        difference() {
            triangle_extrusion(3,4,minkowski_triangles,1.7);
            translate([-0.2,-0.5,-0.1])
            triangle_extrusion(2,3,minkowski_triangles,1.6);
        }
    }
}

// temp variables
minkowski_triangles = 0.3;
min_width = 5.9;
max_width = 6;
depth = 6;
n_joints = (number_of_joints % 2 == 1) ? (number_of_joints == 1 ? 0 : number_of_joints) : number_of_joints + 1;
number_of_supports = n_joints == 1 ? 1 : floor(n_joints/2);
spacing_between_joints = (length - (max_width * n_joints))/(number_of_joints == 1 ? 1 : n_joints - 1);

difference() {
    union() {
        intersection() {
            minkowski() {
                difference() {
                    cube([length-2, width, height-minkowski_triangles], center=true);
                    translate([-length/2,-(pcb_thickness)/2-minkowski_triangles*3,-minkowski_triangles*2])
                    cube([pcb_length, pcb_thickness+minkowski_triangles*3*2, height/2+1]);
                }
                rotate([180,0,0])
                cylinder(minkowski_triangles*3,0,center=true);
            }
            cube([length-minkowski_triangles*2, width, height], center=true);
        }
        union() {
            for (i = [-number_of_supports:number_of_supports]) {
                translate([i*spacing_between_joints,width/2,0])
                rotate([270,0,0])
                pin(flat=0);
            }
        }
    }
    for (i = [-number_of_supports:number_of_supports]) {
        translate([i*spacing_between_joints,-width/2,-height/2+height/2])
        rotate([-90,180,0])
        pinhole(fixed=true);
    }
}

for (pos = triangles_positions) {
    for (m = [0:1]) {
        mirror([0,m,0]) {
            translate([pos,pcb_thickness/2+minkowski_triangles,0])
            triangle_pin();
        }
    }
}
