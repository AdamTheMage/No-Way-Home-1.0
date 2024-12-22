extends CharacterBody2D

var enemyhealth = 4
var secondphase = false

static var heavy_pickups = 0

@onready var player = get_node("/root/Game/PlayerCharacter")
@onready var alienloot = get_node("/root/Game")
@onready var gamelevel = get_node("/root/Game")

# Movement
func _physics_process(_delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 10
	move_and_slide()

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
func zapped() :
	enemyhealth -= 2
	%alien4.play("weak")
	second_phase()
#	if gamelevel.levelx == true :
#		%alien4.play("Attackingx")
		
	
	if enemyhealth <= 0 : 
		queue_free()
		$/root/Game/PlayerCharacter/UI/stats.add_alien4kill()
			
		#Smoke Effect
		const SMOKE_EFFECT = preload("res://Survivor Arcade Game/Scenes/zap_explosion.tscn")
		var smoke = SMOKE_EFFECT.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position
			
			#Heavy Weapon Loot
		randomize()
		var loot_chance = int(round(randi_range(8, 12)))
		if loot_chance == 10 :
			#alienloot.heavy_pickup() 
			if heavy_pickups < 2 :
				heavy_pickups += 1
				var new_heavyweaponpickup = preload("res://Survivor Arcade Game/Scenes/heavy_weapon_pickup.tscn").instantiate()
				new_heavyweaponpickup.global_position = %alien4.global_position
				get_node("/root/Game/Pickups").call_deferred("add_child",new_heavyweaponpickup)

func take_primarydamage() :
	enemyhealth -= 1
	if enemyhealth <= 2 :
		%alien4.play("weak")
		second_phase()
#	if gamelevel.levelx == true :
#		%alien4.play("Attackingx")
	
	if enemyhealth <= 0 : 
		queue_free()
		$/root/Game/PlayerCharacter/UI/stats.add_alien1kill()
			
		#Smoke Effect
		const SMOKE_EFFECT = preload("res://Survivor Arcade Game/Scenes/explosion.tscn")
		var smoke = SMOKE_EFFECT.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position
			
			#Heavy Weapon Loot
		randomize()
		var loot_chance = int(round(randi_range(8, 12)))
		if loot_chance == 10 :
			#alienloot.heavy_pickup() 
			if heavy_pickups < 2 :
				heavy_pickups += 1
				var new_heavyweaponpickup = preload("res://Survivor Arcade Game/Scenes/heavy_weapon_pickup.tscn").instantiate()
				new_heavyweaponpickup.global_position = %alien4.global_position
				get_node("/root/Game/Pickups").call_deferred("add_child",new_heavyweaponpickup)

func take_heavydamage() :
	enemyhealth -= 3
	if enemyhealth <= 2 :
		%alien1.play("Attacking")
		second_phase()
#	if gamelevel.levelx == true :
#		%alien4.play("Attackingx")
	
	if enemyhealth <= 0 : 
		#Death & Tally
		queue_free()
		$/root/Game/PlayerCharacter/UI/stats.add_alien1kill() 
		
		#Smoke Effect
		const SMOKE_EFFECT = preload("res://Survivor Arcade Game/Scenes/explosion.tscn")
		var smoke = SMOKE_EFFECT.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position
		
		#Heavy Weapon Loot
		randomize()
		var loot_chance = int(round(randi_range(8, 12)))
		if loot_chance == 10 :
			#alienloot.heavy_pickup()
			if heavy_pickups < 2 :
				heavy_pickups += 1
				var new_heavyweaponpickup = preload("res://Survivor Arcade Game/Scenes/heavy_weapon_pickup.tscn").instantiate()
				new_heavyweaponpickup.global_position = %alien4.global_position
				get_node("/root/Game/Pickups").call_deferred("add_child",new_heavyweaponpickup)

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
	if secondphase == true :
		magic_shot_high()

func _on_missile_timer_animation_timeout() :
	if secondphase == false :
		print("first")
		%MissileTimerAnimation.stop()
		%alien4.play("defaultfiring")
		await get_tree().create_timer(1.5).timeout
		%MissileTimerAnimation.start()
		%alien4.play("default")
	if secondphase == true :
		print("second")
		%MissileTimerAnimation.stop()
		%alien4.play("weakfiring")
		await get_tree().create_timer(1.5).timeout
		%MissileTimerAnimation.start()
		%alien4.play("weak")

# Second Phase
func second_phase() :
	secondphase = true

################################################################################################
