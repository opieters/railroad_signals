$fn = 100;

include <sein_parts.scad>

total_height = 47;
n_steps = 15;
main_beam_width = 4; // TODO: check
main_beam_depth = 2; // TODO: check

step_depth = 0.75;
step_width = 5;
step_side_depth = 5;
step_support_size = 0.5;
/*
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
*/

color("grey")
difference() {
    union(){
        linear_extrude(dp_th, convexity = 10){
            // draw display plate in 2D
            polygon(points=[
                [0,0],
                [0,17.25],
                [13.75, 17.25],
                [13.75, 17.25-4.89],
                [9.25, 7.75],
                [9.25, 0],
                ]);
        }

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

