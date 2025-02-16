extends Area2D

func _ready() :
	%Zapped.visible = false
	await get_tree().create_timer(0.8).timeout
	%CollisionShape2D.disabled = true
	await get_tree().create_timer(1.6).timeout
	queue_free()

func _on_body_entered(body) :
	if body.has_method("zapped") :
		body.zapped()
	if body.has_method("play_zapped_label") :
		body.play_zapped_label()
		%Zapped.visible = true
