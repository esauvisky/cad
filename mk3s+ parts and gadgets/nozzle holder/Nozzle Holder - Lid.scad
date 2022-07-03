include <BOSL/shapes.scad>;

thickness = 16;

difference(){
        group(){
        translate([0,-40,thickness/2])
        cuboid([45,89,thickness]);

        translate([0,-73,thickness/2])
        cuboid([63,23,thickness]);

        translate([0,-83,thickness/2])
        rotate([0,0,-45])
        cuboid([38,38,thickness]);
    }
    

    translate([0,-113,thickness/2])
    cuboid([10,10,20]);
    
    translate ([-23,-45,16])
    rotate([0,90,0])
    cylinder(48, 8,8);

    difference(){
        translate ([0,0,1.5])
            group(){
            translate([0,-40,thickness/2])
            cuboid([43,87,thickness+0.01]);

            translate([0,-73,thickness/2])
            cuboid([61,21,thickness+0.01]);

            translate([0,-83,thickness/2])
            rotate([0,0,-45])
            cuboid([36,36,thickness+0.01]);
        }
        

        translate([0,-110,thickness/2])
        cuboid([11,11,21]);
    }
}