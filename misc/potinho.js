// Define the vertices of the top shape
vertices = [
    [10, 0], [7, 7], [0, 10], [-7, 7], [-10, 0], [-7, -7], [0, -10], [7, -7]
];

// Define the top shape using the polygon function
module topShape() {
    polygon(vertices);
}

// Create the 3D model of the vial
module createVial(height, taper) {
    linear_extrude(height = height, scale = taper) {
        topShape();
    }
}

// Call the module with specific dimensions
createVial(50, 0.5);  // 50 mm tall, tapering to 50% of the original width at the bottom
