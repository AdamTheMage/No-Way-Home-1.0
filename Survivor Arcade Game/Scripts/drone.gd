extends Area2D

var rotation_speed = PI

func _physics_process(delta):
	var enemies_in_range = get_overlapping_bodies()
	if enemies_in_range.size() > 0 :
		var target_enemy = enemies_in_range.front()
		var v = target_enemy.global_position - global_position
		var angle = v.angle()
		var r = global_rotation
		var angle_delta = rotation_speed * delta
		angle = lerp_angle( r, angle, 1.0)
		angle = clamp(angle, r - angle-delta, r + angle_delta)
		global_rotation = angle


func shoot():
	const PROJECTILE = preload("res://Survivor Arcade Game/Scenes/primary_projectile.tscn")
	var new_projectile = PROJECTILE.instantiate()
	new_projectile.global_position = %ShootingPoint.global_position
	new_projectile.global_rotation = %ShootingPoint.global_rotation
	%ShootingPoint.add_child(new_projectile)


func _on_timer_timeout() :
	shoot()
	
