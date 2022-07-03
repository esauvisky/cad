height = 27;
border = 2.5;
tolerance = 0.5;

glass_x = 80 + tolerance * 3;
glass_y = 83 + tolerance * 3;
glass_z = 4;

pcb_z = 1.6 + tolerance;

button_hole_z = 14;
button_hole_x = 18;
// button_height = 22

battery_dia = 16;
battery_len = 34;
battery_con = 15;

module battery_compartment() {
    translate([(glass_x + 2 * border) / 2- battery_dia, (glass_y + 3 * border) / 2 - battery_len / 2, - height / 2 + battery_dia / 2 + tolerance * 3]) {
        rotate([90]) {
            cylinder(r = battery_dia / 2, h = 34 * 2 + battery_con, center = true);
        }
    }
}

difference() {
    cube(size = [glass_x + 2.5 * border, glass_y + 3 * border, height], center = true);
    translate([0, 0, height / 2 - tolerance * 3 / 2]) {
        // glass fit1
        cube(size = [glass_x - tolerance * 7, glass_y - tolerance * 7, glass_z], center = true);
    }
    translate([0,-border, height / 2 - glass_z / 2 - tolerance * 3 - 0.1]) {
        // glass hole
        linear_extrude(height=glass_z, center=true) {
            polygon(points=[
                [- (glass_x) / 2,       - (glass_y + border * 2) / 2],
                [- (glass_x) / 2,       + (glass_y + border * 2) / 2],
                [+ (glass_x) / 2 - 0.7, + (glass_y + border * 2) / 2],
                [+ (glass_x) / 2 - 2.5, - (glass_y + border * 2) / 2]],
                paths=[[0,1,2,3]]
            );
        }
        // cube(size = [glass_x, glass_y + border * 2, glass_z], center = true);
    }
    translate([0, -border / 2, height / 2 - glass_z - (pcb_z / 2)  - tolerance * 3]) {
        // pcb hole
        cube(size = [glass_x + border, glass_y + border * 2, pcb_z], center = true);
    }
    battery_compartment();
}

