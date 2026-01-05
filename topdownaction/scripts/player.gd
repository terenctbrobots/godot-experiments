extends CharacterBody2D

const SPEED = 100.0
var direction = "down"
var attack = false

#func _physics_process(delta: float) -> void:
func _process(delta: float) -> void:
	move_and_slide()
	player_movement(delta)
	player_attack(delta)
	
func player_movement(delta):
	if attack == true:
		return
		
	var anim = $AnimatedSprite2D
	
	if Input.is_action_pressed("right"):
		velocity.x = SPEED
		velocity.y = 0
		anim.flip_h = false
		anim.play("walk_side")
		direction = "right"
	elif Input.is_action_pressed("left"):
		velocity.x = -SPEED
		velocity.y = 0
		anim.flip_h = true
		anim.play("walk_side")
		direction = "left"
	elif Input.is_action_pressed("down"):
		velocity.x = 0
		velocity.y = SPEED
		anim.flip_h = false
		anim.play("walk_front")
		direction = "down"
	elif Input.is_action_pressed("up"):
		velocity.x = 0
		velocity.y = -SPEED
		anim.flip_h = false
		anim.play("walk_back")
		direction = "up"
	else:
		velocity = Vector2.ZERO
		
		if direction == "left":
			anim.flip_h = true
			anim.play("idle_side")
		elif direction == "right":
			anim.flip_h = false
			anim.play("idle_side")
		elif direction == "up":
			anim.flip_h = false
			anim.play("idle_back")
		elif direction == "down":
			anim.flip_h = false
			anim.play("idle_front")
			
func player_attack(delta):
	var anim = $AnimatedSprite2D

	if Input.is_action_just_pressed("attack") and not attack:
		velocity = Vector2.ZERO
		attack = true
		$Timer.start()
		if direction == "left":
			anim.flip_h = true
			anim.play("attack_side")
		elif direction == "right":
			anim.flip_h = false
			anim.play("attack_side")
		elif direction == "up":
			anim.flip_h = false
			anim.play("attack_back")
		else:
			anim.flip_h = false
			anim.play("attack_front")
		
func _on_timer_timeout() -> void:
	attack = false
