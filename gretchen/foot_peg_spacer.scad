include <bosl/shapes.scad>;


$fn=100;
difference()
{
    union()
    {
        cyl(h = 32, d = 34);

        difference()
        {
            union()
            {
                translate([ 0, 26, 0 ]) cuboid([ 9, 40, 32 ], chamfer = 2, edges=EDGES_BACK, center = true);
                translate([ -6, 36, 0 ]) tube(h = 3, od1 = 10, od2 = 14, id = 10, orient = ORIENT_X, center = true);
                translate([ 6, 36, 0 ]) tube(h = 3, od1 = 14, od2 = 10, id = 10, orient = ORIENT_X, center = true);
            }
            translate([ 0, 36, 0 ]) cyl(h = 20, d = 10, orient = ORIENT_X, center = true);
        }
    }

    intersection()
    {
        translate([ 6, 0, 0 ]) cyl(h = 32, d = 36);
        translate([ -6, 0, 0 ]) cyl(h = 32, d = 36);
    }
}
