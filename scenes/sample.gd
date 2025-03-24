extends Node3D
@onready var title_player = $player/car_police

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	title_player.set_move_false()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
