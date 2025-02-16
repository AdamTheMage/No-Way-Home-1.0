extends Area2D

var travelled_distance = 0

@onready var player = get_node("/root/Game/PlayerCharacter")
@onready var Burrow = get_node("/root/Game/LightningBurrow")

func _ready () :
	
	%BurrowingAnimation.play("burrowing")
	await get_tree().create_timer(0.5).timeout
	%BurrowingAnimation.play("burrowing")
	await get_tree().create_timer(0.5).timeout
	%BurrowingAnimation.play("burrowing")
	await get_tree().create_timer(0.5).timeout
	%BurrowingAnimation.play("burrowing")
	await get_tree().create_timer(0.5).timeout
	%BurrowingAnimation.play("burrowing")
	await get_tree().create_timer(0.5).timeout
	%BurrowingAnimation.play("burrowing")
	await get_tree().create_timer(0.5).timeout
	%BurrowingAnimation.play("burrowing")
	await get_tree().create_timer(0.5).timeout
	%BurrowingAnimation.play("burrowing")
	await get_tree().create_timer(0.5).timeout
	%BurrowingAnimation.play("burrowing")

func _physics_process(delta):
	const RANGE = 151
	var direction = Vector2(1, 0).rotated(rotation)
	
	look_at(player.global_position)
	direction = global_position.direction_to(player.global_position)
	
	position += direction * 15 * delta
	
	travelled_distance += 75 * delta
	
	if travelled_distance > RANGE :
		queue_free()


func _on_body_entered(body):
	if body.has_method("take_lightninghellfire_damage"):
		body.take_lightninghellfire_damage()
		queue_free()
