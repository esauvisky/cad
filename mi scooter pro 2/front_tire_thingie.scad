// Parameters
outer_diameter = 14;
inner_diameter = 9;
height = 12;
sphere_diameter = 3000; // Fixed sphere size
sphere_offset = 100;
chamfer_radius = 0.5; // Radius of the chamfer (torus)

include <BOSL/shapes.scad>
$fn = 200;

module chamfered_cylinder_with_torus()
{
	// Outer cylinder
	difference()
	{
        translate([ 0, 0, height / 2 - 7 ])
        union() {
            translate([ 0, 0, - height / 2 + 3 ])
		    cyl(d1 = outer_diameter - 4, d2 = outer_diameter, h = height - 5, center = true);
            translate([ 0, 0, - 5 / 2 + 5 ])
		    cyl(d = outer_diameter, h = 4, center = true);
        }
		cyl(d = inner_diameter, h = height + 5, center = true);

		rotate([ -2, 0, 0 ])
		translate([ 0, 0, height / 4 - 0.3 ])
		torus(r = inner_diameter / 2, r2 = chamfer_radius * 2);

        // translate([0,0,-height/2])
		// torus(r = inner_diameter / 2, r2 = chamfer_radius);
	}
}

intersection()
{
	// Translate the sphere to intersect with the cylinder slightly
	// translate([ 0, -sphere_offset, 0 ])
	// translate([ 0, 0, -sphere_diameter / 2 + height / 2 ])
	// sphere(d = sphere_diameter);
	chamfered_cylinder_with_torus();
}
