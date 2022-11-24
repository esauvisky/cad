include <threads2.scad>

module MetricBolt(diameter, length, tolerance=0.4) {
  drive_tolerance = pow(3*tolerance/HexDriveAcrossCorners(diameter),2)
    + 0.75*tolerance;

  difference() {
    cylinder(h=diameter, r=(HexAcrossCorners(diameter)/2-tolerance), $fn=20);
    cylinder(h=diameter,
      r=(HexDriveAcrossCorners(diameter)+drive_tolerance)/2, $fn=6,
      center=true);
  }
  translate([0,0,diameter-0.01])
    ScrewThread(diameter, length+0.01, tolerance=tolerance,
      tip_height=ThreadPitch(diameter), tip_min_fract=0.75);
}
translate([0,0,0]) MetricBolt(6.4,40);
translate([25,0,0]) MetricBolt(6.8,40);
// translate([50,0,0]) MetricBolt(5.8,50);
// translate([-25,0,0]) MetricBolt(6.2,40);
// translate([-50,0,0]) MetricBolt(6,50);
