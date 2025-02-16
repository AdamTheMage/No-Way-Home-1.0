extends Area2D

var direction = Vector2.ZERO
var leftorright = 0
var stopfollowing = false
var pickuprange = false
var outofrange = false
var alreadydecided = false
var animationdone = false
var flipwhichway = 0

# References :
@onready var game = get_node("/root/Game")
@onready var player = get_node("/root/Game/PlayerCharacter")

func _physics_process(delta) :
	position += direction * 10 * delta
	if stopfollowing == true :
		direction = Vector2.ZERO
	
	# Pickup :
	if get_node("/root/Game").warhorns < 2 and pickuprange == true and animationdone == true :
		if Input.is_action_just_pressed("fire_right") :
			await get_tree().create_timer(0.05).timeout
			game.add_warhornR() # left one
			queue_free()
		if Input.is_action_just_pressed("fire_left") :
			await get_tree().create_timer(0.05).timeout
			game.add_warhornL() # right one
			queue_free()

func lootflip () :
	randomize()
	flipwhichway = randi_range(1, 2)
	if flipwhichway == 1 :
		dropanimation ()
	elif flipwhichway == 2 :
		dropanimationleft()

func _ready() :
	if alreadydecided == false :
		lootflip()
	randomize()
	leftorright = randi_range(1, 2)
	if leftorright == 1 :
		%warhornpickupsprite.play("default")
		%warhornpickupsprite.flip_h = true
	if leftorright == 2 :
		%warhornpickupsprite.play("default")

func _on_body_entered(_PlayerCharacter) :
	pickuprange = true

func _on_body_exited(_PlayerCharacter) :
	pickuprange = false


func _on_magnetarea_body_entered(_PlayerCharacter) :
	%directionupdater.start()
	outofrange = false


func _on_directionupdater_timeout() :
	if outofrange == false :
		direction = Vector2(1, 0).rotated(rotation)
		look_at(player.global_position)
		direction = global_position.direction_to(player.global_position)

func _on_magnetarea_body_exited(_PlayerCharacter) :
	outofrange = true
	direction = Vector2.ZERO
	
# Dropping :
func dropanimation () :
	alreadydecided = true
	%magnetarea.monitoring = false
	%warhornspin.play("drop_right")

func dropanimationleft () :
	alreadydecided = true
	%magnetarea.monitoring = false
	%warhornspin.play("drop_left")

func _on_warhornspin_animation_finished(_warhorn_drop) :
	animationdone = true
	%magnetarea.monitoring = true

# Despawn :
func _on_despawn_timer_timeout() :
	game.warhornpickups -= 1
	queue_free()
