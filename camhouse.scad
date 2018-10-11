
// Global resolution
$fs = 0.1;  // Don't generate smaller facets than 0.1 mm
$fa = 5;    // Don't generate larger angles than 5 degrees

width = 40;
height = 40;
depth = 30;
wall = 2;

cable_width = 16;
cable_height = 1;

support_width=21;
support_height=18;


support_origin = [(width - support_width) / 2, (height - support_height) / 2, wall];


module cable() {
    translate([(width-cable_width)/2, 2*wall, wall+cable_height/2])
        rotate([90,0,0]) {
            hull() {
                cylinder(d=cable_height, h=3*wall);
                translate([cable_width,0,0]) cylinder(d=cable_height, h=3*wall);
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

module support() {
    difference() {
        cylinder(d1=10,d2=1.5,h=5);
        cylinder(d=1,h=6);
    }
}

translate([-width/2,-height/2,-depth/2])
union() {
    house();
    translate(support_origin) support();
    translate(support_origin + [support_width, 0, 0]) support();
    translate(support_origin + [0, support_height, 0]) support();
    translate(support_origin + [support_width, support_height, 0]) support();
}

echo(version=version());
