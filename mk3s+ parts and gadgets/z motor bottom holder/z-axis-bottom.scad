// PRUSA iteration4
// Z axis bottom holder
// GNU GPL v3
// Josef Průša <iam@josefprusa.cz> and contributors
// http://www.reprap.org/wiki/Prusa_Mendel
// http://prusamendel.org

module z_bottom_base()
{
     translate([0,-1.5,0]) cube([7.5,49,16+20]); // plate touching the base
     translate([0,-5,0]) cube([43,3.7,29]); // plate touching the base
     translate([0,-5,0]) cube([7.5,3.7,36]); // plate touching the base
     translate([0,42,0]) cube([43,5.5,29]); // plate touching the base
     translate([0,-5,0]) cube([50,52.5,7]); // plate touching the base
}

module z_bottom_fancy()
{
    // corner cutouts
    // translate([0.5,-2.5,-2]) rotate([0,0,-45-180]) translate([-15,0,-1]) cube([30,30,51]);
    // translate([0.5,40-0.5+5,-2]) rotate([0,0,-45+90]) translate([-15,0,-1]) cube([30,30,51]);

    translate([8,0,12+20+6]) rotate([0,-90,0]) translate([0,-5,0]) cube([30,50,30]);
    translate([21,-2,12+8+15]) rotate([45,0,0]) rotate([0,-90,0]) translate([0,-5,0]) cube([30,50,30]);
    translate([25,20,12+30+18]) rotate([-45,0,0]) rotate([0,-90,0]) translate([0,-5,0]) cube([30,50,30]);
    translate([50-2.5,-5+2.5+68.5,-2]) rotate([0,0,-45-90]) translate([-15,0,-1]) cube([30,30,51]);
    translate([50-2.5,-5+2.5,-2]) rotate([0,0,-45-90]) translate([-15,0,-1]) cube([30,30,51]);

//    translate([-38,-10,-2]) rotate([0,45,0]) cube([30,60,30]);

    // Stiffner cut out
    translate([45,0,7.5]) rotate([0,-45,0]) translate([0,-5,0]) cube([30,60,50]);

    // translate([-5,-10,-8.0]) rotate([45,0,0]) cube([60,10,10]);
    // translate([-5,52.0,-8.5]) rotate([45,0,0]) cube([60,10,10]);
    // translate([47,-10,-2]) rotate([0,45,0]) cube([30,60,30]);

    // translate([49,37.5,-2]) rotate([0,45,45]) cube([30,30,30]);
    // translate([29,-16.7,-2]) rotate([0,45,-45]) cube([30,30,30]);
}

module z_bottom_quick_release(hole = true)
{
    difference()
    {
        // main bar
        union()
        {
            translate([39.2,0,3.5]) cube([10.8,40,3.5]);
            translate([38.2,15,0]) cube([11.8,10,3.5]);
        }

            // motor opening
        translate([25+4.3,20,-1]) {
        translate([0,0,-1]) cylinder(h = 20, r=12, $fn=100);
        translate([0,0,-0]) cylinder(h = 2, r2=12, r1=12, $fn=100);
        }
        translate([25+4.3,20,-1]){
            translate([15.5,15.5,-1]) cylinder(h = 20, r=1.65, $fn=100);
            translate([15.5,-15.5,-1]) cylinder(h = 20, r=1.65, $fn=100);
        }

        // fancy corners
        // translate([47,-10,-2]) rotate([0,45,0]) cube([30,60,30]);
        translate([32,6.8,0]) rotate([0,0,-45]) cube([20,3,7]);
        translate([32,29,0]) rotate([0,0,45]) cube([20,3,7]);
    }
}

module z_bottom_holes()
{
    // Frame mounting screw holes
    translate([-1,10,12]) rotate([0,90,0]) cylinder(h = 20, r=1.6, $fn=100);
    translate([-1,10+20,12]) rotate([0,90,0]) cylinder(h = 20, r=1.6, $fn=100);
    translate([-1,10+10,32]) rotate([0,90,0]) cylinder(h = 20, r=1.6, $fn=100);

    // Frame mounting screw head holes
    translate([4,10,12]) rotate([0,90,0]) cylinder(h = 20, r=3.1, $fn=100);
    translate([4,10+20,12]) rotate([0,90,0]) cylinder(h = 20, r=3.1, $fn=100);
    translate([4,10+10,32]) rotate([0,90,0]) cylinder(h = 20, r=3.1, $fn=100);
    translate([4,10+10-3.1,10+20+2]) cube([10,6.2,10]);
    // translate([4,10,38]) rotate([0,45,0]) cube([10,20,10]);

    // Z rod holder
    difference() {
        translate([25+4.3,3,-0.1]) rotate([0,0,0]) cylinder(h = 5.6, r=4, $fn=100);
        translate([23.3,-5,5.45-0.222]) cube([5,20,5]);
        translate([23.3+7,-5,5.45-0.22]) cube([5,20,5]);
    }

    // rod align with motor
   translate([25+4.3,3,-0.1]) cylinder(h = 15.6, r=4, $fn=100);
   translate([25+4.3-1,2,4.5-1]) rotate([0,0,0]) cube([2,10,4]) ;

    // translate([25+4.3,3,-2.1]) rotate([0,0,0]) cylinder(h = 2.6, r1=6, r2=4, $fn=100);
    // translate([25+4.3-1,3,3.5]) cube([2,10,8]); // it's bit up because it helps with printing

    // motor mounting
    translate([25+4.3,20,-1]){
        translate([15.5,15.5,-1]) cylinder(h = 20, r=1.65, $fn=100);
        translate([15.5,-15.5,-1]) cylinder(h = 20, r=1.65, $fn=100);
        translate([-15.5,15.5,-1]) cylinder(h = 20, r=1.65, $fn=100);
        translate([-15.5,-15.5,-1]) cylinder(h = 20, r=1.65, $fn=100);

        // translate([15.5,15.5,-0.5]) cylinder(h = 2, r1=4.5, r2=3.2,$fn=100);
        // translate([15.5,-15.5,-0.5]) cylinder(h = 2, r1=4.5, r2=3.2, $fn=100);
        // translate([-15.5,15.5,-0.5]) cylinder(h = 2, r1=4.5, r2=3.2, $fn=100);
        // translate([-15.5,-15.5,-0.5]) cylinder(h = 2, r1=4.5, r2=3.26, $fn=100);

        // motor_opening();
    translate([0,0,-1]) cylinder(h = 20, r=12, $fn=100);
    translate([0,0,-0]) cylinder(h = 10, r2=12, r1=12, $fn=100);
    }

}

module motor_opening() {
    // motor opening

    // difference()
    // {
    //     union()
    //     // fancy corners
    //     translate([32,7,0]) rotate([0,0,-45]) cube([20,3,7]);
    //     translate([32,29,0]) rotate([0,0,45]) cube([20,3,7]);
    //     translate([17.15,-20,3.5]) cube([10,60,2]);
    //     translate([3.85,-20,3.5]) cube([10,60,2]);
    //     translate([-27.15,-20,3.5]) cube([10,60,2]);
    //     translate([-13.85,-20,3.5]) cube([10,60,2]);

    // }
}



module z_bottom_right()
{
    difference()
    {
        difference()
        {
            z_bottom_base();
            z_bottom_quick_release();
            z_bottom_fancy();
            z_bottom_holes();
        }
        translate([7.3,24,14]) rotate([90,180,90]) linear_extrude(height = 0.6)
        { text("v5.3",font = "helvetica:style=Bold", size=3); }

        translate([7,24,25]) rotate([90,180,90]) linear_extrude(height = 0.9)
        { text("R",font = "helvetica:style=Bold", size=8); }

    }

     translate([110,0,7]) rotate([0,180,0]) z_bottom_quick_release(true);
}

module z_bottom_left()
{
    difference()
    {
        translate([0,-13,0]) mirror([0,1,0])
        difference()
        {
            z_bottom_base();
            z_bottom_quick_release();
            z_bottom_fancy();
            z_bottom_holes();
        }
        translate([7.3,-28.5,14]) rotate([90,180,90]) linear_extrude(height = 0.6)
        { text("v5.4",font = "helvetica:style=Bold", size=3); }

        translate([7,-29,25]) rotate([90,180,90]) linear_extrude(height = 0.9)
        { text("L",font = "helvetica:style=Bold", size=8); }

    }

    translate([0,-13,0]) mirror([0,1,0]) translate([110,0,7]) rotate([0,180,0]) z_bottom_quick_release(true);
}




z_bottom_right();
z_bottom_left();













