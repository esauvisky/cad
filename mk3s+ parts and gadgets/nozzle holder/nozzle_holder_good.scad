include <threads.scad>;
// nozzle parameters

NOZZLES_04_ROWS = 1;

NOZZLES = [
    ".2",
    // ".3",
    // ".5",
    // ".6",
    // ".8",
    // "1+",
];

NOZZLE_GROUP_SIZE = 2;

// distances

x_distance = 12;
y_distance = 12;

volcano = 8;

box = [
    (NOZZLE_GROUP_SIZE - 1) * x_distance + 20,
    (NOZZLES_04_ROWS + len(NOZZLES) - 2) * y_distance + 23,
    8 + volcano
];

module box_frame() {
    difference() {
        union() {
            cube(box);
            translate([2, 2, box.z]) cube([box.x-4, box.y-4, 1.5]);
        }

        different_nozzles();

        // spacer
        // translate([4, (len(NOZZLES) - 1) * y_distance + 10 - 0.5, 8 + volcano])
        //     cube([NOZZLE_GROUP_SIZE * x_distance, 1, 2]);

        translate([1, (len(NOZZLES) - 1) * y_distance + 12, 0])
            nozzles_04();

        // snap latch
        // translate([1.1, box.y / 2 + 7, 6 + volcano])
        //     rotate([90, 180, 0])
        //     linear_extrude(14)
        //     polygon([[0, 0], [-2, 1], [-1, 6], [0, 6]]);
        // translate([0.1, box.y / 2, 2 + volcano])
        //     cube([4, 15, 12], true);

        translate([0, box.y / 2, 2 + volcano + 2])
            cube([4, 15, 8], true);

        // // hinge clearances
        // translate([box.x - 2, 5.5, 6.5 + volcano - 0.5])
        //     cube([12, 9, 10]);
        // translate([box.x - 2, box.y - 14.5, 6.5 + volcano - 0.5])
        //     cube([12, 9, 10]);
    }

    for (i = [0: len(NOZZLES)-1]) {
        translate([NOZZLE_GROUP_SIZE * x_distance + 1.5, 8.5 + (i * y_distance) * 0.9, 8.5 + volcano])
            rotate([0, 0, -90])
            linear_extrude(2)
            translate([-0.9,-0.8,0])
            text(NOZZLES[i], size = 4, halign = "center", font = "Inconsolata: style=Bold", $fn=100);
    }

    translate([NOZZLE_GROUP_SIZE * x_distance + 1.5, (len(NOZZLES) - 1) * y_distance + 11 + (NOZZLES_04_ROWS -1 ) * y_distance / 2 + 5, 8.5 + volcano])
        rotate([0, 0, -90])
        linear_extrude(2)
        translate([0,-0.8,0])
        text(".4", size = 4, halign = "center", font = "Inconsolata: style=Bold", $fn=100);
}

module different_nozzles() {
    for (i = [0: len(NOZZLES)-1]) {
        for (j = [0: NOZZLE_GROUP_SIZE-1]) {
            translate([9 + (j * x_distance), 9 + (i * y_distance), 2])
                // cylinder(10, 3.05, 3.05, $fn=100);
                metric_thread (6.8, 1, 10 + volcano, internal=true, leadin=1, test=true);

            // translate([9 + (j * x_distance), 9 + (i * y_distance), 2 + volcano])
            //     %nozzle();
        }
    }
}

module nozzles_04() {
    for (i = [0: NOZZLES_04_ROWS-1]) {
        for (j = [0: NOZZLE_GROUP_SIZE-1]) {
            translate([8 + (j * x_distance), 5 + (i * y_distance), 2])
                // cylinder(10, 3.05, 3.05, $fn=100);
                metric_thread (6.8, 1, 10 + volcano, internal=true, leadin=1, test=true);

            // translate([8 + (j * x_distance), 5 + (i * y_distance), 2 + volcano])
            //     %nozzle();
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
                cube([box.x, box.y, 11]);

                translate([2, 2, 2])
                cube([box.x - 4, box.y - 4, 9]);

                // translate([-1, 7, 5])
                //     cube([10, 6, 10]);

                // translate([-1, box.y - 13, 5])
                //     cube([10, 6, 10]);
            }

            // translate([-1, 10, 8])
            //     hinge();

            // translate([-1, box.y - 10, 8])
            //     hinge();
        }

    // difference() {
    //     union() {
    //         translate([box.x, box.y / 2, 2 + volcano])
    //             cube([2, 14, 10], true);

    //         translate([box.x , box.y / 2 + 7, 1 + volcano])
    //             rotate([90, 0, 0])
    //             linear_extrude(14)
    //             polygon([
    //                 [0, 0], [-2, 1], [-1, 6], [0, 6]
    //             ]);
    //     }
    //     translate([box.x, box.y / 2, 2 + volcano])
    //         cube([0.5, 14, 7], true);
    //     translate([box.x + 0.3, box.y / 2, 7 + volcano])
    //     rotate([90,0,0])
    //     cylinder(r=0.3, h=14, center=true, $fn=100);
    // }
}

module hinge() {
    rotate([90, 0, 0])
        cylinder(7, 1.2, 1.2, $fn=100, center = true);

    translate([0, 2.5, 0])
    rotate([-90, 0, 180])
    difference() {
        linear_extrude(5)
        hull() {
            circle(2.8, $fn=100);

            translate([3, 4, 0])
                square([1, 1]);
        }

        translate([0, 0, -1])
        cylinder(8, 1.6, 1.6, $fn=100);

        translate([0, -1, -1])
        linear_extrude(8)
        polygon([[-1.25, 0], [0, -1.0], [1.25, 0]]);
    }


    translate([0, 3, 0])
    rotate([-90, 0, 0])
    linear_extrude(1)
    hull() {
        circle(1.4, $fn=100);

        translate([1, 0, 0])
            square([2, 1]);

        translate([1, 2, 0])
            square([1, 1]);
    }

    translate([0, -4, 0])
    rotate([-90, 0, 0])
    linear_extrude(1)
    hull() {
        circle(1.4, $fn=100);

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

