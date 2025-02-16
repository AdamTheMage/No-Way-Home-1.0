extends Sprite2D

var presseddown = false

@onready var root = $".."

@export var maxdistance = 25
@export var deadzone = 0

func _ready() :
	maxdistance *= root.scale.x - 1.5

func _process (delta) :
	if presseddown :
		if get_global_mouse_position().distance_to(root.global_position) <= maxdistance :
			global_position = get_global_mouse_position()
		else :
			var joystickangle = root.global_position.angle_to_point(get_global_mouse_position())
			global_position.x = root.global_position.x + cos(joystickangle) * maxdistance
			global_position.y = root.global_position.y + sin(joystickangle) * maxdistance
		calculatedirection()
	else :
		global_position = lerp(global_position, root.global_position, delta * 12)
		root.posVector = Vector2(0, 0)
func calculatedirection () :
	if abs((global_position.x - root.global_position.x)) >= deadzone :
		root.posVector.x = (global_position.x - root.global_position.x) / maxdistance
	if abs((global_position.y - root.global_position.y)) >= deadzone :
		root.posVector.y = (global_position.y - root.global_position.y) / maxdistance

func _on_button_button_down() :
	presseddown = true

func _on_button_button_up() :
	presseddown = false
