$fn = 100;

include <sein_parts.scad>

total_height = 47;
n_steps = 15;
main_beam_width = 1.40;
main_beam_depth = 2.5;
main_beam_opening_depth = 1.50;
main_beam_opening_height = 4.00;
main_beam_step_height = 1.03;
main_beam_step_width = 1.2;

step_depth = 0.75;
step_width = 5;
step_side_depth = 5;
step_support_size = 0.5;

//color("blue")
//cube([main_beam_width, main_beam_depth, total_height]);

translate([-main_beam_width/2,0,0]){
    cube([main_beam_width, (main_beam_depth-main_beam_opening_depth)/2, total_height]);
    translate([0, main_beam_opening_depth+(main_beam_depth-main_beam_opening_depth)/2, 0])
    cube([main_beam_width, (main_beam_depth-main_beam_opening_depth)/2, total_height]);

    for(i = [0:10]) {
    translate([(main_beam_width-main_beam_step_width)/2,0,total_height-main_beam_step_height-i*main_beam_opening_height])
    cube([main_beam_step_width,main_beam_depth, main_beam_step_height]);
    }
}

translate([-13.75/2,0,total_height-17.25])
rotate(v=[1,0,0], a=90)
front_plate();

