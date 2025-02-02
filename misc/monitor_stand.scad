module monitor_riser(width = 400, depth = 250, height = 100, leg_width = 50, leg_thickness = 20) {
  // Main top surface
  difference() {
    cube([width, depth, leg_thickness]);

    // Create a thin rectangular cutout for the main top
    translate([leg_thickness, leg_thickness, -1])
    cube([width - (2* leg_thickness), depth - (2* leg_thickness), leg_thickness + 2]);


  }
  // Left Leg
  translate([leg_thickness, 0, 0])
    cube([leg_width, depth, height]);

   // Right Leg
  translate([width - (leg_thickness + leg_width), 0, 0])
    cube([leg_width, depth, height]);

}

monitor_riser();
