extends Area2D

# References :
@onready var game = get_node("/root/Game")

func _on_body_entered(_PlayerCharacter) :
	game.add_drone()
	queue_free()
