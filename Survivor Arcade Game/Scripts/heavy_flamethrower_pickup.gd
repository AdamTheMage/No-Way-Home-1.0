extends Area2D

var direction = Vector2.ZERO
var leftorright = 0
var stopfollowing = false
var pickuprange = false
var outofrange = false
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
	if get_node("/root/Game").flamethrowers < 2 and pickuprange == true and animationdone == true :
		if Input.is_action_just_pressed("fire_right") :
			await get_tree().create_timer(0.05).timeout
			game.add_flamethrowerR() # left one
			queue_free()
		if Input.is_action_just_pressed("fire_left") :
			await get_tree().create_timer(0.05).timeout
			game.add_flamethrowerL() # right one
			queue_free()
	
func lootflip () :
	randomize()
	flipwhichway = randi_range(1, 2)
	if flipwhichway == 1 :
		dropanimation ()
	elif flipwhichway == 2 :
		dropanimationleft()

func _ready() :
	randomize()
	leftorright = randi_range(1, 2)
	if leftorright == 1 :
		%FlamethrowerSprite.play("left")
	if leftorright == 2 :
		%FlamethrowerSprite.play("right")

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
		%magnetarea.monitoring = false
		%flamethrowerdrop.play("flamethrower_drop")

func dropanimationleft () :
	%magnetarea.monitoring = false
	%flamethrowerdrop.play("flamethrower_drop_left")

func _on_flamethrowerdrop_animation_finished(_flamethrower_drop) :
	%magnetarea.monitoring = true

# Despawn :
func _on_despawn_timer_timeout() :
	game.flamethrowerpickups -= 1
	queue_free()


func _on_pickupcooldown_timeout() :
	animationdone = true
