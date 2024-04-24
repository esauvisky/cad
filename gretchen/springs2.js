include <BOSL/constants.scad>;
include <BOSL/transforms.scad>;
include <BOSL/shapes.scad>;

// Spring parameters
diameter = 40; // Overall diameter of the spring
wire_diameter = 5; // Diameter of the spring wire
pitch = 10; // Distance between each turn
height = 100; // Height of the spring
turns = height / pitch; // Number of turns

// Helper function to create a helical path
function helix_path(turns, height, diameter, pitch) {
    return [
        for (t = [0 : 0.1 : turns])
            let (angle = 360 * t)
            let (z = height * t / turns)
            let (r = diameter / 2)
                rotate([0, 0, angle]) translate([r, 0, z]) [0, 0, 0]
    ];
}

spring_path = helix_path(turns, height, diameter, pitch);

// Rendering the spring
linear_extrude(path = spring_path, scale = 1, twist = 0) {
    circle(d = wire_diameter);
}
