extends Control

func _ready() :
	%mageanimation.play("magesplash")
	await get_tree().create_timer(4).timeout
	load_next_scene()

func load_next_scene() :
	SceneLoader.load_scene("res://Survivor Arcade Game/Scenes/NoWayHomeIteration1.tscn")
