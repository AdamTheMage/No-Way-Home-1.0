extends Area2D

func _ready () :
	%lightninganimation.play("lightningfield")
	await get_tree().create_timer(1.15).timeout
	%fieldcollision.disabled = true
	await get_tree().create_timer(0.85).timeout
	queue_free()

func _on_body_entered(body):
	if body.has_method("take_lightninghellfire_damage"):
		body.take_lightninghellfire_damage()
		# %Fried.visible = true
		# %FriedPlayer.play("fried")
