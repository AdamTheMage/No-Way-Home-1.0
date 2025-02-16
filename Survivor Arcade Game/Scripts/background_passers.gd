extends Node2D

var planet = true
var direction = Vector2.ZERO
var speed = 0
var previouslevel = 0

@onready var gamelevel = get_node("/root/Game")
@onready var player = get_node("/root/Game/PlayerCharacter")

func _ready() :
	%Planets.global_position = player.global_position + Vector2(randf_range(-6000, 6000) , randf_range(-6000, 6000))
	%planetanimation.play("swoopin")
	previouslevel = gamelevel.level
	randomize()
	%Planets.visible = false
	if planet == true :
		direction = Vector2(1, randf_range(-0.15, 0.15))
		speed = 20
		%Planets.visible = true
		if gamelevel.level == 2 :
			%Planets.play("planetone")
		elif gamelevel.level == 3 or gamelevel.level == 5 :
			%Planets.play("planettwo")
			%Planets.modulate = Color(0.68, 0.68, 0.68)
		elif gamelevel.level == 4 :
			%Planets.play("planetthree")
			%Planets.modulate = Color(0.68, 0.68, 0.68)

func _physics_process(delta) :
	# FLY IN :
	# when position hits :
	position += direction * speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited() :
	queue_free()


func _on_despawnchecker_timeout() :
	if previouslevel != gamelevel.level :
		%planetanimation.play("swoopout")
		await get_tree().create_timer(1.5).timeout
		queue_free()
