n_rounds = 20;
dia = 4.6;
tol = 1;
height = 10;
pusher_length = 12;
$fn = 0;

module pick() {
    translate([5.2, 10, -dia / 2 - tol / 2])
        union() {
        translate([1, -2, dia / 2 - tol / 2])
            cube(size = [pusher_length * 2, dia / 2, 2], center = false);
        rotate([90, 0, 90])
            linear_extrude(height = 25)
            polygon([[0, 0], [0, dia + tol], [dia / 4, dia + tol - tol / 2], [dia / 2, dia + tol], [dia / 2, 0], [dia / 4, tol / 2]] );
    }
}
// #cube(size=[pusher_length, dia/2, dia+tol], center=false);

difference() {
    union() {
        translate([-2, 0, 0])
            linear_extrude(height = dia, center = true)
            polygon([[2, 15], [10, 18], [6, 6], [4, 2], [2, 2]] );
        translate([-pusher_length, 10, -(height) / 2])
            cube(size = [40, height, height], center = false);
        translate([-pusher_length, 8.5, -(dia) / 2])
            cube(size = [pusher_length, 1.5, dia], center = false);
    }
    translate([5, 0.4, -dia / 2 - tol / 2])
        cube(size = [dia + tol, 15 + dia / 2, dia + tol], center = false);
    translate([5, 10 + (height - dia) / 2 - (tol / 2), -dia / 2 - (tol / 2)])
        cube(size = [40 - 8, dia + tol, dia + tol], center = false);
    translate([21, 19, 0])
        cube(size = [40 - 8, 4, tol], center = true);
    minkowski() {
        pick();
        sphere(0.2);
    };
}

rotate([90,90,0])pick();

// difference() {
//     union() {
//         cylinder(r1 = dia / 2 + 0.5, r2 = 10 + 0.5, h = 10, center = false);
//         difference() {
//             // translate([0, 0, -height / 2])
//             //     linear_extrude(height = height, center = true) {
//             //     square(dia, scale = [dia, dia], center = true);
//             // }
//             translate([0, 0, -height / 2 + 2])
//                 // minkowski() {
//                 cube(size = [dia + 0.2, dia + 0.2, 4.5 + 0.2 + 2], center = true);
//                 // sphere(0.4);
//             // }
//             // cylinder(r = dia / 2 + 0.5, h = height / 2, center = true);
//             cylinder(r = dia / 2, h = 2 * height - (height / 2), center = true);
//             translate([0, 0, -height / 2]) rotate([-90, 0, 0]) cylinder(r = dia / 2, h = 2 * height, center = false);
//         }
//     }

//     cylinder(r1 = dia / 2 + 0.1, r2 = 5, h = 10, center = false);
// }

// // difference() {
// // // cone
// // }
