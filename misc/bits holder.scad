include <gridfinity-spiral-vase.scad>
gridfinityInit(3, 3, height(6), 0, 42)  {
    cut(0,2,2,1,5,false);
    cut(1,0,1,3,5);
    cut(1,0,2,1,5);
    cut(0,0,1,2);
    cut(2,1,1,2);
}
gridfinityBase(3, 3, 42, 0, 0, 1);
