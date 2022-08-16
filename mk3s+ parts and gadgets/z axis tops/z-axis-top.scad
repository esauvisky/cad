// PRUSA iteration4
// Z axis top holder
// GNU GPL v3
// Josef Průša <iam@josefprusa.cz> and contributors
// http://www.reprap.org/wiki/Prusa_Mendel
// http://prusamendel.org

$fn=50;

module z_top_base()
{
    translate([0,-5,0]) cube([8,45,16]); // plate touching the base
    difference() {
        translate([0,-5,0]) cube([37.5,8.6,13]); // plate touching the base
        translate([8,-1,5]) rotate([0,0,0]) cube([25,25,10]);
    }
    translate([0,-5,0]) cube([37.5,45,5]); // plate touching the base
    translate([25+4.3,3.2,5]) rotate([0,0,0]) cylinder(h = 8, r=8.2, $fn=60);
}

module z_top_fancy()
{
    // Corner cutouts
    translate([0,0.5,0]) rotate([0,0,-45-180]) translate([-15,0,-1]) cube([30,40,51]);

    // frame side angle
    translate([-13,40+5+10.2,-3]) rotate([0,0,-45-0]) translate([0,0,-1]) cube([30,30,51]);
    translate([8,28,-3]) translate([0,0,-1]) cube([50,50,51]);

    // cut to shape
    translate([4,-1,13]) rotate([0,0, 0]) translate([0,-5,0]) cube([30,50,30]);
    translate([6,0,13]) rotate([0,-45, 0]) translate([0,-5,0]) cube([30,50,30]);
    //translate([8,3.9,11]) rotate([0,-45, 0]) translate([0,-5,0]) cube([30,50,30]);

    // nice edges
    translate([38-1.5,-5+2.5,-3]) rotate([0,0,-45-90]) translate([-15,0,-1]) cube([30,30,51]);
    translate([-10,49,3.2]) rotate([45,0,0]) translate([-15,0,-1]) cube([50,20,20]);

    // outer corner
    translate([35,26,-3]) rotate([0,0,-45])    translate([-15,0,-1]) cube([30,30,51]);
    translate([0,0,5]) rotate([45+180,0,0]) rotate([0,0,-45+90]) translate([0,0,-15]) cube([30,30,30]);

    // Stiffner cut out
    //translate([33,-1,7.5]) rotate([0,-45,0]) translate([0,-5,0]) cube([30,50,30]);

    // side cut out
    translate([-6,-5,-5.55]) rotate([45,0,0])  cube([50,5,5]);
    translate([-6,-5,-0.8]) rotate([0,45,0])  cube([5,50,5]);

    // z holder
    translate([20,5,9]) cube([20,15,4]); // it's bit up because it helps with printing
    translate([20,5,9]) rotate([30,0,0]) cube([20,15,6]); // it's bit up because it helps with printing

    // pokemod logo
    translate([29, 5, 0]) rotate([0,0,90]) resize([12, 12, 0.6]) linear_extrude() import(file = "../../misc/pokemod.svg", center = true, dpi = 96);
}

module z_top_holes()
{
    // Screw holes frame
    translate([-1,10,10])      rotate([0,90,0]) cylinder(h = 20, r=1.6, $fn=50);
    translate([-1,10+20,10])   rotate([0,90,0]) cylinder(h = 20, r=1.6, $fn=50);

    // Screw heads
    translate([4,10,10]) rotate([0,90,0]) cylinder(h = 15, r=3.1, $fn=50);
    translate([4,10-3.1,10]) cube([10,6.2,10]);
    translate([4,10+20,10])  rotate([0,90,0]) cylinder(h = 20, r=3.1, $fn=50);
    translate([4,10+20-3.1,10]) cube([10,6.2,10]);

    // Z rod holder
    translate([25+4.3,3,1.6]) rotate([0,0,0]) cylinder(h = 50, r=4.05, $fn=50);
    // translate([25+4.3,3,3.4]) rotate([0,0,0]) cylinder(h = 4.2, r2=4.3, r1=4.05, $fn=50);

    // material saving cut
    translate([15,10,-4]) rotate([0,0,0]) cylinder(h = 50, r=7, $fn=6);
    translate([15,28,-4]) rotate([0,0,0]) cylinder(h = 50, r=7, $fn=6);

    // z screw hole
    translate([25+4.3,3+17,0]) rotate([0,0,0]) cylinder(h = 50, r=5.8, $fn=50); // screw hole
    // translate([25+4.3,3+17,0.6]) rotate([0,0,0]) cylinder(h = 50, r=5.8, $fn=15); // screw hole
    translate([25+4.3-1,3,1.6]) cube([2,15,8]); // it's bit up because it helps with printing

    // //selective infill
    // translate([36.5,1.5,0.5]) cube([0.1,20,3.5]);
    // translate([10,-3,0.5]) cube([22,0.1,3.5]);
    // translate([3,1,0.5]) cube([18,0.1,3.5]);
    // translate([1.5,19,0.5]) cube([21,0.1,3.5]);

}

module z_top_right(){
    difference()
    {
        z_top_base();
        z_top_fancy();
        z_top_holes();
         //version
        translate([12,-1.5,10]) rotate([90,180,180]) linear_extrude(height = 0.6)
        { text("R3",font = "helvetica:style=Bold", size=4, center=true); }
    }
}

module z_top_left(){
    translate([0,-12,0]) mirror([0,1,0])
    difference()
    {
        z_top_base();
        z_top_fancy();
        z_top_holes();
        //version
        translate([19,-1,10]) rotate([90,180,0]) linear_extrude(height = 0.6)
        { text("L3",font = "helvetica:style=Bold", size=4, center=true); }
    }
}

// Final parts
z_top_left();
z_top_right();
