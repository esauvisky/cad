include <hinge.scad>;


difference() {
    translate([-3,-10,0])
    cube([3,90,40]);
    translate([-3,-18,3])
    cube([3,90,32]);
    
    translate([0,0,4])
    rotate([0,270])
    hinge_door_slot(70,30);
}
    translate([0,0,4])
    rotate([0,270])
    hinge_door(70,30,7);