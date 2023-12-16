module opening(length, height) {
    mirror([0,1,0]) rotate([90, 0, 0]) linear_extrude(wall_outer_thickness) translate([0, wall_outer_thickness, 0]) minkowski() {
        polygon([[0, height / 5 - 1], [length / 2 - 1, (height - 1)], [length / 2 + 1, (height - 1)], [length, height / 5 - 1], [length / 2, 0]]);
        circle(1, $fn = 100);
    }
}

// difference() {
//     translate([0,0,20])
//     difference() {
//         cube(size = [58, 88, 30], center = true);
//         translate([0,0,2]) cube(size = [52, 82, 30], center = true);
//     }
//     translate([0, -35, 8])hole(50, 3);
// }

// 50 x 70
// 70 x 105
// 140 x 205

height = 16;
wall_outer_thickness = 2;
base_thickness = 1;

$fn = 20;
pin_diameter = 3;
pin_height = 3;
pin_hole_diameter = 3.5;
pin_hole_height = 10;
corner_outer_diameter = 6;
box_length = 140;
box_width = 205;
base_size = [box_length, box_width, height];

function corner_coords(i, j) = [i * box_length + (1 / 2 - i) * wall_outer_thickness, j *box_width + (1 / 2 - j) * wall_outer_thickness, 0];

module corner(i, j) {
    translate(corner_coords(i, j)) {
        cylinder(h = height, d = corner_outer_diameter);
        translate([0, 0, height]) {
            cylinder(h = pin_height, d = pin_diameter);
            translate([0, 0, pin_height]) sphere(d = pin_diameter);
        }
    }
}

module pin_hole(i, j) {
    translate(corner_coords(i, j)) translate([0, 0, -1]) cylinder(h = pin_hole_height + 1, d = pin_hole_diameter);
}

union() {
    difference() {
        union() {
            difference() {
                cube(base_size, center = false);
                translate([wall_outer_thickness, wall_outer_thickness, base_thickness])
                    cube(base_size - [wall_outer_thickness * 2, wall_outer_thickness * 2, 0]);
            }
            corner(0, 0);
            corner(0, 1);
            corner(1, 0);
            corner(1, 1);
        }
        pin_hole(0, 0);
        pin_hole(1, 0);
        pin_hole(0, 1);
        pin_hole(1, 1);

        translate([box_length*0.1,0,0]) opening(box_length * 0.8, height * 0.6);
    }
}

/*
inner_space = base_side - wall_outer_thickness*2 + wall_inner_thickness;
x_ofs = inner_space / slots_x;
y_ofs = inner_space / slots_y;
translate([wall_outer_thickness, 0, 0])
    for (i = [1:slots_x-1]) {
        translate([i*x_ofs - wall_inner_thickness, 0, 0])
            cube([wall_inner_thickness, base_side, height]);
    }

translate([0, wall_outer_thickness, 0])
    for (i = [1:slots_y-1]) {
        translate([0, i*y_ofs - wall_inner_thickness, 0])
            cube([base_side, wall_inner_thickness, height]);
    }
*/

translate([slot_x + wall_outer_thickness, 0, 0])
    cube([wall_inner_thickness, base_side, height]);

translate([0, slot_y + wall_outer_thickness, 0])
    cube([base_side, wall_inner_thickness, height]);

inner_space = base_side - wall_outer_thickness*2;
x_ofs = wall_outer_thickness + slot_x + wall_inner_thickness;
y_ofs = wall_outer_thickness + slot_y + wall_inner_thickness;
rest_x = base_side - x_ofs - wall_outer_thickness;
rest_y = base_side - y_ofs - wall_outer_thickness;

if (rest_walls_x > 0) {
    step_x = (slot_x + wall_inner_thickness) / (rest_walls_x+1);

    for (i = [1:rest_walls_x]) {
        translate([wall_outer_thickness + i*step_x - wall_inner_thickness, y_ofs, 0])
            cube([wall_inner_thickness, rest_y, height]);
    }
}

if (rest_walls_y > 0) {
    step_y = (slot_y + wall_inner_thickness) / (rest_walls_y+1);

    for (i = [1:rest_walls_y]) {
        translate([x_ofs, wall_outer_thickness + i*step_y - wall_inner_thickness, 0])
            cube([rest_x, wall_inner_thickness, height]);
    }
}








