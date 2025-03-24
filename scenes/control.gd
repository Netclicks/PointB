extends Control
@onready var speed_label = $SpeedLabel
@onready var life_label = $LifeLabel
@onready var speed = get_node("/root/MainScene/RoadManager")
@onready var life = get_node("/root/MainScene/player/car_police")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	speed_label.anchor_left = 0
	speed_label.anchor_right = 0
	speed_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
	speed_label.position.x = 50
	
	life_label.anchor_left = 1
	life_label.anchor_right = 1
	life_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	life_label.position.x = 400
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if speed:
		speed_label.text = str(round(speed.get_speed() * 3)) + "m/h"
		life_label.text = "Hits Remaining: " + str(life.get_life())
