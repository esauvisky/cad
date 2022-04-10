include <dovetail.scad>;
include <pin_pegs.scad>;
pcb_length = 100;
pcb_thickness = 1.6;

width = 30;
height = 6;
length = 100;


module _right_triangle(side1,side2,corner_radius,triangle_height){
    rotate([0,270,0])
    translate([corner_radius,corner_radius,0]){  
        hull(){  
            translate([0,0,-triangle_height]) cylinder(r=corner_radius,h=triangle_height*4,$fn=10);
            translate([side1 - corner_radius * 2,0,triangle_height/2])cylinder(r=corner_radius*2,h=triangle_height,$fn=10);
            translate([0,side2 - corner_radius * 2])cylinder(r=corner_radius,h=triangle_height*2,$fn=10);  
        }
    }
}
module right_triangle() {
    translate([1.3,0,0])
    difference() {
        _right_triangle(4,5,0.3,1.3);
        translate([-0.3,0.5,0])
        _right_triangle(3,4,0.3,1);
    }
}
module negocinho_que_segura() {
    translate([0,0.3,height/2-0.6])
    minkowski(){
        right_triangle();
        sphere(0.3);
    }
}


// temp variables
min_width = 5.9;
max_width = 6;
depth = 6;
number_of_joints = 5; // needs to be odd
number_of_supports = floor(number_of_joints/2);
spacing_between_joints = (length - (max_width * number_of_joints))/(number_of_joints-1);

difference() {
    union() {
//        for (i = [-2:+2]) {
        for (i = [-number_of_supports:number_of_supports]) {
            translate([i*spacing_between_joints,width/2,-3/2])
            pinpeg();
        }
        difference() {
            cube([length, width, height], center=true);
            for (i = [-number_of_supports:number_of_supports]) {
                translate([i*spacing_between_joints,-width/2,-height/2+height/2])
                rotate([-90,180,0])
                pinhole(fixed=true);
            }
        }
    }
    translate([-length/2,0,-1])
    cube([pcb_length, pcb_thickness, height/2+2]);
};
//                translate([i*spacing_between_joints,-(width/2),-height/2+height/2-height/8])
                
//translate([30,pcb_thickness,0])
//negocinho_que_segura();
//translate([-10,pcb_thickness,0])
//negocinho_que_segura();
//
//mirror([0,1,0]) {
//    translate([30,0,0])
//    negocinho_que_segura();
//    translate([-10,0,0])
//    negocinho_que_segura();
//}