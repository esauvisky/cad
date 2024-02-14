include <../libraries/BOSL/constants.scad>;
include <../libraries/threads.scad>;
include <../libraries/BOSL/shapes.scad>; // Make sure this path is correct for the roundcylinder module

// Parameters for the bumper
bumper_diameter = (3/5) * 2.54 * 10; // Diameter of the bumper
bumper_height = (7/16) * 2.54 * 10; // Height of the bumper without thread
thread_length = (3/8) * 2.54 * 10; // Length of the thread
roundness = 2;
$fn=200 ;
// Combine the bumper body and thread
module bumper_with_thread() {
    union() {
        translate([0, 0, bumper_height-roundness-5])
        english_thread(diameter=8/28, threads_per_inch=32, length=3/8, internal=false, n_starts=1);
            union() {
                minkowski() {
                    cylinder(d=bumper_diameter-roundness, h=bumper_height-roundness-5);
                    sphere(r=roundness/2);
                }
                difference() {
                    sphere(d=bumper_diameter);
                    translate([0,0,bumper_diameter/2]) cube(size=[bumper_diameter*3.14, bumper_diameter*3.14, bumper_diameter], center=true);
                }
        }
    }
};

// Render the bumper with thread
bumper_with_thread();
