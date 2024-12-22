extends Area2D

@onready var stardust_count = get_node("/root/Game/PlayerCharacter/UI/stats")
@onready var stardust = get_node("/root/Game")
# When the player enters the collision, stardust dissapears and is added to the tally

func _on_body_entered(_PlayerCharacter) :
	stardust_count.add_stardust()
	queue_free()
	stardust.num_stardust -= 1
