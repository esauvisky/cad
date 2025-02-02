use<tubemesh.scad>;

module snap(s, h) {
  rotate([ 0, 0, 180 ]) linear_extrude(height = h) polygon(points = [
    [ 0 * s, -3 * s ],
    [ 0 * s, 3 * s ],
    [ 11 * s, 8 * s ],
    [ 16 * s, 6 * s ],
    [ 16 * s, -6 * s ],
    [ 11 * s, -8 * s ],
  ]);
}

module stand() {
  //<params>
  angleToGround = 65;
  kickstandDiameter = 10;
  minimumThickness = 10;
  tolerance = 1;
  length = 30;
  bottomDiameter = 40;
  bottomDistance = 40;
  bottomRim = 3;
  //</params>

  $fn = 50;

  id = kickstandDiameter + 2 * tolerance;

  function translate(z, p) = [for (q = p) z + q];

  function tiltXZ(angle, p) =
      [for (q = p)[cos(angle) * q[0] - sin(angle) * q[2], q[1],
                   sin(angle) * q[0] + cos(angle) * q[2]]];

  topSection0 =
      sectionZ(ngonPoints(n = $fn, r = (id + minimumThickness) / 2), 0);

  z1 = [ cos(angleToGround), 0, sin(angleToGround) ];
  topSection = translate(z1 * length * 0.5, tiltXZ(angleToGround - 90, topSection0));

  sections = [
    sectionZ(ngonPoints(n = $fn, r = bottomDiameter / 2), 0),
    sectionZ(ngonPoints(n = $fn, r = bottomDiameter / 2), bottomRim),
    topSection
  ];

  difference() {
    tubeMesh(sections);
    translate(z1 * bottomDistance) rotate([ 0, 90 - angleToGround, 0 ])
        cylinder(h = 2 * length, d = id);
  }
}

// translate([ -8, 0, -30 ]) stand();
// minkowski() {

hull() {
  translate([ 11, 0, -4 ]) rotate([ 0, 15, 0 ]) minkowski() {
    snap(0.5, 5);
    sphere(4.2);
  }
  translate([ -8, 0, -30 ]) stand();
}

union() {
  translate([ 5, 0, -4 ]) rotate([ 0, 30, 0 ]) minkowski() {
    snap(0.5, 40);
    sphere(4.2);
  }
}
// cylinder(h = 1, d = 4);
// }
// snap(1);
