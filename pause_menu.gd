extends CanvasLayer

func _process(delta):
	testEsc()
	
func _ready() -> void:
	$AnimationPlayer.play("RESET")
	hide()
	

func resume():
	hide()
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")
	
	
func pause():
	show()
	get_tree().paused = true
	$AnimationPlayer.play("blur")
	
	
func testEsc():
	if Input.is_action_just_pressed("escape") and get_tree().paused == false:
		pause()
	elif Input.is_action_just_pressed("escape") and get_tree().paused == true:
		resume()


func _on_resume_pressed() -> void:
	resume()


func _on_restart_pressed() -> void:
	resume()
	GameManager.time_survived = 0.0
	GameManager.game_won = false
	get_tree().reload_current_scene()


func _on_quit_pressed() -> void:
	get_tree().quit()
