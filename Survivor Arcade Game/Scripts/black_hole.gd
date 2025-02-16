extends Area2D

@onready var player = get_node("/root/Game/PlayerCharacter")

func _ready() :
	await get_tree().create_timer(5.25).timeout
	queue_free()

func _on_body_entered(body) :
	if player.isblackholed == false :
		if body.has_method("blackholed") :
			body.blackholed()
			randomize()
			var randx = 0.0
			var randy = 0.0
			var posx = randi_range(1, 2)
			var posy = randi_range(1, 2)
			if posx == 1 :
				randx = randf_range(-150 , -75)
			elif posx == 2 :
				randx = randf_range(150 , 75)
			if posy == 1 :
				randy = randf_range(150 , 75)
			if posy == 2 :
				randy = randf_range(-150 , -75)
			body.position += Vector2(randx, randy)
			
		#if body.has_method("play_zapped_label") :
			#body.play_zapped_label()
			#%Zapped.visible = true
