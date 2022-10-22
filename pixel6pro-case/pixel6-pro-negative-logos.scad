
// gets a logo
module logo() {
    // circle(r=9/2, $fn=6);
    resize([0, 8, 2], auto = true) linear_extrude(height = 1, center = true) {
        import("../misc/pokemod.svg", center = true);
    };
}

angle = rands(0, 180 + 50, 100,1879786769678696769897668686865567877866217541);
hex_length = 7;
for (i = [0:2]) {
    for (j = [0:10]) {
        rotate_by = angle[i * 10 + j];
        if (!((j % 2) && i == 2) && rotate_by > 50) {
            rotate_by = rotate_by - 50;
            translate([((3 / 2) * sqrt(2) * i * hex_length) + (j % 2) * (3 * sqrt(2) * hex_length / 2 / 2), ((sqrt(3)) * j * hex_length / 2), 0]) {
                rotate([0, 0, rotate_by]) {
                    logo();
                }
            }
        }
    }
}

