extends CharacterBody2D

var enemyhealth = 5
var speed = 13
var direction = Vector2.ZERO
var scaler = 1.0
var chase = false
var randomlymoving = false

static var heavy_pickups = 0

@onready var particleplayer = get_node("/root/Game/particleplayer")
@onready var player = get_node("/root/Game/PlayerCharacter")
@onready var alienloot = get_node("/root/Game")
@onready var gamelevel = get_node("/root/Game")

# Movement
func _physics_process(_delta):
	look_at(player.global_position)
	if randomlymoving == false :
		direction = global_position.direction_to(player.global_position)
	velocity = direction * speed
	move_and_slide()

func _on_alienbox_body_entered(body) :
	if body.has_method("asteroidsknockeachother") :
		if body.speed > 15 :
			take_asteroid_collision_damage()

func guggler_knockback () :
	# used as an indicator
	pass
	
# Animation change when attack
func _ready():
	gamelevel.guggler_count += 1
	randomize()
	scaler = (randf_range(0.55, 0.85))
	$".".scale.x = scaler
	$".".scale.y = scaler
	if enemyhealth > 2 :
		%guggler.play("greentounguein")
	
# Checks appearance depending on current signals
func _on_appearancechecker_timeout() :
	if enemyhealth > 2 :
		if gamelevel.level >= 3 :
			%guggler.play("bluetonguein")
	if enemyhealth <= 2 :
		if gamelevel.level < 3 :
			%guggler.play("greendamagedchase")
		if gamelevel.level >= 3 :
			%guggler.play("bluedamagedchase")

# Abilities
	# GUGGLER SPEW
func gugglerspew() :
	if enemyhealth > 2 :
		if gamelevel.level < 3 :
			%guggler.play("greentongueout")
		if gamelevel.level >= 3 :
			%guggler.play("bluetongueout")
		await get_tree().create_timer(1.25).timeout
		if chase == false :
			# Spew
			const SPEW = preload("res://Survivor Arcade Game/Scenes/guggler_spew.tscn")
			var new_spew = SPEW.instantiate()
			new_spew.scale.x = (scaler * 1.55)
			new_spew.scale.y = (scaler * 1.55)
			new_spew.global_position = %spewpoint.global_position
			new_spew.global_rotation = %spewpoint.global_rotation
			get_node("/root/Game").add_child(new_spew)
			await get_tree().create_timer(1.75).timeout
			if chase == false :
				if gamelevel.level < 3 :
					%guggler.play("greentounguein")
				if gamelevel.level >= 3 :
					%guggler.play("bluetonguein")

func _on_spewtime_timeout() :
	gugglerspew()

	# GUGGLER CHASE
func gugglerchase() :
	%spewtime.stop()
	chase = true
	$".".scale.x = (scaler * 0.55)
	$".".scale.y = (scaler * 0.55)
	speed = 32.5
# Mob Taking Damage and Death

# Special Effects
	# Weather
func meteored () :
	hurtparticles()
	enemyhealth -= 2
	if enemyhealth <= 2 :
		if chase == false :
			gugglerchase()
			%guggler.play("greendamagedchase")
		if gamelevel.level >= 3 :
			%guggler.play("bluedamagedchase")
			
	if enemyhealth <= 0 : 
		aliendeath()

func take_asteroid_collision_damage() :
	enemyhealth -= 1
	if enemyhealth <= 2 :
		if chase == false :
			gugglerchase()
			%guggler.play("greendamagedchase")
		if gamelevel.level >= 3 :
			%guggler.play("bluedamagedchase")

	# Abilities
func zapped() :
	hurtparticles()
	enemyhealth -= 2
	if enemyhealth <= 2 :
		if chase == false :
			gugglerchase()
			%guggler.play("greendamagedchase")
		if gamelevel.level >= 3 :
			%guggler.play("bluedamagedchase")
		
	
	if enemyhealth <= 0 : 
		aliendeath()

func take_primarydamage() :
	hurtparticles()
	enemyhealth -= 1
	if enemyhealth <= 2 :
		if chase == false :
			gugglerchase()
			%guggler.play("greendamagedchase")
		if gamelevel.level >= 3 :
			%guggler.play("bluedamagedchase")
	
	if enemyhealth <= 0 : 
		aliendeath()

func take_heavydamage() :
	hurtparticles()
	enemyhealth -= 4
	if enemyhealth <= 2 :
		if chase == false :
			gugglerchase()
			%guggler.play("greendamagedchase")
		if gamelevel.level >= 3 :
			%guggler.play("bluedamagedchase")
	
	if enemyhealth <= 0 : 
		#Death & Tally
		aliendeath()

func flamethrowered() :
	hurtparticles()
	enemyhealth -= 4
	if enemyhealth <= 2 :
		if chase == false :
			gugglerchase()
			%guggler.play("greendamagedchase")
		if gamelevel.level >= 3 :
			%guggler.play("bluedamagedchase")
	
	if enemyhealth <= 0 : 
		#Death & Tally
		aliendeath()

func hornsliced () :
	hurtparticles()
	enemyhealth -= 4
	if enemyhealth <= 2 :
		if chase == false :
			gugglerchase()
			%guggler.play("greendamagedchase")
		if gamelevel.level >= 3 :
			%guggler.play("bluedamagedchase")
	
	if enemyhealth <= 0 : 
		#Death & Tally
		aliendeath()

# Particles

func hurtparticles() :
	if get_node("/root/Game").pocketedition == false :
		const BLOOD_EFFECT = preload("res://Survivor Arcade Game/Scenes/particle_effects.tscn")
		var blood = BLOOD_EFFECT.instantiate()
		if gamelevel.level >= 3 :
			blood.gugglerbloodblue()
		else :
			blood.gugglerblood()
		particleplayer.call_deferred("add_child", blood)
		blood.global_position = global_position 

func aliendeath():
		gamelevel.guggler_count -= 1
		queue_free()
		$/root/Game/PlayerCharacter/UI/stats.add_gugglerkill()
			
		#Smoke Effect
		const SMOKE_EFFECT = preload("res://Survivor Arcade Game/Scenes/explosion.tscn")
		var smoke = SMOKE_EFFECT.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position
			
		# Guggler Soul Drop
		var new_soul2 = preload("res://Survivor Arcade Game/Scenes/soul.tscn").instantiate()
		new_soul2.scale.x = 0.5
		new_soul2.scale.y = 0.5
		if gamelevel.level >= 3 :
			new_soul2.soultype = 4
		else :
			new_soul2.soultype = 2
		new_soul2.global_position = %guggler.global_position
		get_node("/root/Game/Pickups").call_deferred("add_child",new_soul2)
			
			# Flamethrower Weapon Loot
		randomize()
		var loot_chance = int(round(randi_range(1, 2)))
		if loot_chance == 1 :
			if get_node("/root/Game").flamethrowerpickups < 2 :
				get_node("/root/Game").flamethrowerpickups += 1
				var new_flamethrowerpickup = preload("res://Survivor Arcade Game/Scenes/heavy_flamethrower_pickup.tscn").instantiate()
				new_flamethrowerpickup.global_position = %guggler.global_position
				new_flamethrowerpickup.lootflip()
				get_node("/root/Game/Pickups").call_deferred("add_child",new_flamethrowerpickup)

func lenurcherimplosion() :
		gamelevel.guggler_count -= 1
		queue_free()
		$/root/Game/PlayerCharacter/UI/stats.add_gugglerkill()
			
		#Smoke Effect
		const SMOKE_EFFECT = preload("res://Survivor Arcade Game/Scenes/explosion.tscn")
		var smoke = SMOKE_EFFECT.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position
			
		# Guggler Soul Drop
		var new_soul2 = preload("res://Survivor Arcade Game/Scenes/soul.tscn").instantiate()
		new_soul2.scale.x = 0.5
		new_soul2.scale.y = 0.5
		if gamelevel.level >= 3 :
			new_soul2.soultype = 4
		else :
			new_soul2.soultype = 2
		new_soul2.global_position = %guggler.global_position
		get_node("/root/Game/Pickups").call_deferred("add_child",new_soul2)
		
			#Flamethrower Weapon Loot
		randomize()
		var loot_chance = int(round(randi_range(1, 2)))
		if loot_chance == 1 :
			if get_node("/root/Game").flamethrowerpickups < 2 :
				get_node("/root/Game").flamethrowerpickups += 1
				var new_flamethrowerpickup = preload("res://Survivor Arcade Game/Scenes/heavy_flamethrower_pickup.tscn").instantiate()
				new_flamethrowerpickup.global_position = %guggler.global_position
				new_flamethrowerpickup.lootflip()
				get_node("/root/Game/Pickups").call_deferred("add_child",new_flamethrowerpickup)

func aliendeathnosoul () :
	gamelevel.guggler_count -= 1
	queue_free()

func _on_randommovement_timeout() :
	if chase == false :
		randomlymoving = true
		randomize()
		var rand1 = randf_range(-0.6, 0.6)
		var rand2 = randf_range(-0.5, 0.5)
		direction = global_position.direction_to(player.global_position) + Vector2(rand1, rand2)
	else : 
		randomlymoving = false
