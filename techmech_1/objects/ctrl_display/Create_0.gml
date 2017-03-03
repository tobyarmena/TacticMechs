/// @description Insert description here
// You can write your code in this editor
show_debug_overlay(true)

camera = camera_create_view(0, 0, 1024, 768, 0, -1, -1, -1, 32, 32);
view_set_camera(0, camera);

zoom_level = 1;

default_zoom_width = camera_get_view_width(view_camera[0]);
default_zoom_height = camera_get_view_height(view_camera[0]);