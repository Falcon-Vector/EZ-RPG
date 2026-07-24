extends Node2D

@onready var background_cliff: AudioStreamPlayer = $background_cliff

func _ready() -> void:
	background_cliff.play()

func _process(delta: float) -> void:
	change_scenes()

func _on_cliffside_exitpoint_body_entered(body: Node2D) -> void:
	global.transition_scene = true

func _on_cliffside_exitpoint_body_exited(body: Node2D) -> void:
	global.transition_scene = false
		
func change_scenes():
	if global.transition_scene == true:
		if global.current_scene == "cliff_side":
			get_tree().change_scene_to_file("res://scenes/world.tscn")
			global.finish_changescenes()
			
		
		
