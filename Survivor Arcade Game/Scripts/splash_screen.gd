extends Control

func _ready() :
	Engine.max_fps = 60
	get_viewport().size = DisplayServer.screen_get_size()
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED_HIDDEN)
	%mageanimation.play("magesplash")
	await get_tree().create_timer(4).timeout
	load_next_scene()

func load_next_scene() :
	SceneLoader.load_scene("res://Survivor Arcade Game/Scenes/NoWayHomeIteration1.tscn")
