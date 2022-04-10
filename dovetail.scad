//male_dovetail(max_width=11, min_width=5, depth=5, height=30, cutout_width=5, cutout_depth=3.5)
//This produces a male dovetail with the dimensions specified. The cutout_width and depth specify the dimensions of a cutout in the center of the dovetail that will hopefully provide some spring or flex to allow them to go together tightly.
//
//female_dovetail((max_width=11, min_width=5, depth=5, height=30, block_width=15, block_depth=9, clearance=0.25)
//This produces a block of the specified dimensions with a dovetail cut out of it with an added clearance on three sides.
//
//female_dovetail_negative(max_width=11, min_width=5, depth=5, height=30, clearance=0.25)
//This produces the negative of the above module so that you can subtract it from an object.


module female_dovetail_negative(max_width=11, min_width=5, depth=5, height=30, clearance=0.25) {
	union() {
		translate([0,-0.001,-0.05])
			dovetail_3d(max_width+clearance,min_width+clearance,depth,height+0.1);
			translate([-(max_width+clearance)/2, depth-0.002,-0.5])
				cube([max_width+clearance,clearance/2,height+1]);
	}
}

module female_dovetail(max_width=11, min_width=5, depth=5, height=30, block_width=15, block_depth=9, clearance=0.25) {
		difference() {
			translate([-block_width/2,0,0]) cube([block_width, block_depth, height]);
			female_dovetail_negative(max_width, min_width, depth, height, clearance);
		}
}

module male_dovetail(max_width=11, min_width=51, depth=5, height=30, cutout_width=5, cutout_depth=3.5) {
	difference() {
		dovetail_3d(max_width,min_width,depth,height);
		translate([0.001,depth+0.001,-0.05])
			dovetail_cutout(cutout_width, cutout_depth, height+0.1);
	}
}

module dovetail_3d(max_width=11, min_width=5, depth=5, height=30) {
	linear_extrude(height=height, convexity=2)
		dovetail_2d(max_width,min_width,depth);
}

module dovetail_2d(max_width=11, min_width=5, depth=5) {
	angle=atan((max_width/2-min_width/2)/depth);
	echo("angle: ", angle);
	polygon(paths=[[0,1,2,3,0]], points=[[-min_width/2,0], [-max_width/2,depth], [max_width/2, depth], [min_width/2,0]]);
}

module dovetail_cutout(width=5, depth=4, height=30) {
	translate([0,-depth+width/2,0])
		union() {
			translate([-width/2,0,0])
				cube([width,depth-width/2,height]);
			difference() {
				cylinder(r=width/2, h=height, $fs=0.25);
				translate([-width/2-0.05,0.05,-0.05]) cube([width+0.1,width+0.1,height+0.1]);
			}
		}
}