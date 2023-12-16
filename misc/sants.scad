logo_text = "Sant's";
logo_height = 10;
font_name = "Poiret One";
recess_depth = 10;
block_thickness = recess_depth + logo_height;
block_width = 100; // Adjust as needed
block_height = 50; // Adjust as needed

module logo() {
    linear_extrude(height = logo_height)
    text(logo_text, font = str("font name = ", font_name, ";"), size = block_height * 0.8, halign = "center", valign = "center");
}

difference() {
    cube([block_width, block_height, block_thickness]);
    translate([block_width / 2, block_height / 2, recess_depth])
    logo();
}
