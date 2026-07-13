module fix_point_slot() {
    inside_pts = [
        [0, 8.5], [7.5, 8.5], [9, 8.5], [16, 8.5], [17.5, 8.5], [28.5, 8.5],
        [33.5, 3.5], [33.5, -3.5], [28.5, -8.5], [17.5, -8.5], [16, -8.5],
        [9, -8.5], [7.5, -8.5], [0, -8.5]
    ];

    outside_pts = [
        [0, 7], [7.5, 7], [9, 8.5], [16, 8.5], [17.5, 7], [28, 7],
        [32, 3], [32, -3], [28, -7], [17.5, -7], [16, -8.5], [9, -8.5],
        [7.5, -7], [0, -7]
    ];

    z_dist = 2.2;
    eps = 0.01;
    center_in = [
        (inside_pts[0][0] + inside_pts[7][0]) / 2,
        (inside_pts[0][1] + inside_pts[7][1]) / 2
    ];
    center_out = [
        (outside_pts[0][0] + outside_pts[7][0]) / 2,
        (outside_pts[0][1] + outside_pts[7][1]) / 2
    ];

    translate([1.99, 0, 0])
    rotate([0, -90, 0]) {
        union() {
            for (i = [0 : len(inside_pts)-1]) {
                next = (i + 1) % len(inside_pts);

                hull() {
                    translate([center_in[0], center_in[1], 0]) cube(eps);
                    translate([inside_pts[i][0], inside_pts[i][1], 0]) cube(eps);
                    translate([inside_pts[next][0], inside_pts[next][1], 0]) cube(eps);
                    
                    translate([center_out[0], center_out[1], z_dist]) cube(eps);
                    translate([outside_pts[i][0], outside_pts[i][1], z_dist]) cube(eps);
                    translate([outside_pts[next][0], outside_pts[next][1], z_dist]) cube(eps);
                }
            }
            
            linear_extrude(eps) polygon(inside_pts);
            translate([0, 0, z_dist]) linear_extrude(eps) polygon(outside_pts);
        }
    }
}

// fix_point_slot();