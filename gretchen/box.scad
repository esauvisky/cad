include <../misc/parametrizable-rugged-box.scad>
include <bosl/shapes.scad>

outSideLength = 220;
outsideWidth = 120;
outSideHeight = 50;
    //bottom
color([0.5,0.5,1])
translate([0,outSideWidth+4*shellThickness,0])
ruggedBox(length=outSideLength, width=outSideWidth, height=outSideHeight, fillet=filletRadius, shell=shellThickness, rib=ribThickness, top=false, fillHeight=0);

// rotate([ 180, 90, 0 ])
// difference()
// {
//     tube(h = 20, or = 17, ir = 12);
//     translate([ 0, -5, 25/4 ])
//     rotate([ 90, 0, 0 ])
//     prismoid(size1 = [ 15, 35 ], size2 = [ 15, 35 ], h = 20, align = V_ABOVE);
// }
