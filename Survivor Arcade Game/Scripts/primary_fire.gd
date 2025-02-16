extends Area2D

var endanimation = false

func shoot():
	const PROJECTILE = preload("res://Survivor Arcade Game/Scenes/primary_projectile.tscn")
	var new_projectile = PROJECTILE.instantiate()
	new_projectile.global_position = %PrimaryFirePoint.global_position
	new_projectile.global_rotation = %PrimaryFirePoint.global_rotation
	%PrimaryFirePoint.add_child(new_projectile)
	
func _on_timer_timeout() :
	if endanimation == false :
		shoot()


func _on_squad_regroup_animation_started(_SquadRegroup: StringName) :
	endanimation = true
