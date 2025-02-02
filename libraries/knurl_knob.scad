
// Example:
// knurled_cyl(knob_height=15, knob_dia=22, knurl_width=4, knurl_height=5, knurl_depth=1.1, knurl_cutoff=15-1.5, smooth_amount=50);

module knurled_cyl(knob_height, knob_dia, knurl_width, knurl_height, knurl_depth, knurl_cutoff, smooth_amount)
{
    cord=(knob_dia+knurl_depth+knurl_depth*smooth_amount/100)/2;
    cird=cord-knurl_depth;
    cfn=round(2*cird*PI/knurl_width);
    clf=360/cfn;
    crn=ceil(knob_height/knurl_height);

    intersection()
    {
        shape(knurl_cutoff, cird, cord-knurl_depth*smooth_amount/100, cfn*4, knob_height);

        translate([0,0,-(crn*knurl_height-knob_height)/2])
          knurled_finish(cord, cird, clf, knurl_height, cfn, crn);
    }
}

module shape(hsh, ird, ord, fn4, hg)
{
        union()
        {
            cylinder(h=hsh, r1=ird, r2=ord, $fn=fn4, center=false);

            translate([0,0,hg-hsh])
              cylinder(h=hsh, r1=ord, r2=ird, $fn=fn4, center=false);
        }

}

module knurled_finish(ord, ird, lf, sh, fn, rn)
{
    for(j=[0:rn-1])
    assign(h0=sh*j, h1=sh*(j+1/2), h2=sh*(j+1))
    {
        for(i=[0:fn-1])
        assign(lf0=lf*i, lf1=lf*(i+1/2), lf2=lf*(i+1))
        {
            polyhedron(
                points=[
                     [ 0,0,h0],
                     [ ord*cos(lf0), ord*sin(lf0), h0],
                     [ ird*cos(lf1), ird*sin(lf1), h0],
                     [ ord*cos(lf2), ord*sin(lf2), h0],

                     [ ird*cos(lf0), ird*sin(lf0), h1],
                     [ ord*cos(lf1), ord*sin(lf1), h1],
                     [ ird*cos(lf2), ird*sin(lf2), h1],

                     [ 0,0,h2],
                     [ ord*cos(lf0), ord*sin(lf0), h2],
                     [ ird*cos(lf1), ird*sin(lf1), h2],
                     [ ord*cos(lf2), ord*sin(lf2), h2]
                    ],
                triangles=[
                     [0,1,2],[2,3,0],
                     [1,0,4],[4,0,7],[7,8,4],
                     [8,7,9],[10,9,7],
                     [10,7,6],[6,7,0],[3,6,0],
                     [2,1,4],[3,2,6],[10,6,9],[8,9,4],
                     [4,5,2],[2,5,6],[6,5,9],[9,5,4]
                    ],
                convexity=5);
         }
    }
}
