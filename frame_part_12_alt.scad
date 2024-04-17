module ring (ring_height = 2,
    r1 = 333.310,
    r2 = 303.310,
    inner_gap = 3,
    gap = 12,
    sep_height = 12,
    $fn = 240) {

    r3 = (r1 + r2 + inner_gap) / 2;
    r4 = (r1 + r2 - inner_gap) / 2;

    difference() {
        difference() {
            cylinder(h = ring_height+sep_height, r1 = r1, r2 = r1, center = true);

            cylinder(h = ring_height+sep_height+1, r1 = r2, r2 = r2, center = true);
            translate([0, 0, ring_height]) difference() {
                cylinder(h = ring_height+sep_height, r1 = r3, r2 = r3, center = true);
                cylinder(h = ring_height+sep_height+1, r1 = r4, r2 = r4, center = true);
            }
            for (i = [90:100])
            rotate(i * 3+1.5){
                translate([0, (r1 + r2) / 2 - 1, ring_height/2+1]) {
                    cube(size = [gap, r1-r2+3, sep_height+2], center = true);
                }
            }
        };

        translate([0, 0, -(ring_height+sep_height)/2 - 1]) {
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

module inv_ring (ring_height = 2,
    r1 = 333.310,
    r2 = 303.310,
    inner_gap = 3,
    gap = 12,
    sep_height = 12,
    $fn = 240,
    tolerance = 0.1) {


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

        translate([0, 0, -(sep_height+ring_height)/2]) ring(ring_height, r1, r2, inner_gap - tolerance*2, gap - tolerance*2, sep_height, $fn);
    }
}

//inv_ring();
ring();