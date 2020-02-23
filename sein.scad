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

foot_width = 700/87;
foot_width_small = 300/87;
foot_depth = 850/87;
foot_height1 = 100/87;
foot_height2 = 100/87;

//color("blue")
//cube([main_beam_width, main_beam_depth, total_height]);

grid_beam_width = 0.3;
grid_beam_height = 0.5;
n_beams_y = 7; // y
n_beams_x = 9; // x

front_grid_width = 9.25;


color("grey")
main_beam(main_beam_width,main_beam_depth,main_beam_opening_depth,total_height,main_beam_step_width,main_beam_step_height,main_beam_opening_height);

translate([-13.75/2,0,total_height-17.25])
rotate(v=[1,0,0], a=90)
front_plate();


color("grey")
translate([0,main_beam_depth/2,0])
foot(foot_width = foot_width, foot_width_small = foot_width_small, foot_depth = foot_depth, foot_height1 = foot_height1, foot_height2 = foot_height2);

color("grey")
translate([0,-4,total_height-17.25-0.5])
translate([-13.75/2,0,0])
front_grid(grid_beam_width, grid_beam_height, n_beams_y, n_beams_x,front_grid_width);
