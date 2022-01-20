$fs = 0.5/1;

include <../../lib/BOSL2/std.scad>

wallThickness = 2;
bottomThickness = 1;
lidSlop = 0.5;

// measurements in common
thickness = 6+0.2;
pieceThickness = 3+0.2;
width = 137+1;

// name = [height, spare width, spare thickness]
w5 = [105, 30, pieceThickness];
w7 = [102, 22, pieceThickness];
i9 = [98, 28, pieceThickness];
o10 = [118, 31, pieceThickness];
b11 = [width, 40, thickness];
j16 = [width, 40, thickness];
j19 = [width, 40, thickness];
j29 = [width, 40, thickness];

//frame(j29);
fwd(width) lid(j29);

module frame(specs) {
	height = specs[0];
	spareWidth = specs[1];
	spareThickness = specs[2];

	difference() {
		cuboid([width+spareWidth+wallThickness*3, height+wallThickness*2, thickness+bottomThickness], anchor=LEFT+FRONT+BOTTOM);

		// frame space
		translate([wallThickness, wallThickness, bottomThickness])
			cuboid([width, height, thickness+0.1], anchor=LEFT+FRONT+BOTTOM);

		// piece space
		translate([width+wallThickness*2, wallThickness, thickness-spareThickness+bottomThickness])
			cuboid([spareWidth, height, spareThickness+0.1], anchor=LEFT+FRONT+BOTTOM);

		// lid protrusions
		translate([(width+spareWidth+wallThickness*3)/2, wallThickness/3, wallThickness/3]) {
			wedge([width/2+wallThickness*2, wallThickness/3*2, wallThickness/3*2], true);
			back(height+wallThickness*2-wallThickness/3*2)
				zrot(180)
					wedge([width/2+wallThickness*2, wallThickness/3*2, wallThickness/3*2], true);
		}
	}
}

module lid(specs) {
	height = specs[0];
	spareWidth = specs[1];
	spareThickness = specs[2];

	difference() {
		union() {
			difference() {
				cuboid([width+spareWidth+wallThickness*5, height+wallThickness*4, thickness+bottomThickness*2], anchor=LEFT+FRONT+BOTTOM);
				// frame space
				translate([wallThickness, wallThickness, bottomThickness])
					cuboid([width+spareWidth+wallThickness*3+lidSlop*2, height+wallThickness*2+lidSlop*2, thickness+bottomThickness+0.1], anchor=LEFT+FRONT+BOTTOM);
			}

			// lid protrusions
			translate([(width+spareWidth+wallThickness*5)/2, wallThickness+wallThickness/4, thickness+bottomThickness*2-wallThickness/4]) {
				yrot(180)
					wedge([width/2, wallThickness/2, wallThickness/2], true);
				back(height+wallThickness*2)
					rot([0, 180, 180])
						wedge([width/2, wallThickness/2, wallThickness/2], true);
			}
		}
	}
}
