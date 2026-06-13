extends CharacterBody2D
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var enemy_inattack_range = false
var enemy_attack_cooldown = true
var health = 100
var player_alive = true

var attack_ip = false

const speed = 70
var current_dir = "down"

func _ready():
	pass
	
func _physics_process(delta):
	if not global.player_current_attack:
		player_movement(delta)
	enemy_attack()
	attack()
	
	if health <= 0:
		player_alive = false
		health = 0
		print("you have died!")
		self.queue_free()
		
func player_movement(_delta):
		if Input.is_action_pressed("d"):
			current_dir = "right"
			play_anim(1)
			velocity.x = speed
			velocity.y = 0
		elif Input.is_action_pressed("a"):
			current_dir = "left"
			play_anim(1)
			velocity.x = -speed
			velocity.y = 0
		elif Input.is_action_pressed("s"):
			current_dir = "down"
			play_anim(1)
			velocity.y = speed
			velocity.x = 0
		elif Input.is_action_pressed("w"):
			current_dir = "up"
			play_anim(1)
			velocity.y = -speed
			velocity.x = 0
		else:
			play_anim(0)
			velocity.x = 0
			velocity.y = 0
			
		move_and_slide()
		
func play_anim(movement):
	var dir = current_dir
	var anim = sprite
	

	if dir == "right":
		anim.flip_h = false
		if movement == 1:
			anim.play("side_walk")
		else:
			if attack_ip == false:
				anim.play("side_idle")

	elif dir == "left":
		anim.flip_h = true
		if movement == 1:
			anim.play("side_walk")
		else:
			if attack_ip == false:
				anim.play("side_idle")

	elif dir == "down":
		anim.flip_h = false
		if movement == 1:
			anim.play("front_walk")
		else:
			if attack_ip == false:
				anim.play("front_idle")

	elif dir == "up":
		anim.flip_h = false
		if movement == 1:
			anim.play("back_walk")
		else:
			if attack_ip == false:
				anim.play("back_idle")

func enemy_attack():
	if enemy_inattack_range and enemy_attack_cooldown == true:
		health = health - 20
		enemy_attack_cooldown = false
		$attack_cooldown.start()
		print(health)
		$AnimatedSprite2D.modulate = Color("#ff503f")
		$make_red.start()


func _on_player_hitbox_area_entered(area: Area2D) -> void:
		enemy_inattack_range = true


func _on_player_hitbox_area_exited(area: Area2D) -> void:
		enemy_inattack_range = false


func _on_attack_cooldown_timeout() -> void:
	enemy_attack_cooldown = true

func attack():
	var dir = current_dir
	
	if Input.is_action_just_pressed("attack"):
		global.player_current_attack = true
		attack_ip = true
		if dir == "right":
			sprite.flip_h = false
			sprite.play("side_attack")
			$deal_attack_timer.start()
		if dir == "left":
			sprite.flip_h = true
			sprite.play("side_attack")
			$deal_attack_timer.start()
		if dir == "down":
			sprite.play("front_attack")
			$deal_attack_timer.start()
		if dir == "up":
			sprite.play("back_attack")
			$deal_attack_timer.start()
			


func _on_deal_attack_timer_timeout():
	$deal_attack_timer.stop()
	global.player_current_attack = false
	attack_ip = false
	

func _on_make_red_timeout() -> void:
	sprite.modulate = Color.WHITE

func current_camera():
	if global.current_scene == "world":
		$world_camera.enabled = true
		$cliffside_camera.enabled = false
	elif global.current_scene == "cliff_side":
		$world_camera.enabled = false
		$cliffside_camera.enabled = true
		
