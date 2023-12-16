$fn=64;   //set facet resolution

wrenchSize = [6,6,6,6,6,6,6,6,6,6,6,6];  //put in your wrench sizes



//below you can customize your holder in various ways




//Text Location and orientation.
numbersOnTop = 0;
numbersOnSide = 0;
flipSideText=0;
angledGroove=1;

//coefficients for quadratic spacing equations for spreading out the holes.  My tip: Increase B until the large holes are far enough apart to print, then decrease A until the last hole is in a good spot.  If necessary, then you can shrink the font-size
A = 0;
B = 30;
fontSize = 3.5;

//The hole size is calculated per the following linear relationship.  wrenchSize*1.15 + .24.  The 1.15 gets from the flat-flat distance to the corner to corner distance, and the 0.24 gives some buffer, since the point is the oring not the plastic holds the wrench.  Adjust these values if needed.
x=1.15;
y=0.24;



//___________________________________________________________

//These are the base dimensions.  If you change these, you'll need to find something that works with the o-ring you select
diameterOuter=51;
diameterInner=42.835;

//This is used to place the outer edge of each hole 3mm from the outer edge of the holder.
offset=diameterOuter/2-3;


intersection()
{
    sphere(diameterOuter/2);

    difference()
    {
        union()
        {
            //Center Section
            cylinder(3.8,d=diameterInner,center =true);

            //Chamfer from inner to outer diameter
            if(angledGroove==1)
            {
                translate([0,0,2.9])cylinder(2,d1=diameterInner, d2=diameterOuter, center=true);
            }
            if(angledGroove==0)
            {
                translate([0,0,2.9])cylinder(2,d1=diameterOuter, d2=diameterOuter, center=true);
            }
            //Upper Section
            translate([0,0,2.9+2.5])cylinder(3,d1=diameterOuter, d2=diameterOuter, center=true);

            //Lower Section
            translate([0,0,-2.5-1.9])cylinder(5,d=diameterOuter,center =true);
        }

        //Holes for wrenches
        for (i = [0:1:len(wrenchSize)-1])
        {
            //translate([22-Wrench1/2,0,0])cylinder(16,d=Wrench1,center=true);

            rotate([0,0,(A*i*i + B*i)])translate([offset-(wrenchSize[i]*1.05+.25)/2,0,0])
            linear_extrude(height = 16, center = true)
            polygon(points=[for (j = [0:5]) [(wrenchSize[i]*x+y)/2*cos(360/6*j), (wrenchSize[i]*x+y)/2*sin(360/6*j)]]);

            //Chamfers top
            rotate([0,0,(A*i*i + B*i)])translate([offset-(wrenchSize[i]*1.05+.25)/2,0,6.5])cylinder(2,d1=wrenchSize[i]*x+y-1.5, d2=wrenchSize[i]*1.15+.24+1.25,center=true);

            //Chamfers bottom
            rotate([0,0,(A*i*i + B*i)])translate([offset-(wrenchSize[i]*1.05+.25)/2,0,-6.5])cylinder(2,d1=wrenchSize[i]*x+y+1.25, d2=wrenchSize[i]*1.15+.24-1.5,center=true);
        }

        //Wrench size labels
        if(numbersOnTop ==1)
        {
            font1 = "Liberation Sans:style=Bold"; // here you can select other font type
            translate([0,0,6.5])linear_extrude(height = 1)
            {
                for (i= [0:1:len(wrenchSize)-1])
                    {
                        rotate([0,0,(A+0.02)*i*i + B*i])translate([10+wrenchSize[i]*.15+0.75*i,0,0])rotate([0,0,-90])text(str(wrenchSize[i]), font = font1, halign="center", size = fontSize, direction = "ttb", spacing = 0.7);
                    }
            }
        }
        if(numbersOnSide ==1)
        {
            font1 = "Liberation Sans:style=Bold"; // here you can select other font type

            for (i = [0:1:len(wrenchSize)-1])
            {
                if(flipSideText==1)
                {
                    orientation=180;

                    rotate([0,0,(A*i*i + B*i)])
                    translate([(diameterOuter/2)-2,0,-2.65])rotate([90,orientation,90])linear_extrude(height = 2)
                    {
                        text(str(wrenchSize[i]), font = font1, halign="center",  size = fontSize, direction = "ltr", spacing = 1);
                    }
                }
                else
                {
                    orientation=0;
                    rotate([0,0,(A*i*i + B*i)])
                    translate([(diameterOuter/2)-2,0,-6])rotate([90,orientation,90])linear_extrude(height = 2)
                    {
                        text(str(wrenchSize[i]), font = font1, halign="center",  size = fontSize, direction = "ltr", spacing = 1);
                    }
               }
            }
        }
    }
}
