class_name Player extends RigidBody3D

const ROAD_LEFT_LIMIT = -1.9
const ROAD_RIGHT_LIMIT = 1.9
@export var move_force: float = 10.0 #Adjust to control responsiveness
var can_move: bool = true
var life = 5

@onready var red_light = $RedLight
@onready var blue_light = $BlueLight
@onready var death_screen_scene = preload("res://scenes/death_screen.tscn")
@onready var camera = preload("res://scenes/camera_3d.tscn")

var flash_interval = 0.5 # Time between flashes
var flash_timer = 0.0
var toggle = true

func _physics_process(delta: float) -> void:
	if global_transform.origin.y < -5:
		var death_screen = death_screen_scene.instantiate()
		get_tree().current_scene.add_child(death_screen)
		can_move = false
		death_screen.show_death_screen()

	flash_timer += delta
	if flash_timer >= flash_interval:
		flash_timer = 0.0 # Reset Timer
		toggle = !toggle # switch state
		
		# Toggle lights
		blue_light.visible =  toggle
		red_light.visible = !toggle
		
	var direction = Vector3.ZERO
	position.x = clamp(position.x, ROAD_LEFT_LIMIT, ROAD_RIGHT_LIMIT) # Keep player on the road
	 
	if can_move:
		if Input.is_action_pressed("ui_left"):
			direction.x -= 1
		if Input.is_action_pressed("ui_right"):
			direction.x += 1
		#Apply Force to move left or right
		apply_central_force(direction * move_force)
		pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("body_entered", _on_body_entered)
	AudioPlayer.play_background_music()
	AudioPlayer.play_siren()

func _on_body_entered(body):
	# debris group node: 
	if (body.get_parent().get_parent().get_parent().is_in_group("debris") && body.get_parent().name != "road_straight"):
		if life > 1:
			life -= 1
		else:
			can_move = false
			var death_screen = death_screen_scene.instantiate()
			get_tree().current_scene.add_child(death_screen)
				# Make sure to show the death screen
			death_screen.show_death_screen()
		if "car" in body.get_parent().name:
			AudioPlayer.play_horn()
		else:
			AudioPlayer.play_crash()
		
func get_life():
	return life
	
func set_move_false():
	can_move = false
