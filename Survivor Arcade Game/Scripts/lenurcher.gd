extends CharacterBody2D

signal bluehell
signal lenurcherdead

var lenurcherdied = false
var maniacmode = false
var earlymaniac = false
var maniacstarted = false
var bluehellstarted = false
var invulnerable = false
var lurcherhealth = 120
var initialhealth = lurcherhealth
var speed = 0
var direction = Vector2.ZERO
var x = 0.0
var y = 0.0

#bossbar.value == enemyhealth
var secondphase = false
var firstphase = false
var twophase = false
var thirdphase = false
var fourthphase = false
var fifthphase = false

static var heavy_pickups = 0

@onready var particleplayer = get_node("/root/Game/particleplayer")
@onready var player = get_node("/root/Game/PlayerCharacter")
@onready var alienloot = get_node("/root/Game")
@onready var gamelevel = get_node("/root/Game")
@onready var lightningpath = get_node("/root/Game/PlayerCharacter/Paths/LightningPath2D/LightningPathFollow2D")
@onready var hammerpath = get_node("/root/Game/PlayerCharacter/Paths/HammerPath2D/HammerPathFollow2D")
@onready var lenurcherbar = get_node(("/root/Game/PlayerCharacter/UI/stats/statslayer/LenurcherBar"))
# Movement
func _physics_process(_delta):
	velocity = direction * speed
	await get_tree().create_timer(8).timeout
	
	velocity = direction * speed
	
	if lurcherhealth < initialhealth - 10 :
		invulnerable = true
	if lenurcherdied == true :
		%RandomMove.stop()
		%MoveToPlayer.stop()
		%ManiacMovement.stop()
		speed = 0
	move_and_slide()

func _ready() :
	%DeathImplosionAura.disabled = true
# Intro Animation
func _on_intro_timer_timeout() :
	%lenurcher.visible = true
	await get_tree().create_timer(2.995).timeout
	%MoveToPlayer.start()
	await get_tree().create_timer(1.75).timeout
	%introexplosion.z_index = 6
	%introexplosion.visible = true
	%introexplosion.play("introexplosion")
	await get_tree().create_timer(0.75).timeout
	%lenurcher.play("spawning")
	bluehell135()
	bluehell225()
	await get_tree().create_timer(1.85).timeout
	%HammerfallTimer.start()
	%LightningTimer.start()
	%BlueHellTimer.start()
	await get_tree().create_timer(0.5).timeout
	%RandomMove.start()
	%lenurcher.play("base")
	%lenurcherlightning.play("base")
	%lenurcherhammer.play("base")
	

# Mob Taking Damage and Death

# Special Effects
	# Weather
func meteored () :
		hurtparticles()
		lurcherhealth -= 2
		lenurcherbar.value = lurcherhealth
		if lurcherhealth <= 65 :
			second_phase()
		
		if lurcherhealth <= -20 : 
				
				#Heavy Weapon Loot
			randomize()
			var loot_chance = int(round(randi_range(10,10)))
			if loot_chance == 10 :
				#alienloot.heavy_pickup() 
				if heavy_pickups < 2 :
					heavy_pickups += 1
					var new_heavyweaponpickup = preload("res://Survivor Arcade Game/Scenes/heavy_missile_pickup.tscn").instantiate()
					new_heavyweaponpickup.global_position = %lenurcher.global_position
					get_node("/root/Game/Pickups").call_deferred("add_child",new_heavyweaponpickup)

	# Abilities
func zapped() :
		hurtparticles()
		lurcherhealth -= 2
		lenurcherbar.value = lurcherhealth
		if lurcherhealth <= 65 :
			second_phase()
		
		if lurcherhealth <= -20 : 
				
				#Heavy Weapon Loot
			randomize()
			var loot_chance = int(round(randi_range(10,10)))
			if loot_chance == 10 :
				#alienloot.heavy_pickup() 
				if heavy_pickups < 2 :
					heavy_pickups += 1
					var new_heavyweaponpickup = preload("res://Survivor Arcade Game/Scenes/heavy_missile_pickup.tscn").instantiate()
					new_heavyweaponpickup.global_position = %lenurcher.global_position
					get_node("/root/Game/Pickups").call_deferred("add_child",new_heavyweaponpickup)

func take_primarydamage() :
	hurtparticles()
	lurcherhealth -= 1
	lenurcherbar.value = lurcherhealth
	if lurcherhealth <= 65 :
		second_phase()
	
	if lurcherhealth <= -20 : 
			
			#Heavy Weapon Loot
		randomize()
		var loot_chance = int(round(randi_range(10, 10)))
		if loot_chance == 10 :
			#alienloot.heavy_pickup() 
			if heavy_pickups < 2 :
				heavy_pickups += 1
				var new_heavyweaponpickup = preload("res://Survivor Arcade Game/Scenes/heavy_missile_pickup.tscn").instantiate()
				new_heavyweaponpickup.global_position = %lenurcher.global_position
				get_node("/root/Game/Pickups").call_deferred("add_child",new_heavyweaponpickup)

func take_heavydamage() :
	hurtparticles()
	lurcherhealth -= 4
	lenurcherbar.value = lurcherhealth
	if lurcherhealth <= 65 :
		second_phase()
	
	if lurcherhealth <= -20 : 
		
		#Heavy Weapon Loot
		randomize()
		var loot_chance = int(round(randi_range(10, 10)))
		if loot_chance == 10 :
			#alienloot.heavy_pickup()
			if heavy_pickups < 2 :
				heavy_pickups += 1
				var new_heavyweaponpickup = preload("res://Survivor Arcade Game/Scenes/heavy_missile_pickup.tscn").instantiate()
				new_heavyweaponpickup.global_position = %lenurcher.global_position
				get_node("/root/Game/Pickups").call_deferred("add_child",new_heavyweaponpickup)

func flamethrowered() :
	if invulnerable == false :
		hurtparticles()
		lurcherhealth -= 1
		lenurcherbar.value = lurcherhealth
		if lurcherhealth <= 65 :
			second_phase()
		
		if lurcherhealth <= -20 : 
			
			#Heavy Weapon Loot
			randomize()
			var loot_chance = int(round(randi_range(10, 10)))
			if loot_chance == 10 :
				#alienloot.heavy_pickup()
				if heavy_pickups < 2 :
					heavy_pickups += 1
					var new_heavyweaponpickup = preload("res://Survivor Arcade Game/Scenes/heavy_missile_pickup.tscn").instantiate()
					new_heavyweaponpickup.global_position = %lenurcher.global_position
					get_node("/root/Game/Pickups").call_deferred("add_child",new_heavyweaponpickup)

func hornsliced() :
	if invulnerable == false :
		hurtparticles()
		lurcherhealth -= 2
		lenurcherbar.value = lurcherhealth
		if lurcherhealth <= 65 :
			second_phase()
		
		if lurcherhealth <= -20 : 
			
			#Heavy Weapon Loot
			randomize()
			var loot_chance = int(round(randi_range(10, 10)))
			if loot_chance == 10 :
				#alienloot.heavy_pickup()
				if heavy_pickups < 2 :
					heavy_pickups += 1
					var new_heavyweaponpickup = preload("res://Survivor Arcade Game/Scenes/heavy_missile_pickup.tscn").instantiate()
					new_heavyweaponpickup.global_position = %lenurcher.global_position
					get_node("/root/Game/Pickups").call_deferred("add_child",new_heavyweaponpickup)
################################################################################################
# Combat
# Missile

# Bluehell
func bluehell45() :
	bluehell.emit()
	const bluehellfire45 = preload("res://Survivor Arcade Game/Scenes/blue_hell.tscn")
	var new_bluehell = bluehellfire45.instantiate()
	new_bluehell.global_position = %HellFirePoint45.global_position
	get_node("/root/Game").add_child(new_bluehell)
	
func bluehell90() :
	bluehell.emit()
	const bluehellfire90 = preload("res://Survivor Arcade Game/Scenes/blue_hell.tscn")
	var new_bluehell = bluehellfire90.instantiate()
	new_bluehell.global_position = %HellFirePoint90.global_position
	get_node("/root/Game").add_child(new_bluehell)
	
func bluehell135() :
	bluehell.emit()
	const bluehellfire135 = preload("res://Survivor Arcade Game/Scenes/blue_hell.tscn")
	var new_bluehell = bluehellfire135.instantiate()
	new_bluehell.global_position = %HellFirePoint135.global_position
	get_node("/root/Game").add_child(new_bluehell)
	
func bluehell270() :
	bluehell.emit()
	const bluehellfire270 = preload("res://Survivor Arcade Game/Scenes/blue_hell.tscn")
	var new_bluehell = bluehellfire270.instantiate()
	new_bluehell.global_position = %HellFirePoint270.global_position
	get_node("/root/Game").add_child(new_bluehell)
	
func bluehell225() :
	bluehell.emit()
	const bluehellfire225 = preload("res://Survivor Arcade Game/Scenes/blue_hell.tscn")
	var new_bluehell = bluehellfire225.instantiate()
	new_bluehell.global_position = %HellFirePoint225.global_position
	get_node("/root/Game").add_child(new_bluehell)
	
func bluehell315() :
	bluehell.emit()
	const bluehellfire315 = preload("res://Survivor Arcade Game/Scenes/blue_hell.tscn")
	var new_bluehell = bluehellfire315.instantiate()
	new_bluehell.global_position = %HellFirePoint315.global_position
	get_node("/root/Game").add_child(new_bluehell)

# Lightning Hellfire
func lightninghell() :
	bluehell.emit()
	const lightninghellfire = preload("res://Survivor Arcade Game/Scenes/lightning_hellfire.tscn")
	var new_lightninghellfire = lightninghellfire.instantiate()
# maybe if player is within region ? :
	lightningpath.progress_ratio = randf()
	new_lightninghellfire.global_position = lightningpath.global_position
# else new_lightninghellfire.global_position = %HellFirePoint45.global_position + Vector2(45,45)
	get_node("/root/Game").add_child(new_lightninghellfire)
	
func lightning_hammer() :
	const lightninghammer = preload("res://Survivor Arcade Game/Scenes/lightning_hammer.tscn")
	var new_lightninghammer = lightninghammer.instantiate()
# maybe if player is within region ? :
	hammerpath.progress_ratio = randf()
	new_lightninghammer.global_position = hammerpath.global_position
# else new_lightninghammer.global_position = %HellFirePoint45.global_position + Vector2(45,45)
	get_node("/root/Game").add_child(new_lightninghammer)

# Second Phase
func second_phase() :
	secondphase = true
	%lenurchersecondphase.visible = true
	%lenurchersecondphase.play("secondphase0")
	if maniacmode == false :
		maniacmovement()
		maniacmode = true
	if maniacstarted == false :
		%ManiacMovement.start()
		maniacstarted = true
	if lurcherhealth <= 57 :
		firstphase = true
		%lenurchersecondphase.play("secondphase1")
	if lurcherhealth <= 50 :
		twophase = true
		%lenurchersecondphase.play("secondphase2")
	if lurcherhealth <= 43 :
		thirdphase = true
		%lenurchersecondphase.play("secondphase3")
	if lurcherhealth <= 36 :
		fourthphase = true
		%lenurchersecondphase.play("secondphase4")
	if lurcherhealth <= 29 :
		%lenurchersecondphase.play("secondphase5")
	if lurcherhealth <= 22 :
		fifthphase = true
		%lenurchersecondphase.play("secondphase6")
	if lurcherhealth <= 15 :
		%lenurchersecondphase.play("secondphase7")
	if lurcherhealth <= 8 :
		%lenurchersecondphase.play("secondphase8")
	if lurcherhealth <= -20 :
		lenurcherdead.emit()
		%DeathImplosionAura.set_deferred("disabled", false)
		%introexplosion.play("introexplosion")
		%MoveToPlayer.stop()
		%RandomMove.stop()
		direction = Vector2.ZERO
		#Death & Tally
		await get_tree().create_timer(2.25).timeout
		queue_free()

################################################################################################


func _on_blue_hell_timer_timeout() :
	if secondphase == false :
		var bluehellchance = randi_range(1,4)
		if bluehellchance == 1 :
			%lenurcher.play("dualbluehell")
			await get_tree().create_timer(3).timeout
			var bluehelltype = randi_range(1,4)
			if bluehelltype == 1 :
				bluehell90()
				bluehell135()
				bluehell315()
			if bluehelltype == 2 :
				bluehell45()
				bluehell90()
				bluehell270()
				bluehell315()
			if bluehelltype == 3 :
				bluehell45()
				bluehell135()
				bluehell270()
				bluehell225()
			if bluehelltype == 4 :
				bluehell45()
				bluehell90()
				bluehell135()
				bluehell270()
				bluehell225()
				bluehell315()
	if secondphase == true :
		%lenurcher.play("dualbluehell")
		await get_tree().create_timer(3).timeout
		bluehell45()
		bluehell90()
		bluehell135()
		bluehell270()
		bluehell225()
		bluehell315()
		var twobluehellchance = randi_range(1,2)
		if twobluehellchance == 1 :
			if fourthphase == true :
				%lenurcher.play("dualbluehell")
				await get_tree().create_timer(3).timeout
				bluehell45()
				bluehell90()
				bluehell135()
				bluehell270()
				bluehell225()
				bluehell315()

func _on_lightning_timer_timeout() :
	%lenurcherlightning.visible = true
	%lenurcherlightning.play("bluehellleft")
	await get_tree().create_timer(0.75).timeout
	lightninghell()
	var twoboltchance1 = randi_range(1,4)
	if twoboltchance1 == 1 :
		await get_tree().create_timer(0.25).timeout
		lightninghell()
	var twoboltchance2 = randi_range(1,4)
	if twoboltchance2 == 1 :
		await get_tree().create_timer(0.25).timeout
		lightninghell()
	var twoboltchance3 = randi_range(1,4)
	if twoboltchance3 == 1 :
		await get_tree().create_timer(0.25).timeout
		lightninghell()
	var twoboltchance4 = randi_range(1,4)
	if twoboltchance4 == 1 :
		await get_tree().create_timer(0.25).timeout
		lightninghell()
	var twoboltchance5 = randi_range(1,2)
	if twoboltchance5 == 1 :
		await get_tree().create_timer(0.125).timeout
		if secondphase == true :
			lightninghell()
			await get_tree().create_timer(0.125).timeout
			lightninghell()
	if twophase == true :
		await get_tree().create_timer(0.25).timeout
		lightninghell()
		var twoboltchance6 = randi_range(1,2)
		if twoboltchance6 == 1 :
			await get_tree().create_timer(0.25).timeout
			lightninghell()
		var twoboltchance7 = randi_range(1,2)
		if twoboltchance7 == 1 :
			await get_tree().create_timer(0.125).timeout
			lightninghell()
	if fourthphase == true :
		lightninghell()
		lightninghell()
		lightninghell()
	await get_tree().create_timer(1.85).timeout
	%lenurcherlightning.play("base")
	


func _on_hammerfall_timer_timeout() :
	%lenurcherhammer.visible = true
	%lenurcherhammer.play("bluehellright")
	await get_tree().create_timer(2).timeout
	lightning_hammer()
	var hammerchance1 = randi_range(1,4)
	if hammerchance1 == 1 :
		lightning_hammer()
	var hammerchance2 = randi_range(1,4)
	if hammerchance2 == 1 :
		lightning_hammer()
	var hammerchance3 = randi_range(1,4)
	if hammerchance3 == 1 :
		lightning_hammer()
	var hammerchance4 = randi_range(1,4)
	if hammerchance4 == 1 :
		lightning_hammer()
	%lenurcherhammer.play("base")
	if firstphase == true :
		lightning_hammer()
		lightning_hammer()
	if thirdphase == true :
		lightning_hammer()
		lightning_hammer()
		var threehammerchance = randi_range(1,2)
		if threehammerchance == 1 :
			lightning_hammer()
			lightning_hammer()
			lightning_hammer()

func lenurcher_knockback () :
	# used as an indicator
	pass

func _on_random_move_timeout() :
	speed = (randf_range(5, 50))
	x = (randf_range(-1, 1))
	y = (randf_range(-1, 1))
	
	direction = Vector2(x , y) 

func movefromboundary() :
	speed = 150
	direction = global_position.direction_to(player.global_position)
	await get_tree().create_timer(0.88).timeout
	%RandomMove.start()
	%MoveToPlayer.start()
	%BlueHellTimer.start()
	speed = 35

func _on_move_to_player_timeout() :
	speed = 45
	direction = global_position.direction_to(player.global_position)



func _on_maniac_movement_timeout() :
	maniacmovement()

func maniacmovement() :
	if secondphase == true :
		if lurcherhealth > 40 :
			if earlymaniac == false :
				earlymaniac = true
				%manicmode.visible = true
				%manicmode.play("manicmode")
				%RandomMove.stop()
				%MoveToPlayer.stop()
				var upordown = randi_range(1,2)
				if upordown == 1 :
					speed = 124
					direction = Vector2(1 , 0)
					await get_tree().create_timer(1.5).timeout
					speed = 50
					direction = Vector2(1 , 0.6)
					await get_tree().create_timer(0.5).timeout
					speed = 124
					direction = Vector2(-1 , 0)
					await get_tree().create_timer(1.5).timeout
					speed = 50
					direction = Vector2(-1 , -0.6)
					await get_tree().create_timer(0.5).timeout
					speed = 90
					direction = global_position.direction_to(player.global_position)
					await get_tree().create_timer(1.5).timeout
					speed = 50
					direction = Vector2(-1 , 0.6)
					await get_tree().create_timer(1.5).timeout
					speed = 124
					direction = Vector2(1 , 0)
					await get_tree().create_timer(1.5).timeout
					speed = 50
					direction = Vector2(1 , -1.2)
					await get_tree().create_timer(1.5).timeout
				
				if upordown == 2 :
					speed = 124
					direction = Vector2(1 , 0)
					await get_tree().create_timer(1.5).timeout
					speed = 50
					direction = Vector2(1 , -0.6)
					await get_tree().create_timer(0.5).timeout
					speed = 124
					direction = Vector2(-1 , 0)
					await get_tree().create_timer(1.5).timeout
					speed = 50
					direction = Vector2(-1 , 0.6)
					await get_tree().create_timer(0.5).timeout
					speed = 90
					direction = global_position.direction_to(player.global_position)
					await get_tree().create_timer(1.5).timeout
					speed = 50
					direction = Vector2(-1 , 0.6)
					await get_tree().create_timer(1.5).timeout
					speed = 124
					direction = Vector2(1 , 0)
					await get_tree().create_timer(1.5).timeout
					speed = 50
					direction = global_position.direction_to(player.global_position)
					await get_tree().create_timer(1.5).timeout
					
				%RandomMove.start()
				%MoveToPlayer.start()
				%BlueHellTimer.start()
				%manicmode.visible = false
		else :
			%manicmode.visible = true
			%manicmode.play("manicmode")
			%RandomMove.stop()
			%MoveToPlayer.stop()
			var upordown = randi_range(1,2)
			if upordown == 1 :
				speed = 124
				direction = Vector2(1 , 0)
				await get_tree().create_timer(1.5).timeout
				speed = 50
				direction = Vector2(1 , 0.6)
				await get_tree().create_timer(0.5).timeout
				speed = 124
				direction = Vector2(-1 , 0)
				await get_tree().create_timer(1.5).timeout
				speed = 50
				direction = Vector2(-1 , -0.6)
				await get_tree().create_timer(0.5).timeout
				speed = 90
				direction = global_position.direction_to(player.global_position)
				await get_tree().create_timer(1.5).timeout
				speed = 50
				direction = Vector2(-1 , 0.6)
				await get_tree().create_timer(1.5).timeout
				speed = 124
				direction = Vector2(1 , 0)
				await get_tree().create_timer(1.5).timeout
				speed = 50
				direction = Vector2(1 , -1.2)
				await get_tree().create_timer(1.5).timeout
			
			if upordown == 2 :
				speed = 124
				direction = Vector2(1 , 0)
				await get_tree().create_timer(1.5).timeout
				speed = 50
				direction = Vector2(1 , -0.6)
				await get_tree().create_timer(0.5).timeout
				speed = 124
				direction = Vector2(-1 , 0)
				await get_tree().create_timer(1.5).timeout
				speed = 50
				direction = Vector2(-1 , 0.6)
				await get_tree().create_timer(0.5).timeout
				speed = 90
				direction = global_position.direction_to(player.global_position)
				await get_tree().create_timer(1.5).timeout
				speed = 50
				direction = Vector2(-1 , 0.6)
				await get_tree().create_timer(1.5).timeout
				speed = 124
				direction = Vector2(1 , 0)
				await get_tree().create_timer(1.5).timeout
				speed = 50
				direction = global_position.direction_to(player.global_position)
				await get_tree().create_timer(1.5).timeout
				
			%RandomMove.start()
			%MoveToPlayer.start()
			%BlueHellTimer.start()
			%manicmode.visible = false

func _on_lenurcher_box_body_entered(_body) :
	speed = 50
	direction = global_position.direction_to(player.global_position)
	%MoveToPlayer.stop()
	#_on_random_move_timeout()
	await get_tree().create_timer(0.5).timeout
	movefromboundary()
	await get_tree().create_timer(0.88).timeout
	%MoveToPlayer.start()


# Particles

func hurtparticles() :
	if get_node("/root/Game").pocketedition == false :
		const BLOOD_EFFECT = preload("res://Survivor Arcade Game/Scenes/particle_effects.tscn")
		var blood = BLOOD_EFFECT.instantiate()
		blood.lenurcherblood()
		particleplayer.call_deferred("add_child", blood)
		blood.global_position = global_position 

func _on_lenurcherdead() :
	%introexplosion.z_index = 8
		# Soul Pickup
	await get_tree().create_timer(2).timeout
	var new_soul49 = preload("res://Survivor Arcade Game/Scenes/soul.tscn").instantiate()
	new_soul49.scale.x = 0.8
	new_soul49.scale.y = 0.8
	new_soul49.soultype = 8
	new_soul49.global_position = %lenurcher.global_position + Vector2(3, 0)
	get_node("/root/Game/Pickups").call_deferred("add_child",new_soul49)
	
	var new_soul50 = preload("res://Survivor Arcade Game/Scenes/soul.tscn").instantiate()
	new_soul50.scale.x = 0.8
	new_soul50.scale.y = 0.8
	new_soul50.soultype = 8
	new_soul50.global_position = %lenurcher.global_position + Vector2(4.5, 0)
	get_node("/root/Game/Pickups").call_deferred("add_child",new_soul50)
		
	var new_soul51 = preload("res://Survivor Arcade Game/Scenes/soul.tscn").instantiate()
	new_soul51.scale.x = 0.8
	new_soul51.scale.y = 0.8
	new_soul51.soultype = 8
	new_soul51.global_position = %lenurcher.global_position + Vector2(-4.5, 0)
	get_node("/root/Game/Pickups").call_deferred("add_child",new_soul51)

	var new_soul52 = preload("res://Survivor Arcade Game/Scenes/soul.tscn").instantiate()
	new_soul52.scale.x = 0.8
	new_soul52.scale.y = 0.8
	new_soul52.soultype = 8
	new_soul52.global_position = %lenurcher.global_position + Vector2(-3, 0)
	get_node("/root/Game/Pickups").call_deferred("add_child",new_soul52)

func _on_death_implosion_body_entered(body) :
	if body.has_method("lenurcherimplosion") :
		body.lenurcherimplosion()


func _on_damage_capper_timeout() :
	invulnerable = false
	initialhealth = lurcherhealth
