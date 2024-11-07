extends CharacterBody2D

const Speed = 40
var Direction = -1
var Random
var timer := Timer.new()

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
	timer.one_shot = true
	timer.start()

func _physics_process(_delta):
	if velocity.x == 0: 
		Direction = Direction * -1
	
	velocity.x = Direction * Speed
	
	if velocity.x == 0:
		$AnimatedSprite2D.play('idle')
	elif velocity.x < 0:
		$AnimatedSprite2D.play('walkleft')
	else:
		$AnimatedSprite2D.play('walkright')
	
	move_and_slide()
	

func _on_Timer_timeout():
	randomize()
	Random = randi_range(0,2)
	
	if Random == 0:
		Direction = 0
	
	if Random == 1:
		Direction = -1
	
	if Random == 2:
		Direction = 1
	
	timer.start()
