include <BOSL2/std.scad>

// $fn = 25; // High detail for smoothness
$fn = 30; // Low detail for speed

// Parameters
diameter_handle_bottom = 8;   // Bottom diameter of the handle
diameter_handle_top = 10;     // Top diameter of the handle, where it meets the head
diameter_head_base = 13.5;    // Base diameter of the head
diameter_head_top = 13.5;     // Top diameter of the head (round part)
length_handle = 80;           // Length of the handle
length_head = 20;             // Length of the head (not including round top)
height_spherical_top = 5;    // Height of the spherical top

// Function to create a curved handle for ergonomic grip
module handle() {
    cyl(h = length_handle, d1 = diameter_handle_bottom, d2 = diameter_handle_top, anchor=DOWN);
}

// Create pestle head with smooth transition (fillets) to prevent stress concentrations
module head() {
    translate([0, 0, length_handle]) {
        // Cylinder for main head below the spherical top
        cylinder(h = length_head + 1, d1 = diameter_handle_top + 1, d2 = diameter_head_base);
        // Spherical top for efficient grinding
        translate([0, 0, length_head - 1])
        sphere(d = diameter_head_top);
    }
}

// Assemblage: Combine handle and head with smooth aesthetics
union() {
    handle();
    minkowski() {
        head();
        sphere(d = 0.5);
    }
}
