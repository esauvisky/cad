
include <BOSL/threading.scad>

$fn=100;

//Parameters
RodDiam = 5;
RodLength = 20;
NutSize = 10;
NutHeight = 5;

// The threaded rod
translate([0, 0, -RodLength/2])
  thread_rod(d=RodDiam, pitch=2, l=RodLength,
             thread_size=0.65, thread_angle=30, thread_style=TS_SCREW_ROD,
             ends=[THREADED, THREADED]);

// The nut
translate([0, 2*NutSize, 0])
  thread_nut(d=RodDiam, pitch=2, h=NutHeight, thread_style=TS_NUT_HEX, hex_size=NutSize);
