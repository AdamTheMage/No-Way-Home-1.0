extends Control
func _ready() :
	Engine.max_fps = 60
	get_viewport().size = DisplayServer.screen_get_size()
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED_HIDDEN)
