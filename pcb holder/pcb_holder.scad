include <dovetail.scad>;
//translate([0,-15,0]) 
//union() {
//    male_dovetail(max_width=10, min_width=8, depth=5, height=30, cutout_width=3, cutout_depth=4);
//    translate([-10,-5,0]) cube([20,5,30]);
//}

pcb_length = 80;
pcb_thickness = 1.6;

width = 40;
height = 10;
length = 100;

// temp
a = 10;

translate([-length/2,width/2,0])
rotate([0,90,0])
male_dovetail(max_width=6, min_width=5, depth=2, height=length, cutout_width=1, cutout_depth=1);
difference() {
    union() {
    translate([length/2,-(width/2),0])
    rotate([0,270,0])
    female_dovetail(max_width=6, min_width=5, depth=2, height=length, block_width=height, block_depth=a, clearance=0.25);
        translate([0,a/2,0])
        cube([length, width-a, height], center=true);
    }
    translate([-length/2,0,0])
    cube([pcb_length, pcb_thickness, height/2]);
}