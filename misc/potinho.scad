height = 100;

// Outer vertices for the larger polygon
outer_vertices = [
[60,40],
[70,20],
[80,40],
[120,40],
[90,130],
[70,90],
[30,70],
[50,70],
[30,60],
[40,50],
[40,40]
];

// Inner vertices for the smaller polygon, scaled down version of the outer
inner_vertices = scale(0.8, outer_vertices); // Scaled by 80%

// Function to create the outer shape
module outerShape() {
    linear_extrude(height = height) {
        polygon(outer_vertices);
    }
}

// Function to create the inner hollow space
module innerShape() {
    linear_extrude(height = height) {
        polygon(inner_vertices);
    }
}

// Create the hollow vial
difference() {
    outerShape();
    translate([0, 0, 1]) innerShape(); // Slightly raise the inner shape for better subtraction
}
