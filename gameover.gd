extends CanvasLayer


func _ready() -> void:
	pass 

func _process(delta: float) -> void:
	pass


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_retry_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/world.tscn")
