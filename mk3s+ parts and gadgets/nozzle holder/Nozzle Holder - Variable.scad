include <BOSL/shapes.scad>;

//The overall thickness of the main body, changing this will affect everything else, its been designed that way, it should all work, but I wouldnt go thinner.
thickness = 9;

// Set to true for second column of holes or false for a single column
second_col = true;
hole_spacing = 10;

// Set number of holes in the column (max 7)
hole_count = 7;

// Used for hole placement calculations do no change.
hc = hole_spacing * hole_count - 1;

// Logo - I would love it if you wanted to include my logo stuff on your print, but I get it, you might not want to, So if you want to get rid of it just set the below to "false".
logo = true;

//To change the text just edit between the " in the table below.
table=[
[hole_spacing * 0,".25mm"],
[hole_spacing * 1,"0.3mm"],
[hole_spacing * 2,"0.4mm"],
[hole_spacing * 3,"0.5mm"],
[hole_spacing * 4,"0.6mm"],
[hole_spacing * 5,"0.9mm"],
[hole_spacing * 6,"1.0mm"],
];

//This offset moves the holes and the text to the centre when there is only one column.
offset = second_col==false?5:0;

// Below is the bits you dont need to change, but you might want to read the comments just for fun. I get it, I do it too ;).

difference(){
    group(){
        //This is the thread part of the main body
        translate([0,-40,thickness/2])
        cuboid([42,86,thickness]);

        //This is the nut part of the main body
        translate([0,-73,thickness/2])
        cuboid([60,20,thickness]);

        //This is the chamfered part of the main body - Just a rotated square
        translate([0,-83,thickness/2])
        rotate([0,0,-45])
        cuboid([35,35,thickness]);
    }
    

    //To give the illusion of a flat tip we difference the cuboid below from the chamfered point cuboid above
    translate([0,-110,thickness/2])
    cuboid([10,10,20]);
    
// This is the bit with the holes - Arguably the most important bit
    
        // Row 1
            for (i = [0:hole_spacing:hc])
        
    {
            translate([-15  + offset,-i -17,1])
            cylinder(thickness,3.1,3.1, $fn=50);
            metric_thread (6, 1, thickness- 1, internal=true);
        


    }
        
        // Row 2
            if (second_col == true){
            for (i = [0:hole_spacing:hc])
            
        {
                translate([+15,-i -17,1])
                cylinder(thickness,3.1,3.1, $fn=50);
        }
}

}
        for (i = [0:hole_spacing:hc])
        
     {
            t = search(i, table);
            translate([-10 + offset,-i -17,thickness])
            color("black")
            linear_extrude(1)
            
            text(table[t[0]][1], halign="left", valign="center", size=5, font="Arial");
            
     }
     
//This is the logo stuff, if you set logo to false at the top of this file it all disappears
     
     
     //Text Part of the logo - If you're interested the font I usually use for my logo is Code by Fontfabric from dafont.com (https://www.dafont.com/code.font) but I didnt want to overcomplicate this with showing people how to install these fonts into OpenSCAD.

     if (logo == true){
            translate([0,-85.5,thickness])
            color("black")
            linear_extrude(1)
            text("RANDUMB", halign="center", valign="center", size=5, font="Arial");
        
            translate([0,-91.5,thickness])
            color("black")
            linear_extrude(1)
            text("PRINTS", halign="center", valign="center", size=5, font="Arial");
           group()
    
     //This is the little hotend/nozzle image at the top of the print
         
         //Hot end cuboid
           translate ([0,-2,thickness])
           color("red")
           cuboid ([11,5,1]);
        
         //Screw thread cuboid
           translate ([0,-7,thickness])
           color("red")
           cuboid ([5,3.5,1]);
      
         //Nut cuboid
           translate ([0,-7.5,thickness])
           color("red")
           cuboid ([6,2.5,1]);
           difference(){ 
     
         //Hotend point
           translate ([0,-10.5,thickness])
           color("red")
           cuboid ([5,5,1]);
         
         //Hotend cutout - left
           translate ([-2.5,-10.5,thickness+0.01])
           rotate ([0,0,35])
           color("blue")
           cuboid ([3,7,1]);
        
         //Hotend cutout - right
           translate ([2.5,-10.5,thickness+0.01])
           rotate ([0,0,-35])
           color("blue")
           cuboid ([3,7,1]);
         }
    }