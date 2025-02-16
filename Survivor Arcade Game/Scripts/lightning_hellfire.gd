extends Area2D

func _ready () :
	%warninganimation.play("warning")

func _on_body_entered(body):
	if body.has_method("take_lightninghellfire_damage"):
		body.take_lightninghellfire_damage()
		%Fried.visible = true
		%FriedPlayer.play("fried")

func lightningburrow1() :
	const burrowing = preload("res://Survivor Arcade Game/Scenes/lightning_burrow.tscn")
	var new_burrowing = burrowing.instantiate()
	new_burrowing.global_position = %lightninganimation.global_position - Vector2(0,-25)
	get_node("/root/Game").add_child(new_burrowing)

func lightningburrow2() :
	const burrowing = preload("res://Survivor Arcade Game/Scenes/lightning_burrow.tscn")
	var new_burrowing = burrowing.instantiate()
	new_burrowing.global_position = %lightninganimation.global_position - Vector2(0,-15)
	get_node("/root/Game").add_child(new_burrowing)
	
func lightningburrow3() :
	const burrowing = preload("res://Survivor Arcade Game/Scenes/lightning_burrow.tscn")
	var new_burrowing = burrowing.instantiate()
	new_burrowing.global_position = %lightninganimation.global_position - Vector2(0,-5)
	get_node("/root/Game").add_child(new_burrowing)
	
func lightningburrow4() :
	const burrowing = preload("res://Survivor Arcade Game/Scenes/lightning_burrow.tscn")
	var new_burrowing = burrowing.instantiate()
	new_burrowing.global_position = %lightninganimation.global_position - Vector2(0,5)
	get_node("/root/Game").add_child(new_burrowing)

func _on_lightninghellfireended_timeout() :
	queue_free()


func _on_lightningburrowbegin_timeout() :
	lightningburrow1()
	lightningburrow2()
	lightningburrow3()
	lightningburrow4()


func _on_lightningbegin_timeout() :
	%lightningcollision.disabled = false
	%lightninganimation.visible = true
	var leftorright = int(round(randi_range(1, 2)))
	if leftorright == 1 :
		%lightninganimation.play("lightning")
	if leftorright == 2 :
		%lightninganimation.flip_h = 1
		%lightninganimation.play("lightning")
