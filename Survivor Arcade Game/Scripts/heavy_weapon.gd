extends Area2D

func heavyshoot():
	const PROJECTILE = preload("res://Survivor Arcade Game/Scenes/heavy_projectile.tscn")
	var new_projectile = PROJECTILE.instantiate()
	new_projectile.global_position = %ShootingPoint.global_position
	new_projectile.global_rotation = %ShootingPoint.global_rotation
	%ShootingPoint.add_child(new_projectile)


func _on_heavytimer_timeout() :
	heavyshoot()
