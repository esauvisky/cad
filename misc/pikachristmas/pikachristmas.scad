  linear_extrude(height=1, center=false) {
        import(file="a1.dxf", convexity=3, center=false);
    };
  translate([0,0,1]) linear_extrude(height=0.5, center=false) {
        import(file="a2.dxf", convexity=3, center=false);
    };
  translate([0,0,1.5]) linear_extrude(height=0.5, center=false) {
        import(file="a3.dxf", convexity=3, center=false);
    };
  translate([0,0,2]) linear_extrude(height=0.5, center=false) {
        import(file="a4.dxf", convexity=3, center=false);
    };
  translate([0,0,2.5]) linear_extrude(height=0.5, center=false) {
        import(file="a5.dxf", convexity=3, center=false);
    };
