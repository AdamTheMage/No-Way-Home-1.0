extends Area2D
signal player_rooted
	# Vine Attack [Alien3]
func vine_attack() :
	player_rooted.emit()
	%Rooted.visible = true
	%RootedAnimation.visible = true
	print ("vined")
	%RootedAnimation.global_position = get_node("/root/Game/PlayerCharacter").global_position
	%RootedAnimation.global_rotation = get_node("/root/Game/PlayerCharacter").global_rotation
	%Rooted.global_position = get_node("/root/Game/PlayerCharacter").global_position
	%RootedPlayer.play("Rooted")
	%RootedAnimation.play("Rooted")
	print("animated")

func zappedcheck () :
	# lets alien3, when in contact, check to see if its the player
	pass
