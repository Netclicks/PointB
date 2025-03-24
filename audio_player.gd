extends Node
@onready var background_music_path = $BackgroundSound
@onready var siren_path = $SirenSound
@onready var horn_path = $HornSound
@onready var crash_path = $CrashSound

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	background_music_path.volume_db = 0
	siren_path.volume_db = -20
	horn_path.volume_db = 50
	crash_path.volume_db = 50
func play_background_music():
	if not background_music_path.playing:
		background_music_path.play()
func play_siren():
	if not siren_path.playing:
		siren_path.play()
func play_crash():
	if not crash_path.playing:
		crash_path.play()
func play_horn():
	if not horn_path.playing:
		horn_path.play()	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
