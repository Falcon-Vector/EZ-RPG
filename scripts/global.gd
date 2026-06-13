extends Node2D

var player_current_attack = false

var current_scene = "world" #world cliff_side
var transition_scene = false

var player_exit_cliffside_posx = 202.0
var player_exit_cliffside_posy = 2.0
var player_start_posx = 53.0
var player_start_posy = 78.0

var game_first_loadin = true

func finish_changescenes():
	if transition_scene == true:
		transition_scene = false
		if current_scene == "world":
			current_scene = "cliff_side"
		else:
			current_scene = "world"
			

			
		
	
