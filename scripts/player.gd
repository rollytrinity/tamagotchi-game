extends CharacterBody2D

const Speed = 40
var Direction = -1
var Random
var timer := Timer.new()
var eating = false

func _ready():
	
	randomize()
	Random = randi_range(0,2)
	
	if Random == 0:
		Direction = 0
	
	if Random == 1:
		Direction = -1
	
	if Random == 2:
		Direction = 1
	
	timer = $Timer
	timer.timeout.connect(_on_Timer_timeout)
	timer.start()

func _physics_process(_delta):
	# turn chicken around at boundaries
	var chicken = get_node(".")
	var food = get_node("../tiny_apple")
	
	if chicken.position.x < -100 or chicken.position.x > 100: 
		Direction = Direction * -1
	
	# set speed of the lad
	velocity.x = Direction * Speed
	
	# pick the correct animation
	if velocity.x == 0 and eating == false:
		$AnimatedSprite2D.play('idle')
		
	elif velocity.x == 0 and eating == true and food.position.x < chicken.position.x:
		$AnimatedSprite2D.play('eatleft')
		await get_tree().create_timer(1.0).timeout
		eating = false
		timer.start()
		
	elif velocity.x == 0 and eating == true and food.position.x > chicken.position.x:
		$AnimatedSprite2D.play('eatright')
		await get_tree().create_timer(1.0).timeout
		eating = false
		timer.start()
		
	elif velocity.x < 0:
		$AnimatedSprite2D.play('walkleft')
	else:
		$AnimatedSprite2D.play('walkright')
	
	move_and_slide()
	
func setRandomDirection():
	randomize()
	Random = randi_range(0,2)
	
	if Random == 0:
		Direction = 0
	
	if Random == 1:
		Direction = -1
	
	if Random == 2:
		Direction = 1
		
func _on_Timer_timeout():
	setRandomDirection()
	timer.start()


func _on_tiny_apple_apple_eaten() -> void:
	Direction = 0
	eating = true


func _on_tiny_apple_apple_created() -> void:
	timer.stop()
	
	var food = get_node("../tiny_apple")
	var chicken = get_node(".")
	
	if food.position.x > chicken.position.x:
		Direction = 1
	else:
		Direction = -1
