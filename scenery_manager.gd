extends Node3D

@export var rocks1: PackedScene
@export var rocks2: PackedScene
@export var rock1: PackedScene
@export var rock2: PackedScene
@export var solarpanel: PackedScene
@export var terrain_low: PackedScene
@export var terrain_mining: PackedScene
@export var windturbine: PackedScene
@export var building1: PackedScene
@export var building2: PackedScene
@export var building3: PackedScene
@export var building4: PackedScene
@export var building5: PackedScene
@export var building6: PackedScene
@export var building7: PackedScene
@export var building8: PackedScene

@onready var road_manager = get_node("/root/MainScene/RoadManager")
@export var scenery_segments: int = 5
@export var distance: float = 3.5 # Distance between scenery segments
@export var variance: float = .5 # Variance of of spawn position 
@export var scenery_ceiling: int = 10
@onready var player = get_node_or_null("/root/MainScene/player/car_police")

var current_scenery = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(scenery_segments):
		add_scenery()
		#add_ground_segment(i * -segment_length)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player.check_move() == false:
		return
	for segment in current_scenery:
		segment.position.z += road_manager.road_speed * delta  # Move scenes toward the player	
	# prevents crash on no scenery	
	if current_scenery.is_empty():
		return
		# Check if the first segment has moved too far
	var first_segment = current_scenery[0]
	if first_segment.position.z > 10:
		# Remove first segment
		current_scenery.pop_front().queue_free()


func add_scenery():
	var scenery_array = [0,0,0,0,0,0,0] #Scenery tracking array

	for i in scenery_array.size():
		if i == 3:
			scenery_array[i] = 0
		scenery_array[i] = RandomNumberGenerator.new().randi_range(0,scenery_ceiling)
		
	#print(debris_array)
		
	for i in scenery_array.size():
		var j = getx_position(i)
		var n: float = .2
		var d: int = -30
		var scene = null

		match scenery_array[i]:
			1: scene = rock1.instantiate()
			2: scene = rock2. instantiate()
			3: scene = rocks1.instantiate()
			4: scene = rocks2.instantiate()
			5: scene = solarpanel.instantiate()
			6: scene = terrain_low.instantiate()
			7:
				scene = terrain_mining.instantiate()
				n = gety_position() 
			8: scene = windturbine.instantiate()
			9: scene = building1.instantiate()
			10: scene =building2.instantiate()
			11: scene =building3.instantiate()
			12: scene =building4.instantiate()
			13: scene = building5.instantiate()
			14: scene = building6.instantiate()
			15: scene = building7.instantiate()
			16: scene = building8.instantiate()
		
		if scene:

			if scene is Node3D:
				scene.scale *= 1.3
				scene.rotate_y(RandomNumberGenerator.new().randf_range(-360,360))
				scene.position = Vector3(j, n, d)
				scene.add_to_group("debris")
			add_child(scene)
			current_scenery.append(scene)
		
func getx_position(index):
	if index > 3:
		index -= 3
		distance *= -1
		variance *= -1
		
	var lane = (index + 1) * distance
	var pos = RandomNumberGenerator.new().randf_range(lane, lane + variance)
	return pos
	
func gety_position():
	var pos = RandomNumberGenerator.new().randf_range(-.3,.5)
	return pos

func _on_timer_timeout() -> void:
	add_scenery() 
