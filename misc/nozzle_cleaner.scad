// Parameters
$fn = 100; // Increase for smoother circles
main_cylinder_diameter = 25;
main_cylinder_height = 40; // Adjust height as needed
hole_diameter = 2;
hole_depth = 6;
inner_diameter = 22;
rounding = 2;

// Function to create holes around the circumference
module holes_around2(diameter, hole_diameter, hole_depth, inclination=30, num_holes=5, rotation_degrees=0) {
    rotate([0,0,rotation_degrees])
    for (i = [0 : num_holes - 1]) {
        // Calculate the angle for the current hole
        angle = 360 / num_holes * i;
        // Position the hole using polar coordinates
        translate([(diameter / 2 ) * cos(angle), (diameter / 2) * sin(angle), main_cylinder_height-hole_depth/2])
        // Rotate the hole to align with the tangent of the cylinder at the point of the hole
        rotate([sin(angle)*inclination,-cos(angle)*inclination])
        // Create the hole with the specified depth and diameter
        cylinder(h = hole_depth, d = hole_diameter, $fn = $fn);
    }
}

// Create holes around the border of the main cylinder's circumference
difference() {
    %minkowski() {
        cylinder(h = main_cylinder_height, d1 = main_cylinder_diameter * 0.8, d2 = main_cylinder_diameter + hole_diameter * 2);
        // sphere(r=rounding);
    }
    %translate([0,0,-rounding/2]) cube(size=[100, 100, rounding], center=true);

    union() {
        translate([0,0,rounding/3])
        #holes_around2(inner_diameter, hole_diameter, hole_depth, 30, 5, 0);
        angle_offset = 360 / (2 * 5); // Half the angle between holes in the first layer
        translate([0,0,rounding/3])
        #holes_around2(main_cylinder_diameter, hole_diameter, hole_depth, 15, 5, angle_offset);
    }
}
