extends CharacterBody2D

var speed = 25
var player = null
var player_chase = false

var health = 100
var player_inattack_zone = false
var can_take_damage = true

func _physics_process(delta):
	deal_with_damage()

	velocity = Vector2.ZERO

	if player_chase and player:
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * speed

		$AnimatedSprite2D.play("walk")

		if direction.x < 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false

	else:
		$AnimatedSprite2D.play("idle")

	move_and_slide()


func _on_detection_area_body_entered(body):
	print("detection started")
	if body.name == "player":
		player = body
		player_chase = true


func _on_detection_area_body_exited(body):
	if body == player:
		player = null
		player_chase = false

func deal_with_damage():
	if player_inattack_zone and global.player_current_attack == true:
		if can_take_damage == true:
			health = health - 20
			$take_damage_cooldown.start()
			can_take_damage = false
			print("slime health = ", health)
			if health <= 0:
				self.queue_free()


func _on_take_damage_cooldown_timeout() -> void:
	can_take_damage = true
	print("Cooldown reset")
	
func _on_enemy_hitbox_body_exited(body: Node2D) -> void:
	player_chase = true
	player_inattack_zone = false

func _on_enemy_hitbox_body_entered(body: Node2D) -> void:
	player_chase = false
	player_inattack_zone = true
