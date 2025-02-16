extends Node2D

signal gameresumed
signal gamepaused

var game_paused = false
var currentbuttonrestart = false
var currentbuttonsettings = false
var currentbuttonhowtoplay = false
var currentbuttonquit = false
var manualopen = false
var settingsopen = false
var initialmanual = false

# Sliders
# Music Volume :
var musicsliderhighlighted = false
var musicdrag = false

var master_bus = AudioServer.get_bus_index("Master")
var master_volume = 0.05
var db_master_volume = 0.0
var master_volume_linear = 0
var originalmaster_volume = 0

# Resolution 
var resolutionsliderhighlighted = false
var resolutiondrag = false
var resolution_value = 0

# Frame Rate
var frameratesliderhighlighted = false
var frameratedrag = false
var framerate_value = 0

# V-Sync
var vsyncsliderhighlighted = false
var vsyncdrag = false
var vsync_value = 0

# Rotation Speed
var rotationspeed_value = 0
var rotationspeedsliderhighlighted = false
var rotationspeeddrag = false

@onready var player = get_node("/root/Game/PlayerCharacter")
@onready var playerstats = get_node("/root/Game/PlayerCharacter/UI/stats")

func _ready() :
	# Initial Values :
	%MusicVolumeSlider.value = master_volume * 100
	%ResolutionSlider.value = resolution_value
	%FrameRateSlider.value = framerate_value
	%RotationSpeedSlider.value = rotationspeed_value
	%VsyncSlider.value = vsync_value
	db_master_volume = db_to_linear(master_bus) * 100
	rotationspeed_value = 0.75

func _process(_delta: float) :
	# Slider Updates for Settings:
		# Volume Changes
	%MusicPercentage.text = str(round(master_volume * 100)) + "%"
	%MusicVolumeSlider.value = master_volume * 100
	AudioServer.set_bus_volume_db(master_bus, linear_to_db(master_volume))
		# Resolution Changes
	%ResolutionSlider.value = resolution_value
	%UpdatedResolutionScale.text = str(get_window().get_size())
	if resolution_value == 1 :
		get_viewport().size = (Vector2(800, 600))
	if resolution_value == 2 :
		get_viewport().size = (Vector2(1024, 600))
	if resolution_value == 3 :
		get_viewport().size = (Vector2(1600, 900))
	if resolution_value == 4 :
		get_viewport().size = (Vector2(1440, 900))
	if resolution_value == 5 :
		get_viewport().size = (Vector2(1280, 720))
	if resolution_value == 6 :
		get_viewport().size = (Vector2(1366, 768))
	if resolution_value == 7 :
		get_viewport().size = (Vector2(1920, 1080))
	if resolution_value == 8 :
		get_viewport().size = (Vector2(2560, 1440))
	if resolution_value == 9 :
		get_viewport().size = (Vector2(3840, 2160))
		# Frame Rate Changes
	%UpdatedFrameRate.text = "60 FPS"
	%FrameRateSlider.value = framerate_value
	%UpdatedFrameRate.text = str(Engine.max_fps) + " FPS"
	if framerate_value == 1 :
		%UpdatedFrameRate.text = "30 FPS"
		Engine.max_fps = 30
	if framerate_value == 2 :
		%UpdatedFrameRate.text = "60 FPS"
		Engine.max_fps = 60
	if framerate_value == 3 :
		%UpdatedFrameRate.text = "120 FPS"
		Engine.max_fps = 120
	if framerate_value == 4 :
		%UpdatedFrameRate.text = "Uncapped"
		Engine.max_fps = 0
	
		# V-Sync Changes
	%UpdatedVsync.text = "Enabled"
	%VsyncSlider.value = vsync_value
	%UpdatedVsync.text = str(DisplayServer.window_get_vsync_mode())
	if vsync_value == 1 :
		%UpdatedVsync.text = "Disabled"
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
	if vsync_value == 2 :
		%UpdatedVsync.text = "Enabled"
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	if vsync_value == 3 :
		%UpdatedVsync.text = "Adaptive"
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ADAPTIVE)
	if vsync_value == 4 :
		%UpdatedVsync.text = "Mailbox"
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_MAILBOX)
	
		# Rotation Speed Changes :
	%PlayerCharacter.rotationincrement = rotationspeed_value
	%RotationSpeedSlider.value = rotationspeed_value
	%UpdatedRotationSpeed.text = str(rotationspeed_value) + " / Default: 0.75"
	
	if player.playerdeaded == false :
		if Input.is_action_just_pressed("game_paused") :
			if game_paused == true :
				if manualopen == false and settingsopen == false :
					if get_node("/root/Game").pocketedition == false :
						Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED_HIDDEN)
					%GamePausedScreen.visible = false
					%MainMenuExitButton.visible = false
					%MainMenuExitButton.disabled = true
					get_tree().paused = false
					game_paused = false
					gameresumed.emit()
					# Disabling all of the previous menus :
					game_paused = false
					musicdrag = false
					musicsliderhighlighted = false
					resolutiondrag = false
					resolutionsliderhighlighted = false
					frameratedrag = false
					frameratesliderhighlighted = false
					vsyncdrag = false
					vsyncsliderhighlighted = false
					rotationspeeddrag = false
					rotationspeedsliderhighlighted = false
					currentbuttonrestart = false
					currentbuttonsettings = false
					currentbuttonhowtoplay = false
					currentbuttonquit = false
			elif game_paused == false :
				if initialmanual == false :
					Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
					%MainMenuExitButton.visible = true
					%MainMenuExitButton.disabled = false
					%GamePausedScreen.visible = true
					get_tree().paused = true
					game_paused = true
					gamepaused.emit()
				# Pause Menu :
	# Starters :
		if settingsopen == false  and manualopen == false :
			if Input.is_action_just_pressed("move_up") :
				if currentbuttonquit == false :
					if currentbuttonhowtoplay == false :
						if currentbuttonsettings == false :
							if game_paused == true :
								%QuitButton.grab_focus() 
								await get_tree().create_timer(0.1).timeout
								currentbuttonquit = true
								currentbuttonrestart = false
			if Input.is_action_just_pressed("move_down") :
				if currentbuttonrestart == false :
					if currentbuttonsettings == false :
						if currentbuttonhowtoplay == false :
							if game_paused == true :
								%RestartButton.grab_focus() 
								await get_tree().create_timer(0.1).timeout
								currentbuttonrestart = true
								currentbuttonquit = false
						#########################
			if Input.is_action_just_pressed("move_up") :
				if currentbuttonrestart == true :
					if game_paused == true :
						%QuitButton.grab_focus() 
						%RestartButton.release_focus()
						await get_tree().create_timer(0.1).timeout
						currentbuttonrestart = false
						currentbuttonquit = true
			if Input.is_action_just_pressed("move_down") :
				if currentbuttonrestart == true :
					if game_paused == true :
						%SettingsButton.grab_focus() 
						%RestartButton.release_focus()
						await get_tree().create_timer(0.1).timeout
						currentbuttonrestart = false
						currentbuttonsettings = true
			if Input.is_action_just_pressed("move_up") :
				if currentbuttonquit == true :
					if game_paused == true :
						%HowToPlayButton.grab_focus() 
						%QuitButton.release_focus()
						await get_tree().create_timer(0.1).timeout
						currentbuttonquit = false
						currentbuttonhowtoplay = true
			if Input.is_action_just_pressed("move_down") :
				if currentbuttonquit == true :
					if game_paused == true :
						%RestartButton.grab_focus() 
						%QuitButton.release_focus()
						await get_tree().create_timer(0.1).timeout
						currentbuttonquit = false
						currentbuttonrestart = true
							
			if Input.is_action_just_pressed("move_up") :
				if currentbuttonhowtoplay == true :
					if game_paused == true :
						%SettingsButton.grab_focus() 
						%HowToPlayButton.release_focus()
						await get_tree().create_timer(0.1).timeout
						currentbuttonhowtoplay = false
						currentbuttonsettings = true
			if Input.is_action_just_pressed("move_down") :
				if currentbuttonhowtoplay == true :
					if game_paused == true :
						%QuitButton.grab_focus() 
						%HowToPlayButton.release_focus()
						await get_tree().create_timer(0.1).timeout
						currentbuttonhowtoplay = false
						currentbuttonquit = true
							
			if Input.is_action_just_pressed("move_up") :
				if currentbuttonsettings == true :
					if game_paused == true :
						%RestartButton.grab_focus() 
						%SettingsButton.release_focus()
						await get_tree().create_timer(0.1).timeout
						currentbuttonsettings = false
						currentbuttonrestart = true
			if Input.is_action_just_pressed("move_down") :
				if currentbuttonsettings == true :
					if game_paused == true :
						%HowToPlayButton.grab_focus() 
						%SettingsButton.release_focus()
						await get_tree().create_timer(0.1).timeout
						currentbuttonsettings = false
						currentbuttonhowtoplay = true
		# Entering options in the menu :
		if Input.is_action_just_pressed("boost") :
			if currentbuttonrestart == true :
				get_tree().reload_current_scene()
			if currentbuttonsettings == true :
					%SettingsManual.visible = true
					%SettingsManual.visible = true
					settingsopen = true
					%QuitButton.visible = false
					%RestartButton.visible = false
					%SettingsButton.visible = false
					%HowToPlayButton.visible = false
					%RestartPress.disabled = true
					%SettingsPress.disabled = true
					%ManualPress.disabled = true
					%QuitPress.disabled = true
					%MusicVolumeSlider.editable = true
					%ResolutionSlider.editable = true
					%FrameRateSlider.editable = true
					%VsyncSlider.editable = true
					%RotationSpeedSlider.editable = true
					%SettingsExitButton.disabled = false
					pass
			if currentbuttonhowtoplay == true :
					%ManualExitButton.disabled = true
					%Manual.visible = true
					manualopen = true
					pass
			if currentbuttonquit == true :
				get_tree().quit()
		
		if Input.is_action_just_pressed("game_paused") :
			if settingsopen == true :
				musicsliderhighlighted = false
				musicdrag = false
				resolutionsliderhighlighted = false
				resolutiondrag = false
				%SettingsManual.visible = false
				settingsopen = false
				%QuitButton.visible = true
				%RestartButton.visible = true
				%SettingsButton.visible = true
				%HowToPlayButton.visible = true
				%RestartPress.disabled = false
				%SettingsPress.disabled = false
				%ManualPress.disabled = false
				%QuitPress.disabled = false
				%MusicVolumeSlider.editable = false
				%ResolutionSlider.editable = false
				%FrameRateSlider.editable = false
				%VsyncSlider.editable = false
				%RotationSpeedSlider.editable = false
				%SettingsExitButton.disabled = true
				%MainMenuExitButton.visible = true
				%MainMenuExitButton.disabled = false
				pass
			if manualopen == true :
				%MainMenuExitButton.visible = true
				%MainMenuExitButton.disabled = false
				%ManualExitButton.disabled = true
				%Manual.visible = false
				manualopen = false
				pass
		# To Control Settings Sliders :
			# Navigating Between Sliders
				# Initial up or down
		if Input.is_action_just_pressed("move_down") and musicsliderhighlighted == false and frameratesliderhighlighted == false  and resolutionsliderhighlighted == false :
			if settingsopen == true :
				%MusicVolumeSlider.grab_focus()
				await get_tree().create_timer(0.1).timeout
				musicsliderhighlighted = true
		if Input.is_action_just_pressed("move_up") and vsyncsliderhighlighted == false and resolutionsliderhighlighted == false :
			if settingsopen == true :
				%VsyncSlider.grab_focus()
				await get_tree().create_timer(0.1).timeout
				vsyncsliderhighlighted = true
				# Once one is already selected :
			# Right to Left
		if Input.is_action_just_pressed("move_right") and musicsliderhighlighted == true :
			if musicdrag == false :
				if settingsopen == true :
					%RotationSpeedSlider.grab_focus()
					%ResolutionSlider.release_focus()
					%FrameRateSlider.release_focus()
					%MusicVolumeSlider.release_focus()
					%VsyncSlider.release_focus()
					await get_tree().create_timer(0.1).timeout
					resolutiondrag = false
					frameratedrag = false
					musicdrag = false
					vsyncdrag = false
					rotationspeedsliderhighlighted = true
					resolutionsliderhighlighted = false
					frameratesliderhighlighted = false
					vsyncsliderhighlighted = false
					musicsliderhighlighted = false
				
		if Input.is_action_just_pressed("move_left") and rotationspeedsliderhighlighted == true and rotationspeeddrag == false :
			if settingsopen == true :
				%RotationSpeedSlider.release_focus()
				%MusicVolumeSlider.grab_focus()
				await get_tree().create_timer(0.1).timeout
				rotationspeeddrag = false
				rotationspeedsliderhighlighted = false
				musicsliderhighlighted = true
			# Down Left :
		if Input.is_action_just_pressed("move_down") and resolutionsliderhighlighted == true :
			if settingsopen == true :
				%FrameRateSlider.grab_focus()
				%ResolutionSlider.release_focus()
				await get_tree().create_timer(0.1).timeout
				resolutiondrag = false
				frameratesliderhighlighted = true
				resolutionsliderhighlighted = false
		if Input.is_action_just_pressed("move_down") and musicsliderhighlighted == true :
			if settingsopen == true :
				%ResolutionSlider.grab_focus()
				%MusicVolumeSlider.release_focus()
				await get_tree().create_timer(0.1).timeout
				musicdrag = false
				musicsliderhighlighted = false
				resolutionsliderhighlighted = true
		if Input.is_action_just_pressed("move_up") and musicsliderhighlighted == true :
			if settingsopen == true :
				%VsyncSlider.grab_focus()
				%MusicVolumeSlider.release_focus()
				await get_tree().create_timer(0.1).timeout
				musicdrag = false
				musicsliderhighlighted = false
				vsyncsliderhighlighted = true
		if Input.is_action_just_pressed("move_up") and resolutionsliderhighlighted == true :
			if settingsopen == true :
				%MusicVolumeSlider.grab_focus()
				%ResolutionSlider.release_focus()
				await get_tree().create_timer(0.1).timeout
				resolutiondrag = false
				musicsliderhighlighted = true
				resolutionsliderhighlighted = false
		if Input.is_action_just_pressed("move_down") and frameratesliderhighlighted == true :
			if settingsopen == true :
				%VsyncSlider.grab_focus()
				%FrameRateSlider.release_focus()
				await get_tree().create_timer(0.1).timeout
				frameratesliderhighlighted = false
				frameratedrag = false
				vsyncsliderhighlighted = true
		if Input.is_action_just_pressed("move_up") and frameratesliderhighlighted == true :
			if settingsopen == true :
				%ResolutionSlider.grab_focus()
				%FrameRateSlider.release_focus()
				await get_tree().create_timer(0.1).timeout
				frameratedrag = false
				frameratesliderhighlighted = false
				resolutionsliderhighlighted = true
		if Input.is_action_just_pressed("move_down") and vsyncsliderhighlighted == true :
			if settingsopen == true :
				%MusicVolumeSlider.grab_focus()
				%VsyncSlider.release_focus()
				await get_tree().create_timer(0.1).timeout
				vsyncsliderhighlighted = false
				vsyncdrag = false
				musicsliderhighlighted = true
		if Input.is_action_just_pressed("move_up") and vsyncsliderhighlighted == true :
			if settingsopen == true :
				%FrameRateSlider.grab_focus()
				%VsyncSlider.release_focus()
				await get_tree().create_timer(0.1).timeout
				vsyncdrag = false
				vsyncsliderhighlighted = false
				frameratesliderhighlighted = true
			# VOLUME
				
		if Input.is_action_just_pressed("boost") :
			if musicsliderhighlighted == true :
				if musicdrag == false :
					await get_tree().create_timer(0.1).timeout
					_on_music_volume_slider_drag_started()
		if Input.is_action_just_pressed("boost") :
			if musicsliderhighlighted == true :
				if musicdrag == true :
					await get_tree().create_timer(0.1).timeout
					_on_music_volume_slider_drag_ended()
				
		if Input.is_action_pressed("move_right") :
			if musicdrag == true :
				if master_volume < 1 :
					master_volume += 0.001
		if Input.is_action_pressed("move_left") :
			if musicdrag == true :
				if master_volume > 0 :
					master_volume -= 0.001
			# Resolution
		if Input.is_action_just_pressed("boost") :
			if resolutionsliderhighlighted == true :
				if resolutiondrag == false :
					await get_tree().create_timer(0.1).timeout
					_on_resolution_slider_drag_started()
		if Input.is_action_just_pressed("boost") :
			if resolutionsliderhighlighted == true :
				if resolutiondrag == true :
					await get_tree().create_timer(0.1).timeout
					_on_resolution_slider_drag_ended()
				
		if Input.is_action_just_pressed("move_right") :
			if resolutiondrag == true :
				if resolution_value < 9 :
					resolution_value += 1
		if Input.is_action_just_pressed("move_left") :
			if resolutiondrag == true :
				if resolution_value > 1 :
					resolution_value -= 1
			# Frame Rate
		if Input.is_action_just_pressed("boost") :
			if frameratesliderhighlighted == true :
				if frameratedrag == false :
					await get_tree().create_timer(0.1).timeout
					_on_frame_rate_slider_drag_started()
		if Input.is_action_just_pressed("boost") :
			if frameratesliderhighlighted == true :
				if frameratedrag == true :
					await get_tree().create_timer(0.1).timeout
					_on_frame_rate_slider_drag_ended()
				
		if Input.is_action_just_pressed("move_right") :
			if frameratedrag == true :
				if framerate_value < 4 :
					framerate_value += 1
		if Input.is_action_just_pressed("move_left") :
			if frameratedrag == true :
				if framerate_value > 1 :
					framerate_value -= 1
			# V-Sync
		if Input.is_action_just_pressed("boost") :
			if vsyncsliderhighlighted == true :
				if vsyncdrag == false :
					await get_tree().create_timer(0.1).timeout
					_on_vsync_slider_drag_started()
		if Input.is_action_just_pressed("boost") :
			if vsyncsliderhighlighted == true :
				if vsyncdrag == true :
					await get_tree().create_timer(0.1).timeout
					_on_vsync_slider_drag_ended()
				
		if Input.is_action_just_pressed("move_right") :
			if vsyncdrag == true :
				if vsync_value < 4 :
					vsync_value += 1
		if Input.is_action_just_pressed("move_left") :
			if vsyncdrag == true :
				if vsync_value > 1 :
					vsync_value -= 1
			# Rotation Speed :
		if Input.is_action_just_pressed("boost") :
			if rotationspeedsliderhighlighted == true :
				if rotationspeeddrag == false :
					await get_tree().create_timer(0.1).timeout
					_on_rotation_speed_slider_drag_started()
		if Input.is_action_just_pressed("boost") :
			if rotationspeedsliderhighlighted == true :
				if rotationspeeddrag == true :
					await get_tree().create_timer(0.1).timeout
					_on_rotation_speed_slider_drag_ended()
				
		if Input.is_action_just_pressed("move_right") :
			if rotationspeeddrag == true :
				if rotationspeed_value < 2 :
					rotationspeed_value += 0.05
		if Input.is_action_just_pressed("move_left") :
			if rotationspeeddrag == true :
				if rotationspeed_value > 0 :
					rotationspeed_value -= 0.05
	# Player Death
	if player.playerdeaded == true :
		gamepaused.emit()
		if Input.is_action_just_pressed("boost") :
			get_tree().call_deferred("reload_current_scene")
			
	if %VictoryScreen.visible == true :
		if Input.is_action_just_pressed("boost") :
			get_tree().call_deferred("reload_current_scene")
		
	if Input.is_action_just_pressed("boost") and initialmanual == true and player.playerdeaded == false :
		gameresumed.emit()
		initialmanual = false
		%GamePausedScreen.visible = false
		%NoWayHomeTitle.visible = true
		%StartingManual.visible = false
		%ManualX.visible = true
		%boosttobegin.visible = false
		%RestartButton.visible = true
		%SettingsButton.visible = true
		%HowToPlayButton.visible = true
		%QuitButton.visible = true
		get_tree().paused = false
		# Engine.time_scale = 0.25 (idea around a slowmo tutorial or cinematic mind player idek)

func _on_restart_button_focus_entered() :
	pass


func _on_settings_button_focus_entered() :
	pass

func _on_how_to_play_button_focus_entered() :
	pass


func _on_quit_button_focus_entered() :
	pass


func _on_game_initialmanualtrue() :
	gamepaused.emit()
	initialmanual = true


func _on_music_volume_slider_drag_started() :
		musicdrag = true


func _on_music_volume_slider_drag_ended() :
		musicdrag = false
		%MusicVolumeSlider.release_focus()


func _on_resolution_slider_drag_started() :
		resolutiondrag = true

func _on_resolution_slider_drag_ended() :
		resolutiondrag = false
		%ResolutionSlider.release_focus()


func _on_frame_rate_slider_drag_started() :
		frameratedrag = true

func _on_frame_rate_slider_drag_ended() :
		frameratedrag = false
		%FrameRateSlider.release_focus()


func _on_vsync_slider_drag_started() :
		vsyncdrag = true


func _on_vsync_slider_drag_ended() :
	if get_node("/root/Game").pocketedition == false :
		vsyncdrag = false
		%VsyncSlider.release_focus()


func _on_rotation_speed_slider_drag_started() :
		rotationspeeddrag = true


func _on_rotation_speed_slider_drag_ended() :
		rotationspeeddrag = false
		%RotationSpeedSlider.release_focus()

#############################################################################################

# For Pocket Edition :
func _on_player_character_gamepaused() :
	_on_pocket_edition_pause_pressed()

func _on_pocket_edition_pause_pressed() :
		if player.playerdeaded == false :
			if game_paused == true :
				if manualopen == false and settingsopen == false :
					if get_node("/root/Game").pocketedition == false :
						Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED_HIDDEN)
					%GamePausedScreen.visible = false
					get_tree().paused = false
					game_paused = false
					gameresumed.emit()
					# Disabling all of the previous menus :
					game_paused = false
					musicdrag = false
					musicsliderhighlighted = false
					resolutiondrag = false
					resolutionsliderhighlighted = false
					frameratedrag = false
					frameratesliderhighlighted = false
					vsyncdrag = false
					vsyncsliderhighlighted = false
					rotationspeeddrag = false
					rotationspeedsliderhighlighted = false
					currentbuttonrestart = false
					currentbuttonsettings = false
					currentbuttonhowtoplay = false
					currentbuttonquit = false
			elif game_paused == false :
				if initialmanual == false :
					%GamePausedScreen.visible = true
					%MainMenuExitButton.visible = true
					%MainMenuExitButton.disabled = false
					get_tree().paused = true
					game_paused = true
					gamepaused.emit()

func _on_restart_press_pressed() :
	get_tree().reload_current_scene()

func _on_settings_press_pressed() :
	%SettingsManual.visible = true
	settingsopen = true
	%QuitButton.visible = false
	%RestartButton.visible = false
	%SettingsButton.visible = false
	%HowToPlayButton.visible = false
	%RestartPress.disabled = true
	%SettingsPress.disabled = true
	%ManualPress.disabled = true
	%QuitPress.disabled = true
	%MusicVolumeSlider.editable = true
	%ResolutionSlider.editable = true
	%FrameRateSlider.editable = true
	%VsyncSlider.editable = true
	%RotationSpeedSlider.editable = true

func _on_manual_press_pressed() :
	%Manual.visible = true
	manualopen = true

func _on_quit_press_pressed() :
	get_tree().quit()


# Pocket Edition Slider Bits :

func _on_vsync_r_pressed() :
	if vsync_value < 4 :
		vsync_value += 1

func _on_vsync_l_pressed() :
	if vsync_value > 1 :
		vsync_value -= 1


func _on_rotation_speed_r_pressed() :
	if rotationspeed_value < 2 :
		rotationspeed_value += 0.05

func _on_rotation_speed_l_pressed() :
	if rotationspeed_value > 0 :
		rotationspeed_value -= 0.05


func _on_frame_rate_r_pressed() :
	if framerate_value < 4 :
		framerate_value += 1

func _on_frame_rate_l_pressed() :
	if framerate_value > 1 :
		framerate_value -= 1


func _on_resolution_r_pressed() :
	if resolution_value < 9 :
		resolution_value += 1

func _on_resolution_l_pressed() :
	if resolution_value > 1 :
		resolution_value -= 1


func _on_music_r_pressed() :
	if master_volume < 1 :
		master_volume += 0.01

func _on_music_l_pressed() :
	if master_volume > 0 :
		master_volume -= 0.01


# Exit Buttons :

func _on_settings_exit_button_pressed() :
	if settingsopen == true :
		musicsliderhighlighted = false
		musicdrag = false
		resolutionsliderhighlighted = false
		resolutiondrag = false
		%SettingsManual.visible = false
		settingsopen = false
		%MainMenuExitButton.visible = true
		%MainMenuExitButton.disabled = false
		%QuitButton.visible = true
		%RestartButton.visible = true
		%SettingsButton.visible = true
		%HowToPlayButton.visible = true
		%RestartPress.disabled = false
		%SettingsPress.disabled = false
		%ManualPress.disabled = false
		%QuitPress.disabled = false
		%MusicVolumeSlider.editable = false
		%ResolutionSlider.editable = false
		%FrameRateSlider.editable = false
		%VsyncSlider.editable = false
		%RotationSpeedSlider.editable = false
		pass

func _on_manual_exit_button_pressed() :
	if manualopen == true :
		%Manual.visible = false
		manualopen = false
		pass

func _on_intro_manual_exit_button_pressed() :
	gameresumed.emit()
	initialmanual = false
	%GamePausedScreen.visible = false
	%MainMenuExitButton.visible = true
	%MainMenuExitButton.disabled = false
	%NoWayHomeTitle.visible = true
	%StartingManual.visible = false
	%ManualX.visible = true
	%boosttobegin.visible = false
	%RestartButton.visible = true
	%SettingsButton.visible = true
	%HowToPlayButton.visible = true
	%QuitButton.visible = true
	%IntroManualExitButton.disabled = true
	get_tree().paused = false

# Main Menu Exit :

func _on_main_menu_exit_button_pressed() :
	if game_paused == true :
		if manualopen == false and settingsopen == false :
			if get_node("/root/Game").pocketedition == false :
				Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED_HIDDEN)
			%GamePausedScreen.visible = false
			get_tree().paused = false
			game_paused = false
			gameresumed.emit()
			# Disabling all of the previous menus :
			game_paused = false
			musicdrag = false
			musicsliderhighlighted = false
			resolutiondrag = false
			resolutionsliderhighlighted = false
			frameratedrag = false
			frameratesliderhighlighted = false
			vsyncdrag = false
			vsyncsliderhighlighted = false
			rotationspeeddrag = false
			rotationspeedsliderhighlighted = false
			currentbuttonrestart = false
			currentbuttonsettings = false
			currentbuttonhowtoplay = false
			currentbuttonquit = false
#################################################################################################
