extends CharacterBody2D

var speed = 100
var direction = Vector2()

func _ready():
	randomize()
	set_random_direction()
	# Start with an idle animation
	$AnimatedSprite2D.play("idle")

func _physics_process(delta):
	# Move the character
	velocity = direction * speed
	move_and_slide()

	# Check bounds and change direction if necessary
	var screen_size = get_viewport_rect().size
	if position.x < 0 or position.x > screen_size.x:
		direction.x = -direction.x
	if position.y < 0 or position.y > screen_size.y:
		direction.y = -direction.y

func _on_AnimatedSprite2D_animation_finished():
	# Pick a random animation to play next
	var animations = ["idle", "walkleft"]
	$AnimatedSprite2D.play(animations[randi() % animations.size()])

func set_random_direction():
	direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
