h = 60;

difference() {
    linear_extrude(height = h)
        square([160, 160], center = true);
    translate([0,0,h-5])
        linear_extrude(height = 5)
            square([150, 150], center = true);
    translate([0,0,h-40])
        linear_extrude(height = 40)
            square([100, 100], center = true);
    translate([0,50,10])
        linear_extrude(height = h-20)
            square([60,6], center = true);
    translate([0,50,h-20])
        linear_extrude(height = 20)
            square([35,6], center = true);
    translate([0,65])
        linear_extrude(height = h-20)
            square([100,25], center = true);
    translate([30,80,h/2-10])
        resize([10,5,11])
        rotate([90,0,0])
            cylinder(h = 5, r = 5, center = true);
}