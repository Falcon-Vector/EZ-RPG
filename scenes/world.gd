extends Node2D

@onready var background_world: AudioStreamPlayer = $background_world

func _ready():
	if global.game_first_loadin == true:
		$player.position.x = global.player_start_posx
		$player.position.y = global.player_start_posy
	else:
		$player.position.x = global.player_exit_cliffside_posx
		$player.position.y = global.player_exit_cliffside_posy

func _process(_delta):
	change_scene()


func _on_cliffside_transition_point_body_entered(body: Node2D) -> void:
		print("entered")
		global.transition_scene = true


func _on_cliffside_transition_point_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		global.transition_scene = false
		
func change_scene():
	if global.transition_scene == true:
		if global.current_scene == "world":
			get_tree().change_scene_to_file("res://cliff_side.tscn")
			global.game_first_loadin = false
			global.finish_changescenes()
			
		
