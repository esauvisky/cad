// turbine earrings
WIDTH = 0.6;
HEIGHT = 4;
SPHERE_RES=50;
MAIN_RES=50;
SCALE=1;

// rotate([ 0, 0, 120 ]) turbine(r = 6, Router = 4, Rinner = 10, phi = 25, s = 0.6, top = 3);
// rotate([ 0, 0, 60 ]) turbine(r = 9, Router = 7, Rinner = 4, phi = 18, s = 0.55, top = 3);
// difference()
// {
//     turbine(r = 12, Router = 15, Rinner = 7, phi = 10, s = 0.5, top = 13.3);
//     translate([ 0, 12, 0 ]) rotate([ 0, 0, 0 ]) cylinder(r = 0.4, h = 5, center = true, $fn = 8);
// }


rotate([ 0, 0, 120 ]) turbine(r = 6 * SCALE, Router = 4 * SCALE, Rinner = 10 * SCALE, phi = 25, s = 0.6, top = 3 * SCALE);
rotate([ 0, 0, 60 ]) turbine(r = 9 * SCALE, Router = 7 * SCALE, Rinner = 4 * SCALE, phi = 18, s = 0.55, top = 3 * SCALE);
difference()
{
    turbine(r = 12 * SCALE, Router = 15 * SCALE, Rinner = 7 * SCALE, phi = 10, s = 0.5, top = 13.3 * SCALE);
    translate([ 0, 12 * SCALE, 0 ]) rotate([ 0, 0, 0 ]) cylinder(r = 0.4 * SCALE, h = 5 * SCALE, center = true, $fn = 8);
}

module turbine(r, Router, Rinner, phi, s, top) difference()
{
    intersection()
    {
        union()
        {
            rotate([ 0, -phi, 0 ]) scale([ 1.1, 1, s ]) sphere(r = r, $fn = SPHERE_RES);
            translate([ 0, top, 0 ]) rotate([ 90, 0, 0 ]) cylinder(r1 = 0, r2 = HEIGHT / 2, h = HEIGHT / 2, $fn = MAIN_RES);
        }
        cube([ 3 * r, 3 * r, HEIGHT ], center = true);
    }
    difference()
    {
        rotate([ 0, -phi, 0 ]) scale([ 1.1, 1, s ]) sphere(r = r - WIDTH, $fn = SPHERE_RES);
        translate([ 0, Router - WIDTH, 0 ]) rotate([ -90, 0, 0 ]) cylinder(r1 = 0, r2 = 1.5 * HEIGHT, h = HEIGHT, $fn = MAIN_RES);
        translate([ 0, -Router + WIDTH, 0 ]) rotate([ 90, 0, 0 ]) cylinder(r1 = 0, r2 = 1.5 * HEIGHT, h = HEIGHT, $fn = MAIN_RES);
        rotate([ 0, 0, 60 ]) translate([ 0, Rinner, 0 ]) rotate([ -90, 0, 0 ])
            cylinder(r1 = 0, r2 = 2 * HEIGHT, h = 2 * HEIGHT, $fn = MAIN_RES);
        rotate([ 0, 0, -120 ]) translate([ 0, Rinner, 0 ]) rotate([ -90, 0, 0 ])
            cylinder(r1 = 0, r2 = 2 * HEIGHT, h = 2 * HEIGHT, $fn = MAIN_RES);
    }
    translate([ 0, top - WIDTH, 0 ]) rotate([ 90, 0, 0 ]) cylinder(r1 = 0, r2 = HEIGHT / 2, h = HEIGHT / 2, $fn = MAIN_RES);
    translate([ 0, Router, 0 ]) rotate([ -90, 0, 0 ]) cylinder(r1 = 0, r2 = 1.5 * HEIGHT, h = HEIGHT, $fn = MAIN_RES);
    translate([ 0, -Router, 0 ]) rotate([ 90, 0, 0 ]) cylinder(r1 = 0, r2 = 1.5 * HEIGHT, h = HEIGHT, $fn = MAIN_RES);
    rotate([ 0, 0, 60 ]) translate([ 0, Rinner + WIDTH, 0 ]) rotate([ -90, 0, 0 ])
        cylinder(r1 = 0, r2 = 2 * HEIGHT, h = 2 * HEIGHT, $fn = MAIN_RES);
    rotate([ 0, 0, -120 ]) translate([ 0, Rinner + WIDTH, 0 ]) rotate([ -90, 0, 0 ])
        cylinder(r1 = 0, r2 = 2 * HEIGHT, h = 2 * HEIGHT, $fn = MAIN_RES);
}
