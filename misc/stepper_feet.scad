include <pin_pegs.scad>

dia=33;
height=40;
hole=12;
$fn=100;

translate([0, 0, -height/2]) {
    cylinder(r=dia/2-1, r2=dia/2,h=height, center=true);
}
    pin(radius=hole/2,length=8,nub_size=0.6,thickness=3.5);
