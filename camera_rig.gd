extends Node3D
@export var player: RigidBody3D
@onready var camera_3d = $Camera3D

@export var stage_dimensions: Vector2
@onready var sample = preload("res://scenes/sample.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if sample:
		if (get_tree().current_scene.name == "TitleScreen") or (get_tree().current_scene.name == "End Screen"):
			camera_3d.current = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if camera_3d.current == true:
		position = lerp(position, player.position, delta * 10.0)
		position.x = clampf(position.x, -stage_dimensions.x/2, stage_dimensions.x/2)
		position.z = clampf(position.z, -stage_dimensions.y/2, stage_dimensions.y/2)
	
		camera_3d.look_at(((player.position + position) / 2)+ Vector3.UP, Vector3.UP)
	
