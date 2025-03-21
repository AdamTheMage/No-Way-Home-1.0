extends Node

@onready var loading_screen_scene = preload("res://Survivor Arcade Game/Scenes/loading_screen.tscn")

var scene_to_load_path
var loading_screen_scene_instance
var loading = false

#func _ready() :
	#Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED_HIDDEN) #####################

func load_scene(path) :
	var current_scene = get_tree().current_scene
	
	loading_screen_scene_instance = loading_screen_scene.instantiate()
	get_tree().root.call_deferred("add_child", loading_screen_scene_instance)
	
	if ResourceLoader.has_cached(path) :
		ResourceLoader.load_threaded_get(path)
	else :
		ResourceLoader.load_threaded_request(path)
		
	current_scene.queue_free()
	
	loading = true
	scene_to_load_path = path
	
func _process(_delta) :
	if not loading :
		return
	
	var progress = []
	var status = ResourceLoader.load_threaded_get_status(scene_to_load_path, progress)
	
	if status == ResourceLoader.THREAD_LOAD_IN_PROGRESS:
		var loadingscreenbar = loading_screen_scene_instance.get_node("ProgressBar")
		loadingscreenbar.value = progress[0] * 100
	elif status == ResourceLoader.THREAD_LOAD_LOADED:
		get_tree().change_scene_to_packed(ResourceLoader.load_threaded_get(scene_to_load_path))
		loading_screen_scene_instance.queue_free()
		loading = false
	else :
		print ("loading broken")
