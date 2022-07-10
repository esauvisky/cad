include <threads.scad>;
NOZZLES_04_ROWS = 4;

NOZZLES = [
    ".2",
    ".3",
    ".5",
    ".6",
    ".8",
];

NOZZLE_GROUP_SIZE = 3;

x_distance = 9;
y_distance = 9;

box = [
    (NOZZLE_GROUP_SIZE - 1) * x_distance + 16,
    (NOZZLES_04_ROWS + len(NOZZLES) - 2) * y_distance + 21,
    18
];

module box_frame() {
    difference() {
        union() {
            cube(box);
            translate([1.1, 1.1, box.z]) cube([box.x-2.2, box.y-2.2, 1]);
        }

        different_nozzles();

        translate([3, (len(NOZZLES) - 1) * y_distance + 10, 18])
            cube([NOZZLE_GROUP_SIZE * x_distance, 1, 2]);

        translate([0, (len(NOZZLES) - 1) * y_distance + 11, 10])
            nozzles_04();

        translate([0, box.y / 2, 12])
            cube([4, 15, 7], true);

        translate([0, box.y / 2, 12])
            cube([2, 15, 20], true);
    }

    for (i = [0: len(NOZZLES)-1]) {
        translate([5.5, 5 + i * y_distance, 17.5])
            rotate([0, 0, 90])
            linear_extrude(2)
            text(NOZZLES[i], size = 4, halign = "center", font = "Arial: style=Bold", $fn=50);
    }

    translate([5.5, (len(NOZZLES) - 1) * y_distance + 11 + (NOZZLES_04_ROWS -1 ) * y_distance / 2 + 5, 17.5])
        rotate([0, 0, 90])
        linear_extrude(2)
        text(".4", size = 4, halign = "center", font = "Arial: style=Bold", $fn=50);
}

module different_nozzles() {
    for (i = [0: len(NOZZLES)-1]) {
        for (j = [0: NOZZLE_GROUP_SIZE-1]) {
            translate([10 + j * x_distance, 5 + i * y_distance, 2])
                union() {
                    cylinder(20, 3, 3, $fn=50);
                    metric_thread (6.2, 1, 21, internal=true, test=true);
                }

            translate([10 + j * x_distance, 5 + i * y_distance, 12])
                %nozzle();
        }
    }
}

module nozzles_04() {
    for (i = [0: NOZZLES_04_ROWS-1]) {
        for (j = [0: NOZZLE_GROUP_SIZE-1]) {
            translate([10 + j * x_distance, 5 + i * y_distance, 2])
                cylinder(10, 3, 3, $fn=50);

            translate([10 + j * x_distance, 5 + i * y_distance, 2])
                %nozzle();
        }
    }
}


module nozzle() {
    cylinder(7.3, 3, 3, $fn=100);

    translate([0, 0, 7.3])
        cylinder(3, 4, 4, $fn=6);

    translate([0, 0, 10.3])
        cylinder(2.2, 2.6, 0.7, $fn=100);
}

module lid() {
    translate([4, 0, 2])
        union () {
            difference() {
                cube([box.x, box.y, 8]);

                translate([1, 1, 1])
                cube([box.x - 2, box.y - 2, 10]);
            }

            translate([-4, 10, 8])
                hinge();

            translate([-4, box.y - 10, 8])
                hinge();
        }

    translate([box.x + 3.5, box.y / 2, 2])
        cube([1, 14, 10], true);

    translate([box.x + 4, box.y / 2 + 7, 2])
        rotate([90, 0, 0])
        linear_extrude(14)
        polygon([
            [0, 0], [-2, 1], [-1, 6], [0, 6]
        ]);
}

module hinge() {
    rotate([90, 0, 0])
        cylinder(7, 1.4, 1.4, $fn=50, center = true);

    translate([0, 2.5, 0])
    rotate([-90, 0, 180])
    difference() {
        linear_extrude(5)
        hull() {
            circle(3.5, $fn=50);

            translate([5, 4, 0])
                square([1, 1]);

            translate([4, 7, 0])
                square([1, 1]);
        }

        translate([0, 0, -1])
        cylinder(8, 1.7, 1.7, $fn=50);

        translate([0, -1, -1])
        linear_extrude(8)
        polygon([[-1.4, 0], [0, -1.2], [1.4, 0]]);
    }


    translate([0, 3, 0])
    rotate([-90, 0, 0])
    linear_extrude(1)
    hull() {
        circle(1.4, $fn=50);

        translate([4, 1, 0])
            square([1, 1]);

        translate([4, 5, 0])
            square([1, 1]);
    }

    translate([0, -4, 0])
    rotate([-90, 0, 0])
    linear_extrude(1)
    hull() {
        circle(1.4, $fn=50);

        translate([4, 1, 0])
            square([1, 1]);

        translate([4, 5, 0])
            square([1, 1]);
    }
}

intersection() {
    union() {
        box_frame();

        translate([box.x + 4, 0, 8])
            rotate([0, -0, 0])
            lid();
    }

//    cube([box.x, box.y / 2, 100]);
    // translate([60, 30, 0]) cube([25, 25, 100]);
        // translate([28, 0, 0]) cube([20, 25, 100]);

}

