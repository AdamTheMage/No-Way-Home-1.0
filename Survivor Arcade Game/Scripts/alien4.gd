extends CharacterBody2D

var enemyhealth = 4
var secondphase = false

static var heavy_pickups = 0

@onready var particleplayer = get_node("/root/Game/particleplayer")
@onready var player = get_node("/root/Game/PlayerCharacter")
@onready var alienloot = get_node("/root/Game")
@onready var gamelevel = get_node("/root/Game")

func _ready() :
	gamelevel.alien4_count += 1

# Movement
func _physics_process(_delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 18
	move_and_slide()

func _on_alien_box_body_entered(body) :
	if body.has_method("asteroidsknockeachother") :
		if body.speed > 15 :
			take_asteroid_collision_damage()

func alien4_knockback () :
	# used as an indicator
	pass
	
# Animation change when attack
func on_ready():
	%alien4.play("default")
	
# Checks appearance depending on current signals
#func _on_appearancechecker_timeout() :
#	if enemyhealth >= 3 :
#		if gamelevel.levelx == true :
#			%alien4.play("Defaultx")

# Mob Taking Damage and Death

# Special Effects
	# Weather
func meteored () :
	hurtparticles()
	enemyhealth -= 2
	%alien4.play("weak")
	second_phase()
#	if gamelevel.levelx == true :
#		%alien4.play("Attackingx")
		
	
	if enemyhealth <= 0 : 
		aliendeath()
	
func take_asteroid_collision_damage() :
	hurtparticles()
	enemyhealth -= 1
	
	if enemyhealth <= 2 :
		%alien4.play("weak")
		second_phase()

	# Abilities
func zapped() :
	hurtparticles()
	enemyhealth -= 2
	%alien4.play("weak")
	second_phase()
#	if gamelevel.levelx == true :
#		%alien4.play("Attackingx")
		
	
	if enemyhealth <= 0 : 
		aliendeath()

func take_primarydamage() :
	hurtparticles()
	enemyhealth -= 1
	if enemyhealth <= 2 :
		%alien4.play("weak")
		second_phase()
	
	if enemyhealth <= 0 : 
		aliendeath()

func take_heavydamage() :
	hurtparticles()
	enemyhealth -= 4
	if enemyhealth <= 2 :
		%alien4.play("weak")
		second_phase()
#	if gamelevel.levelx == true :
#		%alien4.play("Attackingx")
	
	if enemyhealth <= 0 : 
		#Death & Tally
		aliendeath()

func flamethrowered() :
	hurtparticles()
	enemyhealth -= 2
	if enemyhealth <= 2 :
		%alien4.play("weak")
		second_phase()
#	if gamelevel.levelx == true :
#		%alien4.play("Attackingx")
	
	if enemyhealth <= 0 : 
		#Death & Tally
		aliendeath()

func hornsliced () :
	hurtparticles()
	enemyhealth -= 4
	if enemyhealth <= 2 :
		%alien4.play("weak")
		second_phase()
#	if gamelevel.levelx == true :
#		%alien4.play("Attackingx")
	
	if enemyhealth <= 0 : 
		#Death & Tally
		aliendeath()
################################################################################################
# Combat
# Missile
func magic_shot_high() :
	const MISSILE = preload("res://Survivor Arcade Game/Scenes/draugal_missile.tscn")
	var new_missile = MISSILE.instantiate()
	new_missile.global_position = %HighFirePoint.global_position
	new_missile.global_rotation = %HighFirePoint.global_rotation
	get_node("/root/Game").add_child(new_missile)

func magic_shot_low() :
	const MISSILE = preload("res://Survivor Arcade Game/Scenes/draugal_missile.tscn")
	var new_missile = MISSILE.instantiate()
	new_missile.global_position = %LowFirePoint.global_position
	new_missile.global_rotation = %LowFirePoint.global_rotation
	get_node("/root/Game").add_child(new_missile)
	
func _on_missile_timer_low_timeout() :
		magic_shot_low()

func _on_missile_timer_animation_timeout() :
	if secondphase == false :
		%MissileTimerAnimation.stop()
		%alien4.play("defaultfiring")
		await get_tree().create_timer(1.5).timeout
		%MissileTimerAnimation.start()
		%alien4.play("default")
	else :
		%MissileTimerAnimation.stop()

# Second Phase
func second_phase() :
	%MissileTimerLow.stop()
	%MissileTimerAnimation.stop()
	%MissileTimerLowPhaseTwo.start()
	%MissileTimerAnimationPhaseTwo.start()
	secondphase = true

################################################################################################


func _on_missile_timer_low_phase_two_timeout() :
		magic_shot_high()

func _on_missile_timer_animation_phase_two_timeout() :
		%MissileTimerAnimationPhaseTwo.stop()
		%alien4.play("weakfiring")
		await get_tree().create_timer(1.5).timeout
		%MissileTimerAnimationPhaseTwo.start()
		%alien4.play("weak")

# Particles

func hurtparticles() :
	if get_node("/root/Game").pocketedition == false :
		const BLOOD_EFFECT = preload("res://Survivor Arcade Game/Scenes/particle_effects.tscn")
		var blood = BLOOD_EFFECT.instantiate()
		blood.alien4blood()
		particleplayer.call_deferred("add_child", blood)
		blood.global_position = global_position 

func aliendeath() :
		gamelevel.alien4_count -= 1
		queue_free()
		$/root/Game/PlayerCharacter/UI/stats.add_alien4kill() 
		
		#Smoke Effect
		const SMOKE_EFFECT = preload("res://Survivor Arcade Game/Scenes/explosion.tscn")
		var smoke = SMOKE_EFFECT.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position
		
	# Soul Pickup
		var new_soul5 = preload("res://Survivor Arcade Game/Scenes/soul.tscn").instantiate()
		new_soul5.scale.x = 0.64
		new_soul5.scale.y = 0.64
		new_soul5.soultype = 7
		new_soul5.global_position = %alien4.global_position
		get_node("/root/Game/Pickups").call_deferred("add_child",new_soul5)
		
		#Heavy Weapon Loot
				
func lenurcherimplosion() :
		gamelevel.alien4_count -= 1
		queue_free()
		$/root/Game/PlayerCharacter/UI/stats.add_alien4kill() 
		
		#Smoke Effect
		const SMOKE_EFFECT = preload("res://Survivor Arcade Game/Scenes/explosion.tscn")
		var smoke = SMOKE_EFFECT.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position
		
	# Soul Pickup
		var new_soul5 = preload("res://Survivor Arcade Game/Scenes/soul.tscn").instantiate()
		new_soul5.scale.x = 0.64
		new_soul5.scale.y = 0.64
		new_soul5.soultype = 7
		new_soul5.global_position = %alien4.global_position
		get_node("/root/Game/Pickups").call_deferred("add_child",new_soul5)
		
		#Heavy Weapon Loot

func aliendeathnosoul () :
	gamelevel.alien4_count -= 1
	queue_free()
