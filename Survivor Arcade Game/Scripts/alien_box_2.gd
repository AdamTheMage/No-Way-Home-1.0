extends Area2D


func _on_area_entered(area) :
	print ("alien2")
	if area.has_method("vine_attack") :
		area.vine_attack()
