extends Area2D

var travelled_distance = 0


func _physics_process(delta):
	const RANGE = 600
	
	var direction = Vector2(1, 0).rotated(rotation)
	position += direction * 50 * delta
	
	travelled_distance += 100 * delta
	
	if travelled_distance > RANGE :
		queue_free()


func _on_body_entered(body):
	queue_free()
	if body.has_method("take_heavydamage"):
		body.take_heavydamage()
