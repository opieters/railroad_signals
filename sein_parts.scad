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

module front_plate_straight_corners(total_w=13.75, partial_w=9.25, partial_h=7.75, corner_h=4.89, total_h=17.25, th=2) {
    linear_extrude(th, convexity = 10){
        // draw display plate in 2D
        polygon(points=[
            [0,0],
            [0,total_h],
            [total_w, total_h],
            [total_w, total_h-corner_h],
            [partial_w, partial_h],
            [partial_w, 0],
            ]);
    }
}

module beam() {
    total_height = 47;
n_steps = 15;
main_beam_width = 4; // TODO: check
main_beam_depth = 2; // TODO: check

step_depth = 0.75;
step_width = 5;
step_side_depth = 5;
step_support_size = 0.5;
    // draw main beam
//translate([])
translate([-main_beam_width/2, -main_beam_depth, 0]) // center beam
cube([main_beam_width, main_beam_depth, total_height], center=false);

// draw steps
//   draw side beams of support
translate([-main_beam_width/2, -step_side_depth+step_support_size, 0])
cube([step_support_size, step_support_size, total_height], center=false);

translate([-step_support_size+main_beam_width/2, -step_side_depth+step_support_size, 0])
cube([step_support_size, step_support_size, total_height], center=false);

//   draw steps
module draw_step() {
    translate([step_width/2, 0, 0])
    translate([-step_depth/2,-step_side_depth/2,step_depth/2])
    cube([step_depth, step_side_depth, step_depth], center=true);

    translate([-step_width/2, 0, 0])
    translate([step_depth/2,-step_side_depth/2,step_depth/2])
    cube([step_depth, step_side_depth, step_depth], center=true);

    translate([0,-step_side_depth,0])
    translate([-step_width/2,0,0])
    cube([step_width, step_depth, step_depth],center=false);
}

for(i = [0:n_steps-1]) {
    translate([0,0,total_height - (n_steps-1)*total_height/n_steps - step_depth])
    translate([0,0,i*total_height/n_steps])
    draw_step();
}

translate([0,-2.5,0])
cube([5,5,5],center=true);
}

module front_plate() {
    color("grey")
    difference() {
        union(){
            front_plate_straight_corners(total_w=13.75, partial_w=9.25, partial_h=7.75, corner_h=4.89, total_h=17.25, th=2);

            // draw 5 light caps
            for(i = [1:4]) {
                translate([3.45, i*3.45, 0])
                light_cap();
            }

            translate([10.3, 13.8])
            light_cap();
        }

        // cut holes in display plate
        for(i = [1:4]) {
            translate([3.45, i*3.45, 0])
            cylinder(h=40,r=1.05,center=true);
        }

        translate([10.3, 13.8])
        cylinder(h=40,r=1.05,center=true);

    }

    color("black")
    translate([2*3.45, 3.45,2])
    handle();



    //translate(-[13.75, 17.25,0]/2)
    //front_plate_rounded_corners(total_w=13.75, partial_w=9.25, partial_h=7.75, corner_r=3.45, total_h=17.25, th=2);
    color("white")
    difference(){
        translate([0.5, 0.5, 0])
        front_plate_rounded_corners(total_w=13.75-1, partial_w=9.25-1, partial_h=7.75-0.5, corner_r=3.45-0.5, total_h=17.25-1, th=2.2);

        translate([1, 1, -0.5])
        front_plate_rounded_corners(total_w=13.75-2, partial_w=9.25-2, partial_h=7.75-1, corner_r=3.45-1, total_h=17.25-2, th=4);
    }
}

module foot(foot_width = 700/87, foot_width_small = 300/87, foot_depth = 850/87, foot_height1 = 100/87, foot_height2 = 100/87) {

    union() {
        translate([0,0,foot_height1])
        linear_extrude(height = foot_height1, scale = foot_width_small/foot_width)
        translate(-[foot_width,foot_depth]/2)
        square([foot_width,foot_depth]);

        linear_extrude(height = foot_height2)
        translate(-[foot_width,foot_depth]/2)
        square([foot_width,foot_depth]);
    }
}

module main_beam(main_beam_width,main_beam_depth,main_beam_opening_depth,total_height,main_beam_step_width,main_beam_step_height,main_beam_opening_height) {
    translate([-main_beam_width/2,0,0]){
        cube([main_beam_width, (main_beam_depth-main_beam_opening_depth)/2, total_height]);
        translate([0, main_beam_opening_depth+(main_beam_depth-main_beam_opening_depth)/2, 0])
        cube([main_beam_width, (main_beam_depth-main_beam_opening_depth)/2, total_height]);

        for(i = [0:11]) {
        translate([(main_beam_width-main_beam_step_width)/2,0,total_height-main_beam_step_height-i*main_beam_opening_height])
        cube([main_beam_step_width,main_beam_depth, main_beam_step_height]);
        }
    }
}

module front_grid(grid_beam_width, grid_beam_height, n_beams_y, n_beams_x,front_grid_width) {
    grid_spacing = (front_grid_width - grid_beam_width*n_beams_x) / (n_beams_x-1);

    translate(-[0,grid_beam_width,0])
    translate(-[0,(grid_spacing+grid_beam_width)*(n_beams_y-1),0])
    union() {
        for(i = [0:n_beams_y-1]) {
            translate([0,(grid_spacing+grid_beam_width)*i,0])
            cube([grid_spacing*(n_beams_x-1)+grid_beam_width*n_beams_x,grid_beam_width,grid_beam_height]);
        }

        for(i = [0:n_beams_x-1]) {
            translate([(grid_spacing+grid_beam_width)*i,0,0])
            cube([grid_beam_width,grid_spacing*(n_beams_y-1)+grid_beam_width*n_beams_y,grid_beam_height]);
        }
    }
}

module grid_support_beam(grid_support_width, grid_support_width2, grid_support_height, grid_support_height2, grid_support_length){
    rotate(v=[0,1,0],a=180) {
        difference() {
            translate([-grid_support_width2/2,0,0])
            cube([grid_support_width2, grid_support_length, grid_support_height2]);
            translate([-grid_support_width/2,-grid_support_length,(grid_support_width2-grid_support_width)/2])
            cube([grid_support_width, 3*grid_support_length, grid_support_height]);
        }
    }
}