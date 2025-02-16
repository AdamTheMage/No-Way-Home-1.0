extends Camera2D

# CameraShake


func _on_player_character_camerashake() :
	offset.x = 0
	offset.y = 0
	await get_tree().create_timer(0.05).timeout
	offset.x = 1
	offset.y = 0
	await get_tree().create_timer(0.05).timeout
	offset.x = 0
	offset.y = 0
	await get_tree().create_timer(0.05).timeout
	offset.x = -1
	offset.y = 0
	await get_tree().create_timer(0.05).timeout
	offset.x = -1
	offset.y = -1
	await get_tree().create_timer(0.05).timeout
	offset.x = 0
	offset.y = -1
	await get_tree().create_timer(0.05).timeout
	offset.x = 1
	offset.y = -1
	await get_tree().create_timer(0.05).timeout
	await get_tree().create_timer(0.05).timeout
	offset.x = 1
	offset.y = 0
	await get_tree().create_timer(0.05).timeout
	offset.x = 0
	offset.y = 0
	await get_tree().create_timer(0.05).timeout
	offset.x = -1
	offset.y = 0
	await get_tree().create_timer(0.05).timeout
	offset.x = -1
	offset.y = -1
	await get_tree().create_timer(0.05).timeout
	offset.x = 0
	offset.y = -1
	await get_tree().create_timer(0.05).timeout
	offset.x = 1
	offset.y = -1
	await get_tree().create_timer(0.05).timeout
	offset.x = 1
	offset.y = 0
	await get_tree().create_timer(0.05).timeout
	offset.x = 0
	offset.y = 0
