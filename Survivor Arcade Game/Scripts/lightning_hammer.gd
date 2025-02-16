extends Area2D

var direction = 0
var randomexplosion = 0.0
var speed = 0.0

func _ready () :
	%hammeranimation.play("hammerfall")
	randomexplosion = (randf_range(1.75, 5))
	await get_tree().create_timer(randomexplosion).timeout
	lightning_field() 
	queue_free()

func _physics_process(delta):
	speed = (randf_range(45, 70))
	
	
	direction = Vector2(0, 1).rotated(rotation)
	
	position += direction * speed * delta
	

func _on_body_entered(body):
	if body.has_method("take_lightninghellfire_damage"):
		print ("hit")
		body.take_lightninghellfire_damage()
		body.play_crushed()
		# %Fried.visible = true
		# %FriedPlayer.play("fried")

func lightning_field() :
	const lightningfield = preload("res://Survivor Arcade Game/Scenes/lightning_field.tscn")
	var new_lightningfield = lightningfield.instantiate()
	new_lightningfield.global_position = %hammeranimation.global_position - Vector2(0,0)
	get_node("/root/Game").add_child(new_lightningfield)
