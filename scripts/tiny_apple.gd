extends Sprite2D

var rng = RandomNumberGenerator.new()
signal apple_eaten
signal apple_created

func _ready():
	get_node(".").visible = false

func _on_apple_icon_pressed() -> void:
	var random = rng.randf_range(-100, 100)
	get_node(".").position.x = random
	get_node(".").visible = true
	apple_created.emit()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if get_node(".").visible == true:
		apple_eaten.emit()
		await get_tree().create_timer(1.0).timeout
		get_node(".").visible = false
	
