extends AnimatedSprite2D

var asteroidchance = 0

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

func _ready() :
	randomize()
	changechance = randi_range(1, 2)
	initiallevel = gamelevel.level
	gamelevel.backgroundasteroidcount += 1
	asteroidchance = randi_range(1, 31)
	if asteroidchance == 1 :
		$".".play("asteroidone")
	if asteroidchance == 2 :
		$".".play("asteroidtwo")
	if asteroidchance == 3 :
		$".".play("asteroidthree")
	if asteroidchance == 4 :
		$".".play("asteroidfour")
	if asteroidchance == 5 :
		$".".play("asteroidfive")
	if asteroidchance == 6 :
		$".".play("asteroidsix")
	if asteroidchance == 7 :
		$".".play("asteroidseven")
	if asteroidchance == 8 :
		$".".play("asteroideight")
	if asteroidchance == 9 :
		$".".play("asteroidnine")
	if asteroidchance == 10 :
		$".".play("asteroidten")
	if asteroidchance == 11 :
		$".".play("asteroideleven")
	if asteroidchance == 12 :
		$".".play("asteroidtwelve")
	if asteroidchance == 13 :
		$".".play("asteroidthirteen")
	if asteroidchance == 14 :
		$".".play("asteroidfourteen")
	if asteroidchance == 15 :
		$".".play("asteroidfifteen")
	if asteroidchance == 16 :
		$".".play("asteroidsixteen")
	if asteroidchance == 17 :
		$".".play("asteroidseventeen")
	if asteroidchance == 18 :
		$".".play("asteroideighteen")
	if asteroidchance == 19 :
		$".".play("asteroidnineteen")
	if asteroidchance == 20 :
		$".".play("asteroidtwenty")
	if asteroidchance == 21 :
		$".".play("asteroidtwentyone")
	if asteroidchance == 22 :
		$".".play("asteroidtwentytwo")
	if asteroidchance == 23 :
		$".".play("asteroidtwentythree")
	if asteroidchance == 24 :
		$".".play("asteroidtwentyfour")
	if asteroidchance == 25 :
		$".".play("asteroidtwentyfive")
	if asteroidchance == 26 :
		$".".play("asteroidtwentysix")
	if asteroidchance == 27 :
		$".".play("asteroidtwentyseven")
	if asteroidchance == 28 :
		$".".play("asteroidtwentyeight")
	if asteroidchance == 29 :
		$".".play("asteroidtwentynine")
	if asteroidchance == 30 :
		$".".play("asteroidthirty")
	if asteroidchance == 31 :
		$".".play("asteroidthirtyone")
	# scale and rotation variance :
	var scalerandom = randf_range(-0.8, 0.8)
	$".".scale.x = scalerandom
	$".".scale.y = scalerandom
	$".".rotation_degrees = randf_range(0, 360)

func _on_despawntimer_timeout() :
		gamelevel.backgroundasteroidcount -= 1
		queue_free()


func _on_visible_on_screen_notifier_2d_screen_entered() :
	%despawntimer.stop()


func _on_visible_on_screen_notifier_2d_screen_exited() :
	gamelevel.backgroundasteroidcount -= 1
	queue_free()


func _on_backgroundtimer_timeout() :
	if changechance == 1 :
		if initiallevel != gamelevel.level :
			if alreadychanged == false :
				if gamelevel.level == 2 and level2done == false :
					level2done = true
					%colourchange.play("fadetolevel2")
				if gamelevel.level == 3 and level3done == false :
					level3done = true
					%colourchange.play("fadetolevel3")
				if gamelevel.level == 4 and level4done == false :
					level4done = true
					%colourchange.play("fadetolevel4")
				if gamelevel.level == 5 and level5done == false :
					level5done = true
					%colourchange.play("fadetolevel5")
				if gamelevel.level == 5 :
					if gamelevel.bluehell == true :
						%colourchange.play("bluehell")
					elif gamelevel.bluehell == false :
						%colourchange.play("level5")
		else :
			if gamelevel.level == 2 :
				%colourchange.play("level2")
			if gamelevel.level == 3 :
				%colourchange.play("level3")
			if gamelevel.level == 4 :
				%colourchange.play("level4")
			if gamelevel.level == 5 :
				%colourchange.play("level5")
