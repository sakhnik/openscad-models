// Global resolution
// vim: set et ts=2 sw=2:

$fs = 0.1;  // Don't generate smaller facets than 0.1 mm
$fa = 5;    // Don't generate larger angles than 5 degrees

length = 180;
width = 34;
wall_thickness = 2;
rib_size = 20;
rib_thickness = 1;
clip_z = 12;

module inner_path() {
  linear_extrude(height = 15) {
    resize([0, length, 0], auto=true) {
      import("inner.svg", center=true);
    }
  }
}

// Side walls
module side_walls() {
  difference() {
    inner_path();
    translate([0,0,-5]) {
      scale([(width - 2*wall_thickness) / width, (length - 2*wall_thickness) / length, 2]) {
        inner_path();
      }
    }
  }
}

// Ribs
module ribs() {
  translate([0, 0, 2]) {
    difference() {
      scale([(width - 2*wall_thickness) / width, (length - 2*wall_thickness) / length, 0.1]) {
        inner_path();
      }
      for (i = [0:10]) {
        for (j = [0:10]) {
          rotate([0, 0, 45]) {
            translate([(i - 4) * rib_size, (j - 4) * rib_size]) {
              cube([rib_size - rib_thickness / 2, rib_size - rib_thickness / 2, 10], center=true);
            }
          }
        }
      }
    }
  }
}

// Cover
module cover_shape() {
  l = length + 15;
  rx = (width - 10) / width;
  ry = (l - 10) / l;
  linear_extrude(height = 5, scale = [1/rx, 1/ry]) {
    scale([rx, ry]) {
      rotate([0, 0, -1.7]) {
        translate([2, 0, 0]) {
          resize([0, l, 0], auto=true) {
            import("face.svg", center=true);
          }
        }
      }
    }
  }
}

module cover() {
  difference() {
    cover_shape();
    translate([0, 0, 2.0]) {
      scale([1, 1, 0.8]) {
        cover_shape();
      }
    }
  }
}

// Clips
module clip() {
  rotate([0, 90, 90]) {
    linear_extrude(height = 5) {
      polygon(points = [[0, 0], [5, 0], [4.5, 2]], paths=[[0, 1, 2]]);
    }
  }
}


module side_clips(incline, x0) {
  for (i = [0:7]) {
    y = (i - 3) * 18;
    dx = y * tan(incline);
    translate([x0 + dx, y, clip_z]) {
      rotate([0, 0, -incline]) {
        if (x0 < 0) {
          clip();
        } else {
          mirror([1, 0, 0]) {
            clip();
          }
        }
      }
    }
  }
}

//////////////////////////////////////////////////
// clips

module clips() {
    
  side_clips(1.5, -13.5);
  side_clips(-1, 14);

  translate([3,-90, clip_z]) {
    rotate([0,0,90]) {
      clip();
    }
  }

  translate([-2, 90, clip_z]) {
    rotate([0, 0, -90]) {
      clip();
    }
  }

  translate([-11, -82, clip_z]) {
    rotate([0, 0, 18]) {
      clip();
    }
  }

  translate([11, -82, clip_z]) {
    rotate([0, 0, -18]) {
      mirror([1, 0, 0]) {
        clip();
      }
    }
  }
}

// Mirror for the left fit
scale([1.02,1,1]) {
  mirror([1,0,0]) {
    side_walls();
    clips();
    ribs();
    cover();
  }
}
