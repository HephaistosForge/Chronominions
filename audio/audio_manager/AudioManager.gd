extends Node

var background_music_past: Array = [
	preload("res://audio/music/background_music_past.ogg")
]

const background_music_present: Array = [
	preload("res://audio/music/background_music_present.ogg")
]

var background_music_future: Array = [
	preload("res://audio/music/background_music_future.ogg")
]
	
# define an object like sound_example for each individual sound you want to play
const sound_example: Array = [
	# provide a single or a list of sound files
	# # preload("<path_to_file>")
]

const button_click: Array = [
	
]

const button_hover: Array = [
	
]

var music_volume: float = 50
var sound_volume: float = 50
var current_player: AudioStreamPlayer


@onready var background_past_player = $BackgroundMusicPast
@onready var background_present_player = $BackgroundMusicPresent
@onready var background_future_player = $BackgroundMusicFuture


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_on_background_music_past_finished()
	_on_background_music_present_finished()
	_on_background_music_future_finished()

# SOUNDS

# to play a sound call AudioManager.play_sound_example()
func play_sound_example() -> void:
	if sound_example.is_empty():
		push_warning("This function should not be called since it is only an example function")
		return
	_create_sound_player(sound_example.pick_random(), null, false, 0.5)


func play_button_hover() -> void:
	if button_hover.is_empty():
		push_warning("No button hover sound defined yet. Please fill the Array button_hover with tracks to play")
		return
	_create_sound_player(button_hover.pick_random(), null, false, 0.5)


func play_button_click() -> void:
	if button_click.is_empty():
		push_warning("No button click sound defined yet. Please fill the Array button_click with sounds to play")
		return
	_create_sound_player(button_click.pick_random(), null, false, 0.5)


# HELPER
func set_sound_volume(percent:float) -> void:
	sound_volume = percent


func set_music_volume(percent:float) -> void:
	music_volume = percent


func set_player_volume_db(percent: float, player: AudioStreamPlayer):
	#player.volume_db = linear_to_db((float(music_volume)/100.0))
	player.volume_db = log(percent/100.0+exp(-80))*10
	print(percent, "is", player.volume_db)


func set_primary_player(epoch: Globals.Epoch):
	match epoch:
		Globals.Epoch.PAST:
			set_player_volume_db(music_volume, background_past_player)
			set_player_volume_db(0, background_present_player)
			set_player_volume_db(0, background_future_player)
			current_player = background_past_player
		Globals.Epoch.PRESENT:
			set_player_volume_db(0, background_past_player)
			set_player_volume_db(music_volume, background_present_player)
			set_player_volume_db(0, background_future_player)
			current_player = background_present_player
		Globals.Epoch.FUTURE:
			set_player_volume_db(0, background_past_player)
			set_player_volume_db(0, background_present_player)
			set_player_volume_db(music_volume, background_future_player)
			current_player = background_future_player

# creates a player with 
# sound: the array defined in this script with the given sound name
# position: if null the sound is played without a world-location
# modify: alters the pitch of the given sound to sound less repetetive
# volume_factor: use to balance sound volume vs master volume
func _create_sound_player(sound, position, modify = true, volume_factor: float =1) -> void:
	var player
	if position == null:
		player = AudioStreamPlayer.new()
	else:
		player = AudioStreamPlayer2D.new()
	get_tree().root.add_child(player)
	if position:
		player.global_position = position
	player.stream = sound
	player.volume_db = linear_to_db((float(sound_volume*volume_factor)/100.0)*2)
	player.play()
	if modify:
		player.pitch_scale = 1 + randf_range(-0.2, +0.2)
	player.finished.connect(_on_sound_finished.bind(player))


func _on_sound_finished(player) -> void:
	player.queue_free()

func sync_players():
	var sync_pos = background_past_player.get_playback_position()
	background_future_player.seek(sync_pos)
	background_present_player.seek(sync_pos)

func _on_background_music_past_finished() -> void:
	background_past_player.stream = background_music_past.pick_random()
	background_past_player.play()
	sync_players()


func _on_background_music_present_finished() -> void:
	background_present_player.stream = background_music_present.pick_random()
	background_present_player.play()


func _on_background_music_future_finished() -> void:
	background_future_player.stream = background_music_future.pick_random()
	background_future_player.play()
