
// Global resolution
$fs = 0.1;  // Don't generate smaller facets than 0.1 mm
$fa = 5;    // Don't generate larger angles than 5 degrees

width = 40;
height = 40;
depth = 30;
wall = 2;

cable_width = 16;
cable_height = 1;

module cable() {
    translate([(width-cable_width)/2, 2*wall, wall+cable_height/2])
        rotate([90,0,0]) {
            hull() {
                cylinder(d=cable_height, h=100);
                translate([cable_width,0,0]) cylinder(d=cable_height, h=100);
            }
        }
}

module house() {
    difference() {
        cube([width, height, depth]);
        translate([wall,wall,wall]) cube([width-2*wall, height-2*wall, depth]);
        cable();
    }
}

//translate([50,0,0])
difference() {
    house();
}

echo(version=version());
