extends Node2D

var whichmeteor = 0

func _ready () :
# Disabling all meteors to be re-enabled through randomisation :
	randomize()
	var randsize = randf_range(0.5, 1.2)
	scale = Vector2(randsize, randsize)
	%meteor1.monitoring = false
	%meteor1.visible = false
	%meteor2.monitoring = false
	%meteor2.visible = false
	%meteor3.monitoring = false
	%meteor3.visible = false
	%meteor4.monitoring = false
	%meteor4.visible = false
	
	whichmeteor = randi_range(1, 4)
	if whichmeteor == 1 :
		%meteor1.monitoring = true
		%meteor1.visible = true
	if whichmeteor == 2 :
		%meteor2.monitoring = true
		%meteor2.visible = true
	if whichmeteor == 3 :
		%meteor3.monitoring = true
		%meteor3.visible = true
	if whichmeteor == 4 :
		%meteor4.monitoring = true
		%meteor4.visible = true
	
	await get_tree().create_timer(20).timeout
	queue_free()
	
func _physics_process(delta) :
	var leftorrightx = randi_range(1, 2)
	var randy = randf_range(0.5, 2)
	var  randx = 0.0
	if leftorrightx == 1 :
		randx = randf_range(-0.5, 0)
	if leftorrightx == 2 :
		randx = randf_range(0, 0.5)
	
	var direction = Vector2(randx, randy)
	
	position += direction * 45 * delta
	


func _on_meteor_1_body_entered(body) :
	if body.has_method("meteored") :
		body.meteored()
