include <BOSL2/std.scad>;

module snap() {
    module small_hex() {
        polygon([
            [-4.38, -10.57],
            [-10.57, -4.38],
            [-10.57, 4.38],
            [-4.38, 10.57],
            [4.38, 10.57],
            [10.57, 4.38],
            [10.57, -4.38],
            [4.38, -10.57]
        ]);
    }

    module big_hex() {
        polygon([
            [-4.73, -11.43],
            [-11.43, -4.73],
            [-11.43, 4.73],
            [-4.73, 11.43],
            [4.73, 11.43],
            [11.43, 4.73],
            [11.43, -4.73],
            [4.73, -11.43]
        ]);
    }

    module prong() {
        translate([1.5, 10.57, 0])
        yrot(-90)
        linear_extrude(3)
        polygon([
            [0, 0],
            [0.6, 0.48],
            [1, 0.48],
            [2.24, 0]
        ]);
    }

    module slot() {
        translate([-3.58, 8.97, -0.01]) cube([7.16, 0.8, 3.41]);
        translate([-3.58, 8.97, 2.4]) cube([7.16, 1.61, 1]);
    }

    module body() {
        union() {
            linear_extrude(4) small_hex();

            hull() {
                translate([0, 0, 4]) linear_extrude(0.01) small_hex();
                translate([0, 0, 5.52]) linear_extrude(0.01) big_hex();
            }
        }
    }

    difference() {
        union() {
            body();
            prong();
            zrot(90) prong();
            zrot(180) prong();
            zrot(270) prong();
        }
        
        slot();
        zrot(90) slot();
        zrot(180) slot();
        zrot(270) slot();
    }
}

// snap();