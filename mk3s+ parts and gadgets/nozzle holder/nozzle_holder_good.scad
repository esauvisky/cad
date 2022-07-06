include <threads.scad>;
// nozzle parameters

NOZZLES_04_ROWS = 3;

NOZZLES = [
    ".2",
    ".3",
    ".5",
    ".6",
    ".8",
    "1+",
];

NOZZLE_GROUP_SIZE = 4;

// distances

x_distance = 12;
y_distance = 12;

box = [
    (NOZZLE_GROUP_SIZE - 1) * x_distance + 20,
    (NOZZLES_04_ROWS + len(NOZZLES) - 2) * y_distance + 21,
    8
];

module box_frame() {
    difference() {
       union() {
            cube(box);
            translate([2.1, 2.1, box.z]) cube([box.x-3.7, box.y-3.7, 1.5]);
        }

        different_nozzles();

        translate([5, (len(NOZZLES) - 1) * y_distance + 10, 8])
            cube([NOZZLE_GROUP_SIZE * x_distance, 1, 2]);

        translate([1, (len(NOZZLES) - 1) * y_distance + 11, 0])
            nozzles_04();

        translate([1, box.y / 2 + 7, 6])
        rotate([90, 180, 0])
        linear_extrude(14)
        polygon([
            [0, 0], [-2, 1], [-1, 6], [0, 6]
        ]);
            // cube([4, 15, 7], true);

        translate([0, box.y / 2, 2])
            cube([4, 15, 20], true);

        translate([box.x - 1, 5.5, 6.5])
            cube([10, 9, 10]);

        translate([box.x - 1, box.y - 14.5, 6.5])
            cube([10, 9, 10]);
    }

    for (i = [0: len(NOZZLES)-1]) {
        translate([NOZZLE_GROUP_SIZE * x_distance + 1.5, 8.5 + (i * y_distance) * 0.9, 8.5])
            rotate([0, 0, -90])
            linear_extrude(2)
            translate([-1,-0.8,0])
            text(NOZZLES[i], size = 4, halign = "center", font = "Inconsolata: style=Bold", $fn=50);
    }

    translate([NOZZLE_GROUP_SIZE * x_distance + 1.5, (len(NOZZLES) - 1) * y_distance + 11 + (NOZZLES_04_ROWS -1 ) * y_distance / 2 + 5, 8.5])
        rotate([0, 0, -90])
        linear_extrude(2)
        translate([0,-0.8,0])
        text(".4", size = 4, halign = "center", font = "Inconsolata: style=Bold", $fn=50);
}

module different_nozzles() {
    for (i = [0: len(NOZZLES)-1]) {
        for (j = [0: NOZZLE_GROUP_SIZE-1]) {
            translate([9 + (j * x_distance)*0.9, 9 + (i * y_distance)*0.9, 2])
                // cylinder(10, 3.05, 3.05, $fn=50);
                metric_thread (6.8, 1, 10, internal=true, leadin=1, test=true);

            translate([9 + (j * x_distance)*0.9, 9 + (i * y_distance)*0.9, 2])
                %nozzle();
        }
    }
}

module nozzles_04() {
    for (i = [0: NOZZLES_04_ROWS-1]) {
        for (j = [0: NOZZLE_GROUP_SIZE-1]) {
            translate([8 + (j * x_distance)*0.9, 5 + (i * y_distance)*0.9, 2])
                // cylinder(10, 3.05, 3.05, $fn=50);
                metric_thread (6.8, 1, 10, internal=true, leadin=1, test=true);

            translate([8 + (j * x_distance)*0.9, 5 + (i * y_distance)*0.9, 2])
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
    translate([1, 0, -8])
        union () {
            difference() {
                cube([box.x, box.y, 8]);

                translate([2, 2, 1])
                cube([box.x - 4, box.y - 4, 10]);

                translate([-1, 7, 5])
                    cube([10, 6, 10]);

                translate([-1, box.y - 13, 5])
                    cube([10, 6, 10]);
            }

            translate([-1, 10, 8])
                hinge();

            translate([-1, box.y - 10, 8])
                hinge();
        }

    difference() {
        union() {
            translate([box.x, box.y / 2, 2])
                cube([2, 14, 10], true);

            translate([box.x , box.y / 2 + 7, 1])
                rotate([90, 0, 0])
                linear_extrude(14)
                polygon([
                    [0, 0], [-2, 1], [-1, 6], [0, 6]
                ]);
        }
        translate([box.x, box.y / 2, 2])
            cube([0.5, 14, 7], true);
    }
}

module hinge() {
    rotate([90, 0, 0])
        cylinder(7, 1.2, 1.2, $fn=50, center = true);

    translate([0, 2.5, 0])
    rotate([-90, 0, 180])
    difference() {
        linear_extrude(5)
        hull() {
            circle(2.8, $fn=50);

            translate([3, 4, 0])
                square([1, 1]);
        }

        translate([0, 0, -1])
        cylinder(8, 1.6, 1.6, $fn=50);

        translate([0, -1, -1])
        linear_extrude(8)
        polygon([[-1.25, 0], [0, -1.0], [1.25, 0]]);
    }


    translate([0, 3, 0])
    rotate([-90, 0, 0])
    linear_extrude(1)
    hull() {
        circle(1.4, $fn=50);

        translate([1, 0, 0])
            square([2, 1]);

        translate([1, 2, 0])
            square([1, 1]);
    }

    translate([0, -4, 0])
    rotate([-90, 0, 0])
    linear_extrude(1)
    hull() {
        circle(1.4, $fn=50);

        translate([1, 0, 0])
            square([2, 1]);

        translate([1, 2, 0])
            square([1, 1]);
    }
}

intersection() {
    union() {
        box_frame();


        translate([box.x + 1, 0, 8]) rotate([0, 0, 0])
            rotate([0, -0, 0])
            lid();
    }

    // cube([box.x, box.y / 2, 100]);
    // translate([60, 30, 0]) cube([25, 25, 100]);
    // translate([20, 0, 0]) cube([30, 25, 100]);

}

