module ring (ring_height = 2,
    r1 = 333.310,
    r2 = 303.310,
    light_gap_inner = 1.5,
    light_gap_outer = 1.5,
    sep_thickness = 4,
    sep_height = 12,
    $fn = 240) {

    sep_length_outer = (r1 - r2 - light_gap_outer*2) / 2;
    sep_length_inner = (r1 - r2 - light_gap_inner*2) / 2;


    difference() {
        union() {
            difference() {
                cylinder(h = ring_height, r1 = r1, r2 = r1, center = true);
                cylinder(h = ring_height+1, r1 = r2, r2 = r2, center = true);
            };
    
            for (i = [90:100])
            rotate(i * 3){
                translate([0, r2 + sep_length_inner / 2, sep_height / 2 + ring_height / 2]) {
                    cube(size = [sep_thickness, sep_length_inner, sep_height], center = true);
                }
                translate([0, r1 - sep_length_outer / 2, sep_height / 2 + ring_height / 2]) {
                    cube(size = [sep_thickness, sep_length_outer, sep_height], center = true);
                }
            }
        }

        translate([0, 0, -ring_height/2 - 1]) {
            translate([-r1-1, -r1-1, 0]) {
                cube([r1+1, 2*r1+1, sep_height + ring_height + 2], center = false);
            }
            translate([-r1-1, -r1-1, 0]) {
                cube([2*r1+2, r1+1, sep_height + ring_height + 2], center = false);
            }
            rotate(30) {
                cube([r1+1, r1+1, sep_height + ring_height + 2], center = false);
            }
        }
    }
}

module inv_ring (ring_height = 1,
    r1 = 333.310,
    r2 = 303.310,
    light_gap_inner = 1.5,
    light_gap_outer = 1.5,
    sep_thickness = 4,
    sep_height = 12,
    $fn = 240,
    tolerance = 0.5) {

    rotate([0,180,180]) difference() {
        difference() {
            cylinder(h = ring_height, r1 = r1, r2 = r1, center = true);
            cylinder(h = ring_height+1, r1 = r2, r2 = r2, center = true);
        };
    
        translate([0, 0, -ring_height/2 - 1]) {
            translate([-r1-1, -r1-1, 0]) {
                cube([r1+1, 2*r1+1, sep_height + ring_height + 2], center = false);
            }
            translate([-r1-1, -r1-1, 0]) {
                cube([2*r1+2, r1+1, sep_height + ring_height + 2], center = false);
            }
            rotate(30) {
                cube([r1+1, r1+1, sep_height + ring_height + 2], center = false);
            }
        }

        translate([0, 0, -sep_height-ring_height/2]) ring(ring_height, r1, r2, light_gap_inner - tolerance, light_gap_outer - tolerance, sep_thickness + tolerance*2, sep_height, $fn);
    }
}


//ring_height = 2;
//r1 = 333.310;
//r2 = 303.310;
//light_gap = 3;
//sep_thickness = 4;
//sep_height = 12;
//tolerance = 0.5;
//
//difference(){
//inv_ring();
////ring();
//translate([0,0,-1])
//difference(){
//cylinder(h=2, r1=r2, r2=r2+(r1 - r2)/2, $fn=240);
//rotate([0,180,180])translate([0, 0, -sep_height-ring_height/2]) ring(ring_height, r1, r2, light_gap - tolerance*2, sep_thickness + tolerance*2, sep_height, $fn);
//}
//}


//        difference(){
//            difference() {
//                cylinder(h = ring_height+1, r1 = r1, r2 = r1, center = true);
//                cylinder(h = ring_height+2, r1 = r2, r2 = r2, center = true);
//
//            };
//
//            difference() {
//                cylinder(h = ring_height+3, r1 = r1-sep_length, r2 = r1-sep_length, center = true);
//                cylinder(h = ring_height+4, r1 = r2+sep_length, r2 = r2+sep_length, center = true);
//            };
//
//            for (i = [80:90])
//            rotate(i * 3){
//                translate([0, r2 + sep_length / 2, -ring_height]) {
//                    cube(size = [sep_thickness+4*tolerance, r1, 2*sep_height], center = true);
//                }
//            };
//        }

inv_ring();
//ring();