// Global resolution
$fs = 0.1;  // Don't generate smaller facets than 0.1 mm
$fa = 5;    // Don't generate larger angles than 5 degrees

length = 180;
width = 34;
wall_thickness = 2;

difference() {
union() {
difference() {
translate([0,0,10])
cube([5,5,30]);
    
translate([-2.5,0,0])
    rotate([0,0,-30])
    translate([5,0,0])
    cube([10,10,50]);
};

cube([2,20,50]);
};

translate([0,5,5])
rotate([0,90,0])
cylinder(10, 2, 2, center=true);

translate([0,5,45])
rotate([0,90,0])
cylinder(10, 2, 2, center=true);

translate([0,15,25])
rotate([0,90,0])
cylinder(10, 2, 2, center=true);
};