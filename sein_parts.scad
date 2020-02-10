handle_d = 0.17;
handle_h = 0.7;
handle_r = 0.43;
handle_l = 10.35;
handle_m = 0.1;

// lower connection point centered at (0,0,0)
module handle() {
    translate([0,handle_r,0])
    rotate(v=[0,1,0],a=-90)
    translate([handle_h-handle_r,0,0]){
        translate([0,handle_l-2*handle_r,0])
        intersection() {
            rotate_extrude(angle=360)
            translate([handle_r, 0, 0])
            circle(r = handle_d/2);

            translate([0,0,-handle_d])
            cube(2*handle_r);

        }

        rotate(v=[0,0,1],a=-90)
        intersection() {
            rotate_extrude(angle=360)
            translate([handle_r, 0, 0])
            circle(r = handle_d/2);

            translate([0,0,-handle_d])
            cube(2*handle_r);

        }

        translate([handle_r,0,0])
        rotate(v=[1,0,0], a=-90)
        cylinder(r=handle_d/2,h=handle_l-2*handle_r);

        translate([0,-handle_r,0])
        rotate(v=[0,1,0],a=-90)
        cylinder(r=handle_d/2,h=handle_h-handle_r+handle_m);

        translate([0,handle_l-handle_r,0])
        rotate(v=[0,1,0],a=-90)
        cylinder(r=handle_d/2,h=handle_h-handle_r+handle_m);
    }
}

light_cap_r = 1.15;
light_cap_h = 5;
light_cap_th = 0.1;
light_cap_a = 30;

dp_th = 2;

// draw one light cap centered at (0,0) in +z direction
module light_cap() {
    rotate(v=[0,0,1],a=180)
    difference(){
        difference(){
            // draw main cylinder
            cylinder(h=light_cap_h,r=light_cap_r,center=false);

            // cut slope
            translate([-light_cap_r, light_cap_r, 0])
            rotate(v=[1, 0, ], a=light_cap_a)
            cube([2*light_cap_r,10*light_cap_r,2*light_cap_h]);
        }

    // cut opening
    cylinder(h=2*light_cap_h,r=light_cap_r - light_cap_th,center=true);
    }
}

module front_plate_rounded_corners(total_w=13.75, partial_w=9.25, partial_h=7.75, corner_r=3.45, total_h=17.25, th=2) {
linear_extrude(height=th)
translate([0,corner_r,0])
union() {

square([partial_w, total_h-2*corner_r]);

translate([corner_r,0,0])
rotate(v=[0,0,1], a=180)
intersection(){
    square(2*corner_r);
circle(r=corner_r);
}

//translate([3.45,0,0])
translate([partial_w-corner_r,0,0])
rotate(v=[0,0,1], a=-90)
intersection(){
    square(2*corner_r);
circle(r=corner_r);
}

translate([corner_r,total_h-2*corner_r,0])
rotate(v=[0,0,1], a=90)
intersection(){
    square(2*corner_r);
circle(r=corner_r);
}

translate([corner_r,-corner_r,0])
square([partial_w-2*corner_r, corner_r]);

translate([corner_r, total_h-2*corner_r, 0])
square([partial_w-corner_r, corner_r]);

rico = [for(i = [0:360-1:200]) -cos(i) / sin(i)];
c = [for(i = [0:360-1:200]) [(total_w-corner_r + corner_r*cos(i)), total_h-corner_r+corner_r*sin(i)]];
rhs = [for(i = [0:360-1:200]) abs(rico[i]*(partial_w - c[i][0]) + c[i][1] - partial_h)];
min_value = min(rhs);
for(i = [0:360-1:200]){
    if(rhs[i]==min_value){
        a = i;
        echo(a);
        a = 316;

        polygon([
            [partial_w, partial_h-corner_r],
            [total_w-corner_r+corner_r*cos(a), total_h-2*corner_r+corner_r*sin(a)],
            [total_w-corner_r, total_h-2*corner_r+corner_r],
            [partial_w, total_h-2*corner_r+corner_r],
        ]);

        difference(){
            translate([total_w-corner_r,total_h-2*corner_r,0])
            circle(r=corner_r);
            square([15, total_h-2*corner_r+corner_r*sin(a)]);
        }
    }
}
//rico = - cos(theta) / sin(theta);

// this is optimised iteratively

}
}