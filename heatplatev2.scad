box_height = 60;
do_minkowski = true;
include <hinge.scad>;


module finger_holes() {
    // finger quik release®
    translate([150/2-(24/2+5),24+5,box_height/2])
    cylinder(h=box_height, d=24, center = true);
    translate([150/2-(24/2+5),-24-5,box_height/2])
    cylinder(h=box_height, d=24, center = true);
    translate([150/2-(24/2+5),(-24-5)*2,box_height/2])
    cylinder(h=box_height, d=24, center = true);
    translate([150/2-(24/2+5),(24+5)*2,box_height/2])
    cylinder(h=box_height, d=24, center = true);
    //finger_holes();
    //mirror([1,0,0]) finger_hole();
    //mirror([1,-1,0]) finger_hole();
    //mirror([1,1,0]) finger_hole();
}
module heat_plate() {
    union() {
        difference() {
            translate([0,0,1])
            minkowski() {
                difference() {
                    linear_extrude(height = box_height - 2)
                    minkowski() {
                        square([150, 150], center = true);
                        circle(5);
                    };
                }
                sphere(1);
            }
            // dc jack
            diameter = 12;
            translate([0,80,box_height/2-10])
            rotate([90,0,0])
            cylinder(h = 50, d = diameter, center = true);
            // cables hole
            translate([0,160/2-20,17])
            translate([0,-5,-6])
            difference() {
                translate([0,4,4.2])
                rotate([40,0,0])
                resize([0,7.7,0])
                cylinder(h=1000, d=diameter);
                translate([0,10/2])
                linear_extrude(height = 29)
                square([14,10], center=true);
            }
            // dc nut hole
            translate([0,75])
            linear_extrude(height = 29)
            square([14.5,2.3], center=true);
            // top recess
            translate([0, -5, box_height - 5])
            linear_extrude(height = 5)
            square([150, 155], center = true);
            // main cavity
            translate([0,0,box_height-46])
            linear_extrude(height = 41)
            square([85, 85], center = true);
            // storage
            translate([160/2-32,6-160/2+70/2,(box_height-5)/2-30/2])
            linear_extrude(height=30)
            square([34,74]);
            mirror([1,0,0])
            translate([160/2-32,6-160/2+70/2,(box_height-5)/2-30/2])
            linear_extrude(height=30)
            square([34,74]);
            // door slots
            translate([160/2-4,-69/2-1,(box_height-5)/2+31/2])
            rotate([0,90,0])
            hinge_door_slot(69,31);
            mirror([1,0,0])
            translate([160/2-4-0.2,-69/2-1,(box_height-5)/2+31/2])
            rotate([0,90,0])
            hinge_door_slot(69,31);
        }
        // heatsink middle support
        minkowski() {
            translate([0,0,14])
            linear_extrude(height=12)
            square([85,8], center=true);
            sphere(1);
        }
        // front little click bar
        translate([0,-150/2-2,box_height-5])
        rotate([90,0,90])
        cylinder(h = 150, d = 2, center = true);
        // doors
        translate([160/2-4,-69/2-1,(box_height-5)/2+28.7/2])
        rotate([0,90,0])
        hinge_door(69,28.7,5);
        mirror([-1,0,0])
        translate([160/2-4-0.2,-69/2-1,(box_height-5)/2+28.7/2])
        rotate([0,90,0])
        hinge_door(69,28.7,5);
    };
};
heat_plate();
