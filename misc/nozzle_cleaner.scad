// add the threads BOSL lib
include <BOSL2/std.scad>

// Parameters
$fn = 100; // Increase for smoother circles
main_cylinder_diameter = 25;
main_cylinder_height = 40; // Adjust height as needed
hole_diameter = 3;
number_holes = 5;
hole_depth = 6;
inner_diameter = 15;
rounding = 2;

// Function to create holes around the circumference
module bristle_holes(diameter, hole_diameter, hole_depth, num_holes=5, inclination_angle=45) {
    translate([0,0,main_cylinder_height])
    for (i = [0 : num_holes - 1]) {
        // Calculate the angle for the current hole
        angle = 360 / num_holes * i;
        // Position the hole using polar coordinates
        // Rotate the hole to align with the tangent of the cylinder at the point of the hole
        translate([diameter / 2 * cos(angle), diameter / 2 * sin(angle),  hole_depth / 2 * sin(inclination_angle)])
        // and incline towards the center
        rotate([0, 0, angle])
        rotate([0, -inclination_angle, 0])
        // Create the hole with the specified depth and diameter
        difference() {
            cylinder(h = hole_depth, d = hole_diameter, center=true);
            cube([0.5, hole_diameter, hole_depth], center=true);
        }
    }
}


// Create holes around the border of the main cylinder's circumference
difference() {
    cyl(h = main_cylinder_height, d1 = main_cylinder_diameter + hole_diameter * 2, d2 = main_cylinder_diameter + hole_diameter * 2, chamfer2 = 2, anchor=[0,0,-1]);
    translate([0,0,-rounding/2]) cube(size=[100, 100, rounding], center=true);

    union() {
        #bristle_holes(inner_diameter, hole_diameter, hole_depth, number_holes, 45);
        rotate([0,0,360 / (2 * number_holes)]) // Half the angle between holes in the first layer, so they are not in line with the previous layer
        #bristle_holes(main_cylinder_diameter, hole_diameter, hole_depth, number_holes, 25);
    }
}
