
difference() {
    // resize([150], auto = true) import("temp.stl");
    // translate([-63, 0, 0]) cube(70, center = true);
    // translate([63, 0, 0]) cube(70, center = true);
    difference() {
        cylinder(r = 50, h = 30, center = true);
        cylinder(r = 27.3, h = 30, center = true);
        cube(size = [5, 80, 30], center = true);
    }
}
