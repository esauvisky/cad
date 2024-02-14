
// IBM Model F Key Barrel
$fn = 150;
module key_barrel() {
    difference() {
        // Outer cylinder with base
        union() {
            difference() {

                union() {
                    translate([0, 0, 14 - 3]) cylinder(h = 3, d1 = 12.2, d2 = 11);
                    cylinder(h = 14 - 3, d = 12.2);
                }
                translate([-0.3, 0, 12]) cube([2, 15, 15], center = true);
            }
            translate([0, -4.2, -4.1 / 2]) // Slightly lower to merge with the cylinder
                cube([19, 20.6, 4.1], center = true);

        // notch at 300° of the cylinder
            t = 0.7;
            minkowski() {
                translate([5.2, -3.5, 1.2])
                    rotate([0, 0, 55])
                    cube([0.8 - t, 2 - t, 4 - t], center = true);
                sphere(r = t + 0.3);
            }
        }
        // Inner shaft
        translate([0, 0, -4.9])
            cylinder(h = 20.9, d = 9.35, $fn = 50); // +2 to ensure it cuts through completely



        // translate([0, -4.2, -4.1/2 - 3.38/2]) // Slightly lower to merge with the cylinder
        // cube([17.5, 19, 3.38], center=true);

        // translate([0, -20, -4.1/2 - 3.38/2]) // Slightly lower to merge with the cylinder
        // cube([13.7, 13.7, 3.38], center=true);
    }
}

// Render the key barrel
key_barrel();

// Note: This code assumes that the bottom of the barrel is flat and that the base is centered under the barrel.
// The $fn=50 parameter in the inner cylinder provides a smooth finish.
