class_name Road extends Node3D
#13 Debris Scenes:
@export var road_scene: PackedScene  #Drag in your RoadSegment.tscn
@export var car5_scene: PackedScene
@export var bush_scene: PackedScene
@export var car1_scene: PackedScene
@export var car2_scene: PackedScene
@export var car3_scene: PackedScene
@export var car4_scene: PackedScene
@export var dumpster_scene: PackedScene
@export var red_scene: PackedScene
@export var traffic1_scene: PackedScene
@export var traffic2_scene: PackedScene
@export var traffic3_scene: PackedScene
@export var watertower_scene: PackedScene
@export var max_speed: int = 30
@onready var player = get_node_or_null("/root/MainScene/player/car_police")
@onready var world_env = get_node("/root/MainScene/WorldEnvironment")
@onready var sky_material = world_env.environment.sky.sky_material
@export var sun_speed = 0.01
@export var start_brightness: int = 5
@export var segment_length: float = 4  # Must match road segment size, SCALE IS 2 so Length is 4
@export var num_segments: int = 15  # Number of segments to keep at once
@export var start_speed: float = 1 # How fast the roads move
@export var debris_ceiling: int = 30
@export var enemy_car: int = 2 #Added speed for enemy cars
var debris_age = 0

var road_segments = []  # Stores active road segments
var road_array = [] #Stores items generated from add_debris()
var road_speed: float = start_speed  # Initialize properly
var sunset_speed: float = sun_speed

func _ready():
	road_speed = start_speed
	sunset_speed = sun_speed
	sky_material.energy_multiplier = start_brightness 
	# Spawn initial road segments
	for i in range(num_segments):
		add_road_segment(i * -segment_length)
	
		

		
func add_road_segment(z_position):
	var segment = road_scene.instantiate()
	segment.position = Vector3(0, 0, z_position)
	add_child(segment)
	road_segments.append(segment)
	#BELow is getting the size of the mesh layer for the road
	var segment_mesh = segment.get_node("road_straight")
	if segment_mesh:
		var aabb = segment_mesh.get_aabb() #gets the bound box
		
	var road_seed = RandomNumberGenerator.new().randi_range(0,100)
	#print("Seed: ", seed)
	if road_seed < 30:
		#pass
		add_debris()
	return 0
	

func _process(delta):
	if player.check_move() == false:
		return
	if world_env and world_env.environment:
		
		if sky_material is ProceduralSkyMaterial:
			sky_material.sun_angle_max += delta * 5
			sky_material.energy_multiplier = max(0, sky_material.energy_multiplier - delta * sunset_speed)
			
	if road_speed < max_speed:
		#gradually change road speed 
		road_speed += .001 
	if (is_equal_approx(road_speed, max_speed)) and (player.check_move() == true):
		get_tree().change_scene_to_file("res://scenes/end_screen.tscn")
	
	for segment in road_segments:
		segment.position.z += road_speed * delta  # Move road toward the player	
		
	for segment in road_array:
		var node_name = segment.name

		if "Car" in node_name:
			segment.position.z += (road_speed + enemy_car) * delta
		else:
			segment.position.z += road_speed * delta # Move the debris towards player
		
	# Check if the first segment has moved too far
	var first_segment = road_segments[0]
	if first_segment.position.z > 10:
		# Remove first segment
		road_segments.pop_front().queue_free()
		# Get last segment's position to attach the new one seamlessly
		var last_segment = road_segments[-1]
		add_road_segment(last_segment.position.z - segment_length)
	if road_array.size() > 0:	
		var first_debris = road_array[0]
		if first_debris.position.z > 10:
			road_array.pop_front().queue_free()

func add_debris():
	var tracker = 0
	var debris_array = [0,0,0,0] #Debris tracking array
	
	if debris_age < num_segments/2:
		debris_age += 1
		return

	for i in debris_array.size():
		debris_array[i] = RandomNumberGenerator.new().randi_range(0,debris_ceiling)
		# Ensure it does not spawn on all lanes
		if (debris_array[i] >=1) and (debris_array[i] <= 12):
			tracker += 1 
	if tracker > 3:
		debris_array[RandomNumberGenerator.new().randi_range(0,3)] = 0 #Prevents spawning on all 4 lanes
	for i in debris_array.size():
		var j = getx_position(i)
		var n: float = .2
		var d: int = -20
		var scene = null
		
		match debris_array[i]:
			1: scene = car5_scene.instantiate()
			2: scene = bush_scene. instantiate()
			3: scene = car1_scene.instantiate()
			4: scene = car2_scene.instantiate()
			5: scene = car3_scene.instantiate()
			6: scene = car4_scene.instantiate()
			7: scene = dumpster_scene.instantiate()
			8: scene = red_scene.instantiate()
			9: scene = traffic1_scene.instantiate()
			10: scene = traffic2_scene.instantiate()
			11: scene = traffic3_scene.instantiate()
			12: scene = watertower_scene.instantiate()
			
		if scene: 
			if scene is Node3D:
				scene.scale *= 1.8
				scene.position = Vector3(j, n, d)
				scene.add_to_group("debris")
			add_child(scene)
			road_array.append(scene)
		
func getx_position(index):
	var lane1 = -1.477
	var lane2 = -.5
	var lane3 = .738
	var lane4 = 1.55
	if index == 0:
		return lane1
	if index == 1:
		return lane2
	if index == 2:
		return lane3
	if index == 3:
		return lane4
		
func get_speed():
	return road_speed
