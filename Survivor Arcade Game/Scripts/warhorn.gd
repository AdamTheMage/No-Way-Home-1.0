extends Node2D

var shootable = true
var leftorright 

@onready var Game = get_node("/root/Game")

func _ready() :
	warswing()
	if leftorright == "right" :
		%hornsprite.flip_h = true

func _process(_delta) :
	if Input.is_action_pressed("fire_left") :
		if leftorright == "left" and shootable == true :
			warswing()
	elif Input.is_action_pressed("fire_right") :
		if leftorright == "right" and shootable == true :
			warswing()
	
	# Unequip :
	if Game.nomoreleftwarhorn == true and leftorright == "left" :
		print ("leftremoved")
		queue_free()
	elif Game.nomorerightwarhorn == true and leftorright == "right" :
		print ("rightremoved")
		queue_free() 

func warswing():
	%Area2D.monitoring = true
	if leftorright == "left" :
		%swinganimation.play("oppositeswing")
	else :
		%swinganimation.play("swing")
	shootable = false
	%heavytimer.start()


func _on_heavytimer_timeout() :
	shootable = true
	%hornsprite.play("recharged")
	%heavytimer.stop()

func _on_hornsprite_animation_finished() :
	%hornsprite.play("default")

func _on_swinganimation_animation_finished (_swing) :
	%hornsprite.play("default")
	%Area2D.monitoring = false


func _on_area_2d_body_entered(body) :
	if body.has_method("hornsliced") :
		body.hornsliced()
