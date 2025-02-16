extends CharacterBody2D

var direction = Vector2.ZERO
var randx = 0
var randy = 0
var randscale = 0
var randrotation
var speed = 0
var originalspeed = 0
var asteroidtype = 0

# Appearance Change
var initiallevel
var alreadychanged = false
var changechance = 0
var level2done = false
var level3done = false
var level4done = false
var level5done = false

# Boss Special Effects
var bluehell = false

@onready var gamelevel = get_node("/root/Game")
@onready var player = get_node("/root/Game/PlayerCharacter")
@onready var particleplayer = get_node("/root/Game/particleplayer")

func _ready() :
	randomize()
	changechance = randi_range(1, 3)
	initiallevel = gamelevel.level
	# Random Appearance
	asteroidtype = randi_range(1, 32)
	if asteroidtype == 1 :
		%Asteroid.play("one")
		%ColourChangeOverlay.play("one")
		%areaoneb.disabled = false
		%areaoneb.visible = true
		%areaone.disabled = false
		%areaone.visible = true
	if asteroidtype == 2 :
		%Asteroid.play("two")
		%ColourChangeOverlay.play("two")
		%areatwob.disabled = false
		%areatwob.visible = true
		%areatwo.disabled = false
		%areatwo.visible = true
	if asteroidtype == 3 :
		%Asteroid.play("three")
		%ColourChangeOverlay.play("three")
		%areathreeb.disabled = false
		%areathreeb.visible = true
		%areathree.disabled = false
		%areathree.visible = true
	if asteroidtype == 4 :
		%Asteroid.play("four")
		%ColourChangeOverlay.play("four")
		%areafourb.disabled = false
		%areafourb.visible = true
		%areafour.disabled = false
		%areafour.visible = true
	if asteroidtype == 5 :
		%Asteroid.play("five")
		%ColourChangeOverlay.play("five")
		%areafiveb.disabled = false
		%areafiveb.visible = true
		%areafive.disabled = false
		%areafive.visible = true
	if asteroidtype == 6 :
		%Asteroid.play("six")
		%ColourChangeOverlay.play("six")
		%areasixb.disabled = false
		%areasixb.visible = true
		%areasix.disabled = false
		%areasix.visible = true
	if asteroidtype == 7 :
		%Asteroid.play("seven")
		%ColourChangeOverlay.play("seven")
		%areasevenb.disabled = false
		%areasevenb.visible = true
		%areaseven.disabled = false
		%areaseven.visible = true
	if asteroidtype == 8 :
		%Asteroid.play("eight")
		%ColourChangeOverlay.play("eight")
		%areaeightb.disabled = false
		%areaeightb.visible = true
		%areaeight.disabled = false
		%areaeight.visible = true
	if asteroidtype == 9 :
		%Asteroid.play("nine")
		%ColourChangeOverlay.play("nine")
		%areanineb.disabled = false
		%areanineb.visible = true
		%areanine.disabled = false
		%areanine.visible = true
	if asteroidtype == 10 :
		%Asteroid.play("ten")
		%ColourChangeOverlay.play("ten")
		%areatenb.disabled = false
		%areatenb.visible = true
		%areaten.disabled = false
		%areaten.visible = true
	if asteroidtype == 11 :
		%Asteroid.play("eleven")
		%ColourChangeOverlay.play("eleven")
		%areaelevenb.disabled = false
		%areaelevenb.visible = true
		%areaeleven.disabled = false
		%areaeleven.visible = true
	if asteroidtype == 12 :
		%Asteroid.play("twelve")
		%ColourChangeOverlay.play("twelve")
		%areatwelveb.disabled = false
		%areatwelveb.visible = true
		%areatwelve.disabled = false
		%areatwelve.visible = true
	if asteroidtype >= 13 :
		%arearoundb.disabled = false
		%arearoundb.visible = true
		%roundarea.disabled = false
		%roundarea.visible = true
		if asteroidtype == 13 :
			%Asteroid.play("roundone")
			%ColourChangeOverlay.play("roundone")

		if asteroidtype == 14 :
			%Asteroid.play("roundtwo")
			%ColourChangeOverlay.play("roundtwo")

		if asteroidtype == 15 :
			%Asteroid.play("roundthree")
			%ColourChangeOverlay.play("roundthree")

		if asteroidtype == 16 :
			%Asteroid.play("roundfour")
			%ColourChangeOverlay.play("roundfour")

		if asteroidtype == 17 :
			%Asteroid.play("roundfive")
			%ColourChangeOverlay.play("roundfive")

		if asteroidtype == 18 :
			%Asteroid.play("roundsix")
			%ColourChangeOverlay.play("roundsix")

		if asteroidtype == 19 :
			%Asteroid.play("roundseven")
			%ColourChangeOverlay.play("roundseven")

		if asteroidtype == 20 :
			%Asteroid.play("roundeight")
			%ColourChangeOverlay.play("roundeight")
		
		if asteroidtype == 21 :
			%Asteroid.play("roundnine")
			%ColourChangeOverlay.play("roundnine")

		if asteroidtype == 22 :
			%Asteroid.play("roundten")
			%ColourChangeOverlay.play("roundten")

		if asteroidtype == 23 :
			%Asteroid.play("roundeleven")
			%ColourChangeOverlay.play("roundeleven")

		if asteroidtype == 24 :
			%Asteroid.play("roundtwelve")
			%ColourChangeOverlay.play("roundtwelve")

		if asteroidtype == 25 :
			%Asteroid.play("roundthirteen")
			%ColourChangeOverlay.play("roundthirteen")

		if asteroidtype == 26 :
			%Asteroid.play("roundfourteen")
			%ColourChangeOverlay.play("roundfourteen")

		if asteroidtype == 27 :
			%Asteroid.play("roundfifteen")
			%ColourChangeOverlay.play("roundfifteen")

		if asteroidtype == 28 :
			%Asteroid.play("roundsixteen")
			%ColourChangeOverlay.play("roundsixteen")

		if asteroidtype == 29 :
			%Asteroid.play("roundseventeen")
			%ColourChangeOverlay.play("roundseventeen")

		if asteroidtype == 30 :
			%Asteroid.play("roundeighteen")
			%ColourChangeOverlay.play("roundeighteen")

		if asteroidtype == 31 :
			%Asteroid.play("roundnineteen")
			%ColourChangeOverlay.play("roundnineteen")

		if asteroidtype == 32 :
			%Asteroid.play("roundtwenty")
			%ColourChangeOverlay.play("roundtwenty")


	# Rand Rotation/Scale
	randrotation = randf_range(-0.2, 0.2)
	randscale = randf_range(0.5, 1.75) / 2
	$".".scale.x = randscale
	$".".scale.y = randscale
	$".".rotation_degrees = randf_range(0, 360)
	randx = randf_range(-1, 1)
	randy = randf_range(-1, 1)
	direction = Vector2(randx, randy)
	speed = randf_range(0.25, 0.5)
	originalspeed = speed

func _physics_process(_delta) :
	$".".rotation_degrees += randrotation
	velocity = direction * speed 
	if speed > 50 :
		speed = 50
	move_and_slide() 

func _on_area_2d_body_entered(body) :
	if body.has_method("playerknocksaround") :
		if get_node("/root/Game").pocketedition == false :
			const ASTEROID_PARTICLES = preload("res://Survivor Arcade Game/Scenes/particle_effects.tscn")
			var asteroidparticles = ASTEROID_PARTICLES.instantiate()
			asteroidparticles.asteroidcollision()
			particleplayer.call_deferred("add_child", asteroidparticles)
			asteroidparticles.global_position = global_position 
			asteroidparticles.global_rotation = global_rotation
		
		speed = (player.max_speed / randscale - speed ) / 3
		direction = player.direction
		%slowdown.start()
	if body.has_method("asteroidsknockeachother") :
		if randscale > body.randscale :
			speed = (body.speed / randscale) / 4
		else :
			speed = (body.speed / randscale) 
			direction = body.direction
		%slowdown.start()

func asteroidsknockeachother () :
	# helps identify as seen above !!
	pass

func asteroidcounter() :
	# helps us identify via get_method what is an asteriud and what isn't
	pass

func _on_slowdown_timeout() :
	if speed > originalspeed :
		speed -= 2

func _on_backgroundtimer_timeout() :
	if changechance == 1 or changechance == 2 :
		if initiallevel != gamelevel.level :
			if alreadychanged == false :
				if gamelevel.level == 2 and level2done == false :
					level2done = true
					%asteroidcolourchanger.play("fadetolevel2")
				if gamelevel.level == 3 and level3done == false :
					level3done = true
					%asteroidcolourchanger.play("fadetolevel3")
				if gamelevel.level == 4 and level4done == false :
					level4done = true
					%asteroidcolourchanger.play("fadetolevel4")
				if gamelevel.level == 5 and level5done == false :
					level5done = true
					%asteroidcolourchanger.play("fadetolevel5")
				if gamelevel.level == 5 :
					if gamelevel.bluehell == true :
						%asteroidcolourchanger.play("bluehell")
					elif gamelevel.bluehell == false :
						%asteroidcolourchanger.play("level5")
		else :
			if gamelevel.level == 2 :
				%asteroidcolourchanger.play("level2")
			if gamelevel.level == 3 :
				%asteroidcolourchanger.play("level3")
			if gamelevel.level == 4 :
				%asteroidcolourchanger.play("level4")
			if gamelevel.level == 5 :
				%asteroidcolourchanger.play("level5")
