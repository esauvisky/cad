



/* [Part] */
part = "base"; // [base:Base,extension:Extension]

/* [Standard Sizes] */

// sizes for preset standard batteries. Chose custom if you want to create a new one.
battery = "85/90"; // [AA,AAA,AAAA,C,D,9v,18650]

/* [Custom Size] */

// the name of the battery, and the text that will appear on the face.
customLabel = "";

// the length of the battery in mm, including the positive nub.
customBatteryLength = 0;

// the diameter of the battery in mm. For rectangular, use the narrowest dimension.
customBatteryDiameter = 0;

batteries = [
    [ "AA", 52, 15 ],
    ["AAA", 45, 11],
    ["AAAA", 43, 9],
    ["C", 50, 26],
    ["D", 61, 34],
    ["9v", 48, 17],
    ["18650", 69, 19],
    ["10/20/30", 80, 15],
    ["50/70", 100, 15],
    ["85/90", 120, 15]
];

/*[Hidden]*/
$fn = 50;
useCustom = (customBatteryLength != 0 && customBatteryDiameter != 0);
index = search([battery], batteries, num_returns_per_match = 1);
standardValues = batteries[index[0]];
echo(standardValues);
label = "";
batteryLength = useCustom ? customBatteryLength : standardValues[1];
batteryDiameter = useCustom ? customBatteryDiameter : standardValues[2];

// constants
wallThickness = 2;
wallHeight = 110;
wallWidth = 60;
shelfWidth = 20;
slotWidth = 6;
shelfStopHeight = 15;
kickbackWidth = 0;
kickbackHeight = 10;
magnet_diameter = 6.5;
magnet_width = 1.15;

// draw model
translate([-batteryLength / 2, wallWidth / 2, 0]) rotate([0, 0, -90]) if (part == "base") {
    baseModel();
} else {
    extensionModel();
}

module baseModel() {
    difference() {
        sides();
        magnets("left");
        magnets("right");
    }
    back();
    shelf();
    curve();
    kickbacks();
    difference() {
        front();
        label();
    }
}

module magnets(side) {
    if (side == "left") {
        translate([wallWidth - slotWidth * 8, batteryLength + wallThickness - magnet_width / 3, wallHeight - slotWidth * 2])
            rotate([90, 0, 0]) cylinder(h = magnet_width, d = magnet_diameter, center = true);
        translate([wallWidth - slotWidth * 8, batteryLength + wallThickness - magnet_width / 3, wallHeight / 4 - slotWidth * 2])
            rotate([90, 0, 0]) cylinder(h = magnet_width, d = magnet_diameter, center = true);
        translate(
            [wallWidth - slotWidth * 2, batteryLength + wallThickness - magnet_width / 3, wallHeight - slotWidth * 2])
            rotate([90, 0, 0]) cylinder(h = magnet_width, d = magnet_diameter, center = true);
        translate([
            wallWidth - slotWidth * 2, batteryLength + wallThickness - magnet_width / 3, wallHeight / 4 - slotWidth * 2
        ]) rotate([90, 0, 0]) cylinder(h = magnet_width, d = magnet_diameter, center = true);
    } else {
        translate([wallWidth - slotWidth * 8, -wallThickness + magnet_width / 3, wallHeight - slotWidth * 2]) rotate([90, 0, 0])
            cylinder(h = magnet_width, d = magnet_diameter, center = true);
        translate([wallWidth - slotWidth * 8, -wallThickness + magnet_width / 3, wallHeight / 4 - slotWidth * 2])
            rotate([90, 0, 0]) cylinder(h = magnet_width, d = magnet_diameter, center = true);
        translate([wallWidth - slotWidth * 2, -wallThickness + magnet_width / 3, wallHeight - slotWidth * 2])
            rotate([90, 0, 0]) cylinder(h = magnet_width, d = magnet_diameter, center = true);
        translate([wallWidth - slotWidth * 2, -wallThickness + magnet_width / 3, wallHeight / 4 - slotWidth * 2])
            rotate([90, 0, 0]) cylinder(h = magnet_width, d = magnet_diameter, center = true);
    }
}

module extensionModel() {
    difference() {
        translate([0, -wallThickness, 0]) cube([wallWidth, batteryLength + wallThickness * 2, wallHeight]);

        translate([wallThickness, 0, -10]) cube([wallWidth - wallThickness * 2, batteryLength, wallHeight + 20]);

        slotCutout();
    }

    tabWidth = 10;
    translate([0, 0, wallHeight - tabWidth / 2]) tab();
    translate([0, batteryLength - tabWidth, wallHeight - tabWidth / 2]) tab();
    translate([wallWidth, 0, wallHeight - tabWidth / 2]) mirror([1, 0, 0]) tab();
    translate([wallWidth, batteryLength - tabWidth, wallHeight - tabWidth / 2]) mirror([1, 0, 0]) tab();
}

module tab() {
    tabWidth = 10;
    translate([wallThickness, 0, 0]) cube([wallThickness, tabWidth, tabWidth]);
    cube([wallThickness * 2, tabWidth, tabWidth / 2]);
}

module sides() {
    translate([0, -wallThickness, 0]) side();
    translate([0, batteryLength, 0]) side();
}

module side() {

    cutoutDiameter = shelfWidth * 2 / 3 + .5;
    bevel = 5;

    translate([0, wallThickness, 0]) rotate([90, 0, 0]) linear_extrude(height = wallThickness) offset(-bevel)
        offset(bevel) polygon([
            [ 0, 0 ],
                [0, wallHeight],
                [wallWidth, wallHeight],
                [wallWidth, batteryDiameter],
                [wallWidth + 10, shelfStopHeight - cutoutDiameter / 2 + 1],
                [wallWidth + shelfWidth - 4, shelfStopHeight - cutoutDiameter / 2 + 1],
                [wallWidth + shelfWidth, shelfStopHeight],
                [wallWidth + shelfWidth + wallThickness, shelfStopHeight],
                [wallWidth + shelfWidth + wallThickness, 0],
        ] );
}

module back() {
    cube([wallThickness, batteryLength, wallHeight]);
}

module front() {

    difference() {
        translate([wallWidth - wallThickness, 0, batteryDiameter + wallThickness])
            cube([wallThickness, batteryLength, wallHeight - batteryDiameter - wallThickness]);

        slotCutout();

        angleCutout();
    }
}

module slotCutout() {
    union() {
        translate([wallWidth, batteryLength / 2, wallHeight - slotWidth * 2]) rotate([0, 90, 0])
            cylinder(h = 10, d = slotWidth, center = true);

        translate([wallWidth - 5, batteryLength / 2 - slotWidth / 2, slotWidth])
            cube([10, slotWidth, wallHeight - slotWidth * 3]);

        translate([wallWidth, batteryLength / 2, slotWidth]) rotate([0, 90, 0])
            cylinder(h = 10, d = slotWidth, center = true);
    }
}

module angleCutout() {
    translate([wallWidth - wallThickness - 1, 0, batteryDiameter]) rotate([90, 0, 90])
        linear_extrude(height = wallThickness + 2) polygon([
            [ 0, 0 ],
                [0, wallThickness],
                [batteryLength / 2 - slotWidth / 2, batteryDiameter],
                [batteryLength / 2 + slotWidth / 2, batteryDiameter],
                [batteryLength, wallThickness],
                [batteryLength, 0],
        ] );
}

module shelf() {
    length = wallWidth + shelfWidth;

    // floor
    difference() {
        cube([length + wallThickness, batteryLength, wallThickness]);

        translate([length + wallThickness, batteryLength / 2, 0]) cylinder(h = 200, d = slotWidth, center = true);
    };

    // stops
    union() {
        // left
        translate([length, -wallThickness, 0]) shelfStop();
        ;

        // right
        translate([length, batteryLength + wallThickness, 0]) mirror([0, 1, 0]) shelfStop();
    }
}

module shelfStop() {

    width = batteryLength / 2 - slotWidth / 2 + wallThickness;
    bevel = wallThickness * 2;

    rotate([90, 0, 90]) linear_extrude(height = wallThickness) offset(bevel) offset(-bevel)
        square([width, shelfStopHeight]);

    cube([wallThickness, width, wallThickness * 2]);

    cube([wallThickness, wallThickness * 2, shelfStopHeight]);
}

module curve() {
    diameter = wallWidth * 2;

    difference() {

        cube([wallWidth, batteryLength, wallWidth]);

        translate([diameter / 2, -10, diameter / 2]) rotate([-90, 0, 0])
            cylinder(d = diameter, h = batteryLength + 20);
    }
}

module kickbacks() {
    kickback();

    translate([0, batteryLength, 0]) mirror([0, 1, 0]) kickback();
}

module kickback() {

    translate([-wallThickness, 0, wallThickness])
        polyhedron(points = [[wallWidth, 0, batteryDiameter], [wallWidth, 0, batteryDiameter + kickbackHeight],
            [wallWidth - 6, 0, batteryDiameter + kickbackHeight - 3],
            [wallWidth, kickbackWidth, batteryDiameter + kickbackHeight],
            [wallWidth - 6, kickbackWidth, batteryDiameter + kickbackHeight - 3],
        ],
            faces = [[0, 2, 1], [0, 1, 3], [1, 2, 4, 3], [0, 3, 4], [0, 4, 2]] );
}

module label() {
    #translate([wallWidth - wallThickness + 1, 2, wallHeight - 8 * 2])
        rotate([90, 0, 90]) linear_extrude(wallThickness + 1) text(label, direction = "ltr", size = 8);
}
