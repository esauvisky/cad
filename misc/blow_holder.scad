// $fn=100;


// difference() {
//     cylinder(d=20, h=10, center=true);
//     cylinder(d=16, h=10, center=true);
// }

// translate([17, 0, 0])
// difference() {
//     cylinder(d=11, h=10, center=true);
//     cylinder(d=7, h=10, center=true);

//     rotate([0, 0, 10])
//     translate([5,-0.5,0])
//     cube(size=[5, 1.5, 10], center=true);
//     rotate([0, 0, -10])
//     translate([5,0.5,0])
//     cube(size=[5, 1.5, 10], center=true);
// }

// translate([10, 0, 0])
// cube(size=[4, 4, 10], center=true);


$fn=100;
height=12;
diameter=22;
difference() {
    cylinder(d=diameter, h=height, center=true);
    cylinder(d=diameter-4, h=height, center=true);

    rotate([0, 0, 10])
    translate([-10,1,0])
    #cube(size=[5, 2.4, height], center=true);
    rotate([0, 0, -10])
    translate([-10,-1,0])
    #cube(size=[5, 2.4, height], center=true);
}

rotate([-90,0,0])
translate([diameter-3, 0, 0])
difference() {
    cylinder(d=9, h=10, center=true);
    cylinder(d=6, h=10, center=true);

    rotate([0, 0, 10])
    translate([5,-0.5,0])
    cube(size=[5, 1.5, 10], center=true);
    rotate([0, 0, -10])
    translate([5,0.5,0])
    cube(size=[5, 1.5, 10], center=true);
}

rotate([45,0,0])
translate([diameter/2+height/6, 0, 0])
rotate([0,270,0])
cylinder(d1=height/2, d2=height, height/2, $fn = 4, center=true);
// cube(size=[7, 4, 10], center=true);
