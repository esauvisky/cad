/*
teselaciÃ³n hexagonal
gridHex1
100hex https://tecnoloxia.org/100hex/
CC By-SA
*/

/* visualizaciÃ³n
------------------------
*/

/*
forms:
0:hexagons, 1:cubes, 2:triangles, 3:squares random,
4:triangles random, 5:asahona, 6:soles, 7:petals,
8:flowers 1, 9:flowers 2, 10:superimposed circles,
11:flowers 3, 12: chainmail, 13: pajarita nazare, 14: trapezoids,
15: estrelas-cubes, 16: Francois stone mosaic, 17: entrelazado,
18:flowers 3,19:flowers 4, 20:superimposed rectangles,
21: circles1, 22: circles2, 23: circles3,
24: stars and hexagons 1, 25: stars and hexagons 2,
26: stars and hexagons 3, 27: stars and hexagons 4,
28: circles e triangles, 29: estrelas e squares,
30: cubes2, 31: waves1, 32: waves2, 33: aspas

n must be even for forms 5, 6, 8, 9, 11, 12, 13
*/

module test(from, to) {
    for (i = [from:to]) {
        // if (i != 9) {
            translate([(i - from) * hex * 2 + hex / 2, hex * 2, 0]) text(str(i), font = "helvetica:style=Bold", size = 20, center = true);
            translate([(i - from) * hex * 2, 0, 0]) grid(i, 4, 4, 4);
        // }
    }
}
// test(0, 4);

// tesela(8, 4);
// grid(2, 4);
// hexagon(2,4);

res = 50;  // resolution
w = 7.5;   // spacing
h = 2;     // height
hex = 75;  // width
bordo = 1; // depth

module tesela(forma, n = 4) {
    // TODO: don't repeat me repeat me
    f = (forma == 5 || forma == 6 || forma == 8 || forma == 9 || forma == 11 || forma == 12 || forma == 13 || forma == 14 || forma == 15 || forma == 16 ||
         forma == 17 || forma == 18 || forma == 19 || forma == 20 || forma == 21 || forma == 22 || forma == 23 || forma == 24 || forma == 25 || forma == 26 ||
         forma == 27 || forma == 29 || forma == 30)
            ? 1
            : 0;
    nt = f == 1 && n % 2 == 1 ? n + 1 : n;
    d = n == 0 ? 0 : f == 1 ? (2 * hex - w / cos(30)) / nt : (2 * hex * cos(30) - w) / nt;
    d1 = d / cos(30);
    r = d / 2;
    r1 = r / cos(30);
    r2 = (r + w / 2) / cos(30);
    r3 = (r - w / 2) / cos(30);
    x = f == 1 ? 0 : (-hex * cos(30) + w / 2);
    y = -nt * (r)*2 * cos(30);

    // hexágonos
    if (forma == 0) {
        difference() {
            circle(r = r3, $fn = 6);
        }
    }

    // cubes
    if (forma == 1) {
        difference() {
            circle(r = r3, $fn = 6);
            for (i = [0:120:360])
                rotate(i + 30) translate([0, r, 0]) square([w, d], center = true);
        }
    }

    // triangles
    if (forma == 2) {
        difference() {
            circle(r = r3, $fn = 6);
            for (i = [0:60:360])
                rotate(i + 30) translate([0, r, 0]) square([w, d], center = true);
        }
    }

    // squares random

    if (forma == 3) {
        xiro = (round(rands(-0, 12, 1)[0]));
        rotate(xiro * 15) circle(r = r - w / 2, $fn = 3);
    }

    // triangles random

    if (forma == 4) {
        xiro = (round(rands(-0, 12, 1)[0]));
        rotate(xiro * 15) circle(r = r - w / 2, $fn = 4);
    }

    // asahona

    if (forma == 5) {
        difference() {
            circle(r = r1 + 0.01, $fn = 6);
            for (i = [0:30:360])
                rotate(i + 30) square([w, d1], center = true);
        }
    }

    // soles

    if (forma == 6) {
        difference() {
            circle(r = r1 + 0.01, $fn = 6);
            rotate(120) for (i = [0:15:360]) rotate(i + 30) translate([0, r, 0]) square([w, 2 * (d + w)], center = true);
        }
    }

    // petals
    if (forma == 7) {
        rotate(15) for (i = [0:60:360]) rotate(i + 32) intersection() {
            translate([-d / 7, d / 3, 0]) circle(r = d / 4, $fn = res);
            translate([d / 7, d / 3, 0]) circle(r = d / 4, $fn = res);
        }
    }

    // flower 1
    if (forma == 8) {
        difference() {
            circle(r = r2, $fn = 6);
            for (i = [0:60:360]) {
                translate([d * sin(i), d * cos(i), 0]) difference() {
                    circle(r = d + w / 2, $fn = res);
                    circle(r = d - w / 2, $fn = res);
                }
            }
        }
    }

    // flower 2
    if (forma == 9) {
        difference() {
            circle(r = r2, $fn = 6);
            for (i = [0:60:360]) {
                rotate(i) intersection() {
                    translate([d * sin(0), d * cos(0), 0]) circle(r = d + w / 6, $fn = res);
                    translate([d * sin(60), d * cos(60), 0]) circle(r = d + w / 6, $fn = res);
                    translate([d * sin(120), d * cos(120), 0]) circle(r = d + w / 6, $fn = res);
                }
            }
        }
    }

    // superimposed circles

    if (forma == 10) {
        difference() {
            circle(r = (r1) / cos(30), $fn = 6);
            intersection() {
                circle(r = (r1) / cos(30) + 0.01, $fn = 6);
                for (i = [0:60:360]) {
                    rotate(i) translate([0, d, 0]) circle(r = r2 - 0.3, $fn = res);
                }
            }
        }
    }

    // flowers
    if (forma == 11) {
        rotate(30) for (i = [0:60:360]) {
            rotate(i) intersection() {
                translate([r2 * sin(0), r2 * cos(0), 0]) circle(r = r1, $fn = res);
                translate([r2 * sin(60), r2 * cos(60), 0]) circle(r = r1, $fn = res);
                translate([r2 * sin(120), r2 * cos(120), 0]) circle(r = r1, $fn = res);
            }
        }
    }

    // chain
    if (forma == 12) {
        difference() {
            circle(r = r3, $fn = 6);
            for (i = [0:30:360])
                rotate(i + 30) square([w, d1], center = true);
        }
    }

    // pajarita nazari da Alhambra
    if (forma == 13) {
        rotate(30 - atan(w / r3)) difference() {
            union() {
                circle(r3 / 2, $fn = res);
                for (i = [0:2])
                    rotate(i * 120) translate([0, r3 / 2]) circle(r3 / 2, $fn = res);
            }
            for (i = [0:2])
                rotate(i * 120) translate([(d - w) / 2, 0]) circle(r3 / 2, $fn = res);
        }
    }

    // trapezoids
    if (forma == 14) {
        difference() {
            circle(r = r3, $fn = 6);
            // for(i=[0:90:360]) rotate(i+30) translate([0,r,0]) square([w,d], center=true);
            for (i = [0:60:360])
                rotate(i) translate([0, d1 / 4 * cos(30), 0]) square([r1 * (1 - sin(30)) + w / 2, w], center = true);
            for (i = [0:60:360])
                rotate(i + 30) translate([0, r1, 0]) square([w, d1 * (1 - sin(30)) + w / 2], center = true);
            for (i = [0:60:360])
                rotate(i + 60) translate([0, r, 0]) square([w, r - w], center = true);
        }
    }

    // stars and cubes
    if (forma == 15) {
        difference() {
            circle(r = r3, $fn = 6);
            // for(i=[0:60:360]) rotate(i+30) translate([0,r,0]) square([w,d], center=true);
            for (j = [0:60:360])
                rotate(j) translate([d1 / 4 * cos(60), d1 / 4 * sin(60), 0]) for (i = [0:120:120]) rotate(i - 90) translate([0, r, 0])
                    square([w, d + w / 2], center = true);
        }
    }

    // Francois stone mosaic
    if (forma == 16) {
        difference() {
            rotate(30) circle(r = r1 / cos(30) - w / 2 / cos(30), $fn = 6);
            for (i = [0:120:360])
                rotate(i) translate([0, r, 0]) square([w, d], center = true);
            for (i = [0:120:360])
                rotate(i + 60) translate([0, 3 / 2 * r1 / cos(30) - w / cos(30), 0]) rotate(30) circle(r = r1 / cos(30) - w / 2 / cos(30), $fn = 6);
        }
    }

    // interlaced
    if (forma == 17) {
        difference() {
            rotate(30) circle(r = r1 / cos(30), $fn = 6);
            for (i = [0:120:360])
                rotate(i) translate([0, r, 0]) square([w, d], center = true);
            for (i = [0:120:360])
                rotate(i + 60) translate([0, 3 / 2 * r1 / cos(30) - 3 / 2 * w / cos(30), 0]) rotate(30) circle(r = r1 / cos(30) - w / 2 / cos(30), $fn = 6);
        }
    }

    // flower 3
    if (forma == 18) {
        for (i = [0:60:360]) {
            rotate(i) intersection() {
                translate([d * sin(0), d * cos(0), 0]) circle(r = d - w / 2, $fn = res);
                translate([d * sin(60), d * cos(60), 0]) circle(r = d - w / 2, $fn = res);
                translate([d * sin(120), d * cos(120), 0]) circle(r = d - w / 2, $fn = res);
            }
        }
    }

    // flowers 2
    if (forma == 19) {
        difference() {
            circle(r = r1 + 0.01, $fn = 6);
            rotate(30) for (i = [0:60:360]) {
                rotate(i) intersection() {
                    translate([r1 * sin(0), r1 * cos(0), 0]) circle(r = r2, $fn = res);
                    translate([r1 * sin(60), r1 * cos(60), 0]) circle(r = r2, $fn = res);
                    translate([r1 * sin(120), r1 * cos(120), 0]) circle(r = r2, $fn = res);
                }
            }
        }
    }

    // superposed rectangles
    if (forma == 20) {
        difference() {
            circle(r = r1 + 0.01, $fn = 6);
            for (i = [0:60:360])
                rotate(i) translate([0, r, 0]) difference() {
                    square([r1 + w, r1 * cos(30) + w], center = true);
                    square([r1 - w, r1 * cos(30) - w], center = true);
                }
        }
    }

    // circles 1
    if (forma == 21) {
        difference() {
            circle(r = r1 + 0.01, $fn = 6);
            for (i = [0:60:360])
                rotate(i + 30) translate([0, r1, 0]) circle(r = r1 / 2 + 0.2, $fn = res);
        }
    }

    // circles 2
    if (forma == 22) {
        difference() {
            circle(r = r1 + 0.01, $fn = 6);
            for (i = [0:60:360])
                rotate(i + 30) translate([0, r1, 0]) difference() {
                    circle(r = r1 / 2 + w / 2, $fn = res);
                    circle(r = r1 / 2 - w / 2, $fn = res);
                }
        }
    }

    // circles 3
    if (forma == 23) {
        for (i = [0:60:360])
            rotate(i + 30) translate([0, r1, 0]) circle(r = r1 / 2 - w / 2, $fn = res);
    }

    // stars and hexagons 1
    if (forma == 24) {
        difference() {
            circle(r = r1 + 0.01, $fn = 6);
            for (i = [0:60:360])
                rotate(i + 30) translate([2 * r1 - r1 * cos(30) / 2, 0, 0]) difference() {
                    circle(r = r1 + w / 2 / cos(30), $fn = 6);
                    circle(r = r1 - w / 2 / cos(30), $fn = 6);
                }
        }
    }

    // stars and hexagons 2
    if (forma == 25) {
        difference() {
            circle(r = r1 + 0.01, $fn = 6);
            for (i = [0:60:360])
                rotate(i + 30) translate([2 * r1 - r1 * cos(30) / 2, 0, 0]) circle(r = r1 + w / 2 / cos(30), $fn = 6);
        }
    }

    // stars and hexagons 3
    if (forma == 26) {
        difference() {
            circle(r = r1 + 0.01, $fn = 6);
            for (i = [0:60:360])
                rotate(i + 0) translate([r1 * (2 - cos(60)), 0, 0]) difference() {
                    circle(r = r1 + w / 2 / cos(30), $fn = 6);
                    circle(r = r1 - w / 2 / cos(30), $fn = 6);
                }
        }
    }

    // stars and hexagons 4
    if (forma == 27) {
        difference() {
            circle(r = r1 + 0.01, $fn = 6);
            for (i = [0:60:360])
                rotate(i + 0) translate([r1 * (2 - cos(60)), 0, 0]) circle(r = r1 + w / 2 / cos(30), $fn = 6);
        }
    }

    // circles e triangles
    if (forma == 28) {
        difference() {
            circle(r = r3, $fn = 6);
            for (i = [0:60:360])
                rotate(i + 30) translate([0, r, 0]) square([w, d], center = true);
            for (i = [0:60:360])
                rotate(i) translate([0, (r3 + w / 2) / 2 / cos(30), 0]) difference() {
                    circle(r = r3 / 2 * tan(30) + w / 2, $fn = res);
                    circle(r = r3 / 2 * tan(30) - w / 2, $fn = res);
                }
        }
    }

    // stars e squares
    if (forma == 29) {
        rc = ((r1 - w * (1 + tan(30))) * cos(45) / cos(15)) / 2;
        for (i = [0:60:360])
            rotate(i) translate([r1 - rc - w / 2 / cos(30), 0, 0]) circle(r = rc, $fn = 4);
    }

    // cubes 2
    if (forma == 30) {
        difference() {
            rotate(30) circle(r = r1 / cos(30) - w / 2 / cos(30), $fn = 6);
            for (i = [0:120:360])
                rotate(i) translate([0, r, 0]) square([w, d], center = true);
            for (i = [0:120:360])
                rotate(i) translate([0, r1 / cos(30) / 2, 0]) for (i = [0:120:360]) rotate(i) translate([0, r, 0]) square([w, d], center = true);
            for (i = [0:120:360])
                rotate(i + 60) translate([0, 3 / 2 * r1 / cos(30) - w / cos(30), 0]) rotate(30) circle(r = r1 / cos(30) - w / 2 / cos(30), $fn = 6);
        }
    }

    // waves 1
    if (forma == 31) {
        rotate(120) difference() {
            circle(r = r1 + 0.01, $fn = 6);
            for (i = [0:180:180])
                rotate(i) difference() {
                    translate([0, r, 0]) circle(r = r + w / 2, $fn = res);
                    translate([0, r, 0]) circle(r = r - w / 2, $fn = res);
                }
        }
    }

    // waves 2
    if (forma == 32) {
        rotate(120) difference() {
            circle(r = r1 + 0.01, $fn = 6);
            for (i = [0:180:180])
                rotate(i) difference() {
                    translate([0, r, 0]) circle(r = r + w / 2, $fn = res);
                    translate([0, r, 0]) circle(r = r - w / 2, $fn = res);
                }
            for (i = [0:180:180])
                rotate(i) {
                    difference() {
                        translate([-r1 / 2, r, 0]) circle(r = r1 / 2 + w / 2, $fn = res);
                        translate([-r1 / 2, r, 0]) circle(r = r1 / 2 - w / 2, $fn = res);
                    }
                    difference() {
                        translate([r1 / 2, r, 0]) circle(r = r1 / 2 + w / 2, $fn = res);
                        translate([r1 / 2, r, 0]) circle(r = r1 / 2 - w / 2, $fn = res);
                    }
                }
        }
    }

    // whatever
    module semi() {
        difference() {
            translate([0, r / 2, 0]) circle(r = r / 2 + w / 2, $fn = res);
            translate([0, r / 2, 0]) circle(r = r / 2 - w / 2, $fn = res);
            translate([0, -r / 2, 0]) square([2 * r, 2 * r], center = false);
        }
    }

    if (forma == 33) {
        difference() {
            circle(r = r1 + 0.01, $fn = 6);
            for (i = [0:60:300])
                rotate(i + 120) semi();
            for (i = [0:60:300])
                rotate(i) translate([0, r, 0]) mirror([1, 0, 0]) semi();
        }
    }
}

module grid(forma, rows = 3, cols = 3, n = 4) {
    // TODO: don't repeat me repeat me
    f = (forma == 5 || forma == 6 || forma == 8 || forma == 9 || forma == 11 || forma == 12 || forma == 13 || forma == 14 || forma == 15 || forma == 16 ||
         forma == 17 || forma == 18 || forma == 19 || forma == 20 || forma == 21 || forma == 22 || forma == 23 || forma == 24 || forma == 25 || forma == 26 ||
         forma == 27 || forma == 29 || forma == 30)
            ? 1
            : 0;
    nt = (f == 1 && n % 2 == 1 ? n + 1 : n);

    d = n == 0 ? 0 : f == 1 ? (2 * hex - w / cos(30)) / nt : (2 * hex * cos(30) - w) / nt;
    d1 = d / cos(30);
    r = d / 2;
    r1 = r / cos(30);
    r2 = (r + w / 2) / cos(30);
    r3 = (r - w / 2) / cos(30);
    x = f == 1 ? 0 : (-hex * cos(30) + w / 2);
    y = -nt * (r)*2 * cos(30);
    for (j = [0:1:rows - 1]) {
        translate([(j % 2) * r, j * r * 2 * cos(30), 0]) {
            for (i = [-cols / 2 - cols % 2 + 2:1:cols / 2 - cols % 2 + 1]) {
                translate([i * d, 0, 0]) rotate([0, 0, 30]) tesela(forma);
            }
        }
    }
}

module hexagon(forma, n = 4) {
    // TODO: don't repeat me repeat me
    f = (forma == 5 || forma == 6 || forma == 8 || forma == 9 || forma == 11 || forma == 12 || forma == 13 || forma == 14 || forma == 15 || forma == 16 ||
         forma == 17 || forma == 18 || forma == 19 || forma == 20 || forma == 21 || forma == 22 || forma == 23 || forma == 24 || forma == 25 || forma == 26 ||
         forma == 27 || forma == 29 || forma == 30)
            ? 1
            : 0;
    nt = f == 1 && n % 2 == 1 ? n + 1 : n;
    d = n == 0 ? 0 : f == 1 ? (2 * hex - w / cos(30)) / nt : (2 * hex * cos(30) - w) / nt;
    d1 = d / cos(30);
    r = d / 2;
    r1 = r / cos(30);
    r2 = (r + w / 2) / cos(30);
    r3 = (r - w / 2) / cos(30);
    x = f == 1 ? 0 : (-hex * cos(30) + w / 2);
    y = -nt * (r)*2 * cos(30);

    rot = f == 1 ? 0 : 30;
    rotate(rot) linear_extrude(h) union() {
        rotate(rot) difference() {
            circle(r = hex, $fn = 6);
            circle(r = hex - bordo / cos(30), $fn = 6);
        }
        difference() {
            rotate(rot) circle(r = hex, $fn = 6);
            translate([x, y, 0]) grid(forma);
        }
    }
}


