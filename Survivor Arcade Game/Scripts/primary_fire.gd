extends Area2D


func shoot():
	const PROJECTILE = preload("res://Survivor Arcade Game/Scenes/primary_projectile.tscn")
	var new_projectile = PROJECTILE.instantiate()
	new_projectile.global_position = %PrimaryFirePoint.global_position
	new_projectile.global_rotation = %PrimaryFirePoint.global_rotation
	%PrimaryFirePoint.add_child(new_projectile)
	
func _on_timer_timeout() :
	shoot()
