module parafuso(){
    union()
    {
        cylinder(h=4.5,d=8.5,$fn=100);
        cylinder(h=90,d=5.5,$fn=100);
    }
}module parafuso2(){
    union()
    {
        cylinder(h=9,d=11,$fn=100);
        cylinder(h=90,d=5.7,$fn=100);
    }
}
module parafuso3(){
    union()
    {
        cylinder(h=4.5,d=9.5,$fn=6);
        cylinder(h=90,d=5.7,$fn=100);
    }
}

difference(){
    intersection(){
        difference(){
            union(){
                scale([1,0.872,1])
                cylinder(h=24,d=60,$fn=100);
                translate([0,-37.5,0])
                cube([10,75,24]);
                difference() {
                    translate([0,0,12])
                    rotate([0,90,0])
                    cylinder(h=33,r=12,$fn=100);
                   
//                    translate([20,14,12])
//                    rotate([15,90,0])
//                    resize([18,10,40])
//                    cylinder(h=40,r=7,$fn=6);
                }
            }
            scale([1,0.872,1])
            translate([0,0,-0.5])
            cylinder(h=31,d=39,$fn=100);
            
        }
        translate([0,-100,-100])
        cube([100,200,200]);
    }
    translate([11,30,12])
    rotate([0,-90,0])
    #parafuso3();
    translate([11,-30,12])
    rotate([0,-90,0])
    #parafuso3();
    translate([18,00,12])
    rotate([0,90,0])
    #parafuso2();
}

translate([-30,0,0])
rotate([0,0,180])
difference(){
    intersection(){
        difference(){
            union(){
                scale([1,0.872,1])
                cylinder(h=24,d=60,$fn=100);
                translate([0,-37.5,0])
                cube([10,75,24]);
            }
            scale([1,0.872,1])
            translate([0,0,-0.5])
            cylinder(h=31,d=39,$fn=100);
        }
        translate([0,-100,-100])
        cube([100,200,200]);
    }
    translate([11,30,12])
    rotate([0,-90,0])
    #parafuso();
    translate([11,-30,12])
    rotate([0,-90,0])
    #parafuso();
}
