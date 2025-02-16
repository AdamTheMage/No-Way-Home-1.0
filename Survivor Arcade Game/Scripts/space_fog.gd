extends AnimatedSprite2D

var initiallevel
var important = false
var randrotate = 0
var randscale = 0
var randx = 0
var randy = 0

@onready var gamelevel = get_node("/root/Game")

func _ready() :
	# Random Rotate
	randrotate = randf_range(0, 360)
	rotation_degrees = randrotate
	# Random Scale
	randscale = randf_range(0.25, 1.5)
	scale.x = randscale
	scale.y = randscale
	# Random Movement
	randx = randf_range(-0.15,0.15)
	randy = randf_range(-0.15,0.15)
	initiallevel = gamelevel.level
	if gamelevel.level == 1 :
		$".".play("grey")
	if gamelevel.level == 2 :
		$".".play("green")
	if gamelevel.level == 3 :
		$".".play("blue")
	if gamelevel.level == 4 :
		$".".play("purple")
	if gamelevel.level == 5 :
		$".".play("purple")

func _process(_delta) :
	position += Vector2(randx, randy)

func _on_despawnstatus_timeout() :
	if initiallevel != gamelevel.level :
		if important == true :
			%foganimations.play("spiralaway")
			await get_tree().create_timer(1.5).timeout
			queue_free()
		else :
			queue_free()


func _on_visible_on_screen_notifier_2d_screen_entered() :
	important = true

func _on_visible_on_screen_notifier_2d_screen_exited() :
	important = false
