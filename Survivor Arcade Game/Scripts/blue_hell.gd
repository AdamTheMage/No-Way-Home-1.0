extends Area2D

func _physics_process(delta):
	position += Vector2(0,-1) * 5 * delta
	await get_tree().create_timer(0.4).timeout
	position -= Vector2(0,-1) * 5 * delta
	position += Vector2(-1,0) * 5 * delta
	await get_tree().create_timer(0.4).timeout
	position -= Vector2(-1,0) * 5 * delta
	position += Vector2(0,1) * 5 * delta
	await get_tree().create_timer(0.4).timeout
	position -= Vector2(0,1) * 5 * delta
	position += Vector2(1,0) * 5 * delta
	await get_tree().create_timer(0.4).timeout
	position -= Vector2(1,0) * 5 * delta
	position += Vector2(0,-1) * 5 * delta
	await get_tree().create_timer(0.4).timeout
	position -= Vector2(0,-1) * 5 * delta
	position += Vector2(-1,0) * 5 * delta
	await get_tree().create_timer(0.4).timeout
	position -= Vector2(-1,0) * 5 * delta
	position += Vector2(0,1) * 5 * delta
	
	
func _ready () :
	var leftorright = int(round(randi_range(1, 2)))
	if leftorright == 1 :
		%bluehellanimation.play("bluehellright")
	if leftorright == 2 :
		%bluehellanimation.play("bluehellleft")

func _on_body_entered(body):
	if body.has_method("take_bluehell_damage"):
		body.take_bluehell_damage()
		%BurntPlayer.play("burnt")
		%Burnt.visible = true


func _on_bluehellended_timeout() :
	queue_free()
