$fn = 28;

module box_whole(dim_inner_w, dim_inner_l, dim_inner_h, wall_thickness, tolerance, radius)
{

    scd40_inner_distance = 2;
    esp_inner_distance = 1;

    union()
    {
        // sealing wall for esp
        difference(){
            translate([ 7 - tolerance, 11 - tolerance, dim_inner_h - esp_inner_distance])
            cube([ 14 + 2 * tolerance, 17 + 2 * tolerance, esp_inner_distance + wall_thickness ]);
            translate([ 7.5 - tolerance, 11.5 - tolerance, dim_inner_h - esp_inner_distance-wall_thickness ])
            cube([ 13 + 2 * tolerance, 16 + 2 * tolerance, esp_inner_distance * 4*wall_thickness ]);
        }
        //sealing wall for scd40
        difference()
        {
            translate([ 2 - tolerance, 45 - tolerance, dim_inner_h -scd40_inner_distance])
                cube([ 10 + 2 * tolerance, 10 + 2 * tolerance, scd40_inner_distance + wall_thickness]);
            translate([ 2.5 - tolerance, 45.5 - tolerance, dim_inner_h - scd40_inner_distance-wall_thickness ])
                cube([ 9 + 2 * tolerance, 9 + 2 * tolerance, scd40_inner_distance + 3 * wall_thickness ]);
        }
        difference()
        {
            union()
            {
                // the case itself without the holes
                hull()
                {
                    // spheres to make 4 upper rounded corners
                    translate(
                        [ radius - wall_thickness, radius - wall_thickness, dim_inner_h - radius + wall_thickness ])
                        sphere(r = radius);
                    translate([
                        dim_inner_w - radius + wall_thickness, radius - wall_thickness, dim_inner_h - radius +
                        wall_thickness
                    ]) sphere(r = radius);
                    translate([
                        radius - wall_thickness, dim_inner_l - radius + wall_thickness, dim_inner_h - radius +
                        wall_thickness
                    ]) sphere(r = radius);
                    translate([
                        dim_inner_w - radius + wall_thickness, dim_inner_l - radius + wall_thickness,
                        dim_inner_h - radius +
                        wall_thickness
                    ]) sphere(r = radius);
                    
                    // bottom square
                    translate([ -wall_thickness, -wall_thickness, -wall_thickness ])
                        cube([ dim_inner_w + 2 * wall_thickness, dim_inner_l + 2 * wall_thickness, wall_thickness ]);
                }
            }
            union()
            {
                // smaller version of the case to make it hollow
                hull()
                {
                    // spheres to make 4 upper rounded corners
                    translate([ radius - tolerance, radius - tolerance, dim_inner_h - radius + tolerance ])
                        sphere(r = radius);
                    translate(
                        [ dim_inner_w - radius + tolerance, radius - tolerance, dim_inner_h - radius + tolerance ])
                        sphere(r = radius);
                    translate(
                        [ radius - tolerance, dim_inner_l - radius + tolerance, dim_inner_h - radius + tolerance ])
                        sphere(r = radius);
                    translate([
                        dim_inner_w - radius + tolerance, dim_inner_l - radius + tolerance, dim_inner_h - radius +
                        tolerance
                    ]) sphere(r = radius);

                    // bottom square
                    translate([ -tolerance, -tolerance, -tolerance ])
                        cube([ dim_inner_w + 2 * tolerance, dim_inner_l + 2 * tolerance, wall_thickness ]);
                }
                // usb hole
                translate([ 10, -2 * wall_thickness, 4 ]) cube([ 10, 3 * wall_thickness, 4 ]);

                // esp hole
                translate([ 7.5 - tolerance, 11.5 - tolerance, dim_inner_h - wall_thickness ])
                    cube([ 13 + 2 * tolerance, 16 + 2 * tolerance, 3 * wall_thickness ]);

                // scd40 hole
                translate([ 2.5 - tolerance, 45.5 - tolerance, dim_inner_h - wall_thickness ])
                    cube([ 9 + 2 * tolerance, 9 + 2 * tolerance, 3 * wall_thickness ]);

                // brighness sensor hole
                translate([ 22.5, 49, dim_inner_h - wall_thickness ]) cylinder(h = 3 * wall_thickness, r1 = 4, r2 = 4);

                // leds socket hole: 2 options
                //translate([10.5,dim_inner_l-wall_thickness,4])cube([9,3*wall_thickness,7 + wall_thickness]);
                translate([ 10.5, dim_inner_l - wall_thickness, 4 ]) cube([ 9, 3 * wall_thickness, 3 ]);

                // air holes
                translate([ -2, 3, 5 ])cube([ 40, 1, 10 ]);
                translate([ -2, 7, 5 ])cube([ 40, 1, 10 ]);
                translate([ -2, 11, 5 ])cube([ 5, 1, 10 ]);
                translate([ -2, 15, 5 ])cube([ 5, 1, 10 ]);
                translate([ -2, 19, 5 ])cube([ 5, 1, 10 ]);
                translate([ -2, 23, 5 ])cube([ 5, 1, 10 ]);
                translate([ -2, 27, 5 ])cube([ 5, 1, 10 ]);
                translate([ 24.5, 11, 5 ])cube([ 7, 1, 10 ]);
                translate([ 24.5, 15, 5 ])cube([ 7, 1, 10 ]);
                translate([ 24.5, 19, 5 ])cube([ 7, 1, 10 ]);
                translate([ 24.5, 23, 5 ])cube([ 7, 1, 10 ]);
                translate([ 24.5, 27, 5 ])cube([ 7, 1, 10 ]);
                translate([ -2, 31, 5 ])cube([ 40, 1, 10 ]);
                translate([ -2, 35, 5 ])cube([ 40, 1, 10 ]);
                translate([ -2, 39, 5 ])cube([ 40, 1, 10 ]);
            };
        };
    };
};

module box_top(dim_inner_w, dim_inner_l, dim_inner_h, wall_thickness, tolerance, radius)
{
    difference()
    {
        box_whole(dim_inner_w, dim_inner_l, dim_inner_h, wall_thickness, tolerance, radius);
        translate([ -2 * wall_thickness, -2 * wall_thickness, -2 * wall_thickness ])
            cube([ dim_inner_w + 4 * wall_thickness, dim_inner_l + 4 * wall_thickness, 2 * wall_thickness ]);
    }
}

// in progress, this was intendet to be the bottom part but figured out it wasn't necessary
//module box_bottom(dim_inner_w, dim_inner_l, dim_inner_h, wall_thickness, tolerance, radius)
//{
//    difference()
//    {
//        box_whole(dim_inner_w, dim_inner_l, dim_inner_h, wall_thickness, tolerance, radius);
//        translate([ -2 * wall_thickness, -2 * wall_thickness, dim_inner_h / 2 ]) cube([
//            dim_inner_w + 4 * wall_thickness, dim_inner_l + 4 * wall_thickness, dim_inner_h / 2 + 2 * wall_thickness
//        ]);
//    }
//}

dim_inner_w = 30;
dim_inner_l = 60;
dim_inner_h = 10.5;
wall_thickness = 1;
tolerance = 0.2;
radius = 3;
box_top(dim_inner_w, dim_inner_l, dim_inner_h, wall_thickness, tolerance, radius);