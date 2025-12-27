extends CharacterBody2D


const SPEED = 100.0
var direction = "down"

func _physics_process(delta: float) -> void:
	player_movement(delta)
	
func player_movement(delta):
	var anim = $AnimatedSprite2D

	anim.flip_h = false

	velocity.x = 0
	velocity.y = 0
	
	if Input.is_action_pressed("ui_right"):
		velocity.x = SPEED
		anim.play("walk_side")
		direction = "right"
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -SPEED
		anim.flip_h = true
		anim.play("walk_side")
		direction = "left"
	elif Input.is_action_pressed("ui_down"):
		velocity.y = SPEED
		anim.play("walk_front")
		direction = "down"
	elif Input.is_action_pressed("ui_up"):
		velocity.y = -SPEED
		anim.play("walk_back")
		direction = "up"
	else:
		if direction == "left":
			anim.flip_h = true
			anim.play("idle_side")
		elif direction == "right":
			anim.play("idle_side")
		elif direction == "up":
			anim.play("idle_back")
		elif direction == "down":
			anim.play("idle_front")
				
	move_and_slide()
