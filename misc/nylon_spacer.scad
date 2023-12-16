use <BOSL/threading.scad>;

$fn = 60;

// Parameters
outer_flat_to_flat = 5; // Outer flat-to-flat distance of the spacer
inner_diameter = 2.7;   // Inner diameter of the spacer (M2.5 size)
height = 15;            // Height of the spacer
thread_height = 5;      // Height of the thread on both ends

fix_tolerance = 0.0001;

// Hexagonal points calculation
outer_radius = outer_flat_to_flat / sqrt(3);
inner_radius = inner_diameter / 2;
hexagon_points_outer = [for (i = [0:5]) [cos(60*i)*outer_radius, sin(60*i)*outer_radius]];
hexagon_points_inner = [for (i = [0:5]) [cos(60*i)*inner_radius, sin(60*i)*inner_radius]];

// Outer Hexagonal Cylinder with Screw Threads
difference() {
    linear_extrude(height) {
        polygon(hexagon_points_outer);
    }

    // Adding inner M2.5 threads
    translate([0, 0, thread_height / 2 - fix_tolerance]) {
        threaded_rod(d=inner_diameter, l=thread_height, pitch=0.45, internal=true);
    }
}


// Adding external M2.5 threads at the end
translate([0, 0, height + thread_height / 2]) {
    threaded_rod(d=inner_diameter, l=thread_height, pitch=0.45);
}
