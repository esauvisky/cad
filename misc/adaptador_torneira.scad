include <bosl/threading.scad>;
include <BOSL/constants.scad>;
metric_inner_diameter = 21.6; // mm
metric_pitch = 2.1176; // mm

// Imperial thread specifications (e.g., 3/4 inch external thread)
imperial_outer_diameter = 19; // mm (3/4 inch)
imperial_pitch = 1; // mm (12 threads per inch)

// Adapter specifications
adapter_length = 10; // mm
wall_thickness = 2; // mm


$fn=100;

module adapter(metric_d, metric_pitch, imperial_d, outer_pitch, length, wall) {
    difference() {
        // External part with imperial thread
        trapezoidal_threaded_rod(d=imperial_d + 2 * wall, l=length, pitch=outer_pitch,
                                 thread_depth=outer_pitch/2, thread_angle=14.5);

        // Internal space with metric thread
        translate([0, 0, -0.99])
        trapezoidal_threaded_rod(d=metric_d, l=length + 2, pitch=metric_pitch,
                                 thread_depth=metric_pitch/2, thread_angle=15);
    }
}

// Render the adapter
adapter(metric_inner_diameter, metric_pitch, imperial_outer_diameter, imperial_pitch, adapter_length, wall_thickness + 2);

translate([0,0,7]) adapter(metric_inner_diameter-3, metric_pitch, imperial_outer_diameter-3, imperial_pitch, adapter_length-3, wall_thickness + 2);
