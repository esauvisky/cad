
module compact_flash_slot() {
    difference() {
        // Negative space for card
        cube([42.8, 36.4, 3.3]);

        // Build positive space for pins and other features
        build_compact_flash_features();
    }
}

module build_compact_flash_features() {
    // Assume pins are 1mm by 0.5mm and spaced 1.27mm apart
    for(x = [0 : 1.27 : 41.61]) {
        for(y = [0 : 1.27 : 36.4 - 3.3]) {
            translate([x, y, 0])
            cube([1, 0.5, 3.3]);
        }
    }
}

compact_flash_slot();
