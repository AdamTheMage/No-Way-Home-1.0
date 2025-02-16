extends Node2D

var gugglerspew = false
var flamethrowing = false

var spewdirection = Vector2.ZERO
var flamedirection = Vector2.ZERO

func _ready() :
	if get_node("/root/Game").pocketedition == true :
		queue_free()

func _process(delta) :
	if gugglerspew == true :
		position += spewdirection * 20 * delta
	if flamethrowing == true :
		position += flamedirection * 30 * delta

# Spaceship colliding with alien particles
func spaceship_collision_particles () :
	%spaceshipcollidewithmobparticles.emitting = true
	%spaceshipcollidewithmobparticles.visible = true

# if particle is blood :
func alien1blood() :
	%alien1bloodparticles.emitting = true
	%alien1bloodparticles.visible = true

func alien1bloodblue() :
	%alien1bloodparticlesblue.emitting = true
	%alien1bloodparticlesblue.visible = true

func gugglerblood() :
	%gugglerbloodparticles.emitting = true
	%gugglerbloodparticles.visible = true

func gugglerbloodblue() :
	%gugglerbloodparticlesblue.emitting = true
	%gugglerbloodparticlesblue.visible = true

func gugglerspewparticles() :
	gugglerspew = true
	%gugglerspewparticles.emitting = true
	%gugglerspewparticles.visible = true

func alien2blood () :
	%alien2bloodparticles.emitting = true
	%alien2bloodparticles.visible = true

func alien3blood () :
	%alien3bloodparticles.emitting = true
	%alien3bloodparticles.visible = true

func alien4blood () :
	%alien4bloodparticles.emitting = true
	%alien4bloodparticles.visible = true

func alien4missileparticles () :
	%alien4missileparticles.emitting = true
	%alien4missileparticles.visible = true

func lenurcherblood () :
	%lenurcherbloodparticles.emitting = true
	%lenurcherbloodparticles.visible = true
# World Instances
func asteroidcollision () :
	%asteroidcollisionparticles.emitting = true
	%asteroidcollisionparticles.visible = true

func shipmentexplosion () :
	%shipmentexplosion.emitting = true
	%shipmentexplosion.visible = true

func spaceshipmove_particles () :
	%spaceshipmoveparticles.emitting = true
	%spaceshipmoveparticles.visible = true

func spaceshipboost_particles () :
	%spaceshipboostparticles.emitting = true
	%spaceshipboostparticles.visible = true

# Weapons
func flamethrower_particles() :
	flamethrowing = true
	%flamethrowerparticles.emitting = true
	%flamethrowerparticles.visible = true

func flamethrowerreloaded_particles() :
	%flamethrowerreadyparticles.emitting = true
	%flamethrowerreadyparticles.visible = true

func lockonmissiletrail() :
	%lockonmissileparticles.emitting = true
	%lockonmissileparticles.visible = true


func _on_getrid_timeout() :
	%lenurcherbloodparticles.emitting = false
	%alien1bloodparticles.emitting = false
	%alien1bloodparticlesblue.emitting = false
	%gugglerbloodparticles.emitting = false
	%gugglerbloodparticlesblue.emitting = false
	%alien2bloodparticles.emitting = false
	%alien3bloodparticles.emitting = false
	%alien4bloodparticles.emitting = false
	%alien4missileparticles.emitting = false
	%asteroidcollisionparticles.emitting = false
	%spaceshipmoveparticles.emitting = false
	%spaceshipboostparticles.emitting = false
	%spaceshipcollidewithmobparticles.emitting = false
	%gugglerspewparticles.emitting = false
	%flamethrowerparticles.emitting = false
	%flamethrowerreadyparticles.emitting = false
	%shipmentexplosion.emitting = false
	flamethrowing = false
	gugglerspew = false
	%getrid.stop()


func _on_despawntimer_timeout() :
	queue_free()
