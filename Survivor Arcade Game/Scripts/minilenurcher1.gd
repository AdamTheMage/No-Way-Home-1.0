extends CharacterBody2D

var direction = Vector2(1, 0.7)
var speed = 12

func _physics_process(_delta):
	velocity = direction * speed
	move_and_slide()

func _ready () :
	await get_tree().create_timer(4.75).timeout
	queue_free()
