width = 1.2 * 3;
size = 80;
height = 30;
magnet_dia = 3;
magnet_width = 2;
number_of_magnets = 3;

module magnets(wall) {
    if (wall == "primary") {
        for (i = [0:number_of_magnets - 1]) {
            translate([size + width - magnet_width, width / 2, height * ((i + 1) / (number_of_magnets + 1))]) {
                rotate([0, 90, 0]) cylinder(r = magnet_dia / 2, h = magnet_width, $fn = 50);
            }
        }
        for (i = [0:number_of_magnets - 1]) {
            translate([width / 2 + magnet_width, size + width, height * ((i + 1) / (number_of_magnets + 1))]) {
                rotate([90, 0, 0]) cylinder(r = magnet_dia / 2, h = magnet_width, $fn = 50);
            }
        }
    } else {
        for (i = [0:number_of_magnets - 1]) {
            translate([size + width, width / 2, height * ((i + 1) / (number_of_magnets + 1))]) {
                rotate([0, 90, 0]) cylinder(r = magnet_dia / 2, h = magnet_width, $fn = 50);
            }
        }
        for (i = [0:number_of_magnets - 1]) {
            translate([width / 2, size + width + magnet_width, height * ((i + 1) / (number_of_magnets + 1))]) {
                rotate([90, 0, 0]) cylinder(r = magnet_dia / 2, h = magnet_width, $fn = 50);
            }
        }
    }
}

module slot(wall) {
    if (wall == "primary") {
        // todo
    } else {
        translate([size + width, 0, 0]) {
            cube(size = [width / 2, width / 2, height]);
            translate([width / 4, - width / 2, 0]) cube(size = [width / 2, width * 3 / 2, height]);
        }
        translate([width / 2, size + width, 0]) {
            rotate([0, 0, 90]) {
                cube(size = [width / 2, width / 2, height]);
                translate([width / 4, - width / 2, 0]) cube(size = [width / 2, width * 3 / 2, height]);
            }
        }
    }
}

module primary_wall() {
    difference() {
        union() {
            cube(size = [width, size + width, height]);
            translate([0, width, 0]) rotate([0, 0, 270]) cube(size = [width, size + width, height]);
        }
        slot("primary");
        // magnets("primary");
    }
}
module secondary_wall() {
    difference() {
        translate([size + width * 2, size + width * 2, 0]) rotate([0, 0, 180]) {
            cube(size = [width, size + width * 3, height]);
            translate([0, width, 0]) rotate([0, 0, 270]) cube(size = [width, size + width * 3, height]);
        }
        slot("secondary");
        // magnets("secondary");
    }
}
// primary_wall();
secondary_wall();





