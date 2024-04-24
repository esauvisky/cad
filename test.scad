
box_length = 100;
box_width = 80;
box_height = 2;

hex_radius = 8;
gap = 10;


module logo() {
    resize([hex_radius], auto = true)
        import("./misc/pokemod.svg", center = true);
}

// Add parameters for dampening features
mount_thickness = 5; // Thickness of mounts or ribs for vibration dampening
grommet_diameter = 10; // Diameter of the grommets
grommet_height = 4; // Height of the grommets
module add_ribs(rib_width, rib_height, spacing) {
    num_ribs_x = floor((box_length - 2 * spacing) / (rib_width + spacing));
    num_ribs_y = floor((box_width - 2 * spacing) / (rib_width + spacing));

    // Horizontal ribs
    for (i = [0 : num_ribs_x - 1]) {
        translate([i * (rib_width + spacing) - box_length / 2, -box_width / 2, -rib_height])
        cube([rib_width, box_width, rib_height], center=false);
    }

    // Vertical ribs
    for (j = [0 : num_ribs_y - 1]) {
        translate([-box_length / 2, j * (rib_width + spacing) - box_width / 2, -rib_height])
        cube([box_length, rib_width, rib_height], center=false);
    }
}

// Example usage with a base
module base_with_ribs() {
    difference() {
        // Base plate
        cube([box_length, box_width, box_height], center=true);
        // Ribs
        add_ribs(5, 10, 20); // rib width, rib height, spacing
    }
}

// Use this module under your fan mount area
module enhanced_base_with_honeycomb() {
    difference() {
        // Base plate
        cube([box_length, box_width, box_height], center=true);
        // Honeycomb structure
        honeycomb_structure(10, 15, 2); // layer height, cell diameter, wall thickness
        // Add other features as necessary
    }
}

// difference() {
//     enha([ box_length, box_width, box_height ], center = true);

//     for (x = [-box_length / 2:gap:box_length / 2]) {
//         for (y = [-box_width / 2:gap:box_width / 2]) {
//             translate([ x, y, - box_height/2 ])
//                 linear_extrude(height = box_height + 0.1)
//                     logo();
//         }
//     }
// }
module soft_mounts(diameter, depth) {
    // Determine spacing and layout based on the object size and fan mount
    spacing_x = box_length / 4;
    spacing_y = box_width / 4;

    for (x = [-spacing_x, spacing_x]) {
        for (y = [-spacing_y, spacing_y]) {
            translate([x, y, -depth])
            cylinder(h=depth, d=diameter, center=false);
        }
    }
}

// Incorporating soft mounts into the design
module base_with_soft_mounts() {
    difference() {
        // Base plate
        cube([box_length, box_width, box_height], center=true);
        // Soft mounting points
        soft_mounts(10, 5); // diameter, depth
    }
}base_with_soft_mounts();
