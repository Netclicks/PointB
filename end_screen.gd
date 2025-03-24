extends Control
@onready var sample_light = $Sample/WorldEnvironment
@onready var sky_material = sample_light.environment.sky.sky_material
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sky_material.energy_multiplier = .2
	pass # Replace with function body.

	var title_button = $VBoxContainer/Button
	title_button.text = "Title Screen"
	title_button.custom_minimum_size = Vector2(100, 25)
	
	var retry_button = $VBoxContainer/Button4
	retry_button.text = "Retry"
	retry_button.custom_minimum_size = Vector2(100, 25)
	
	var quit_button = $VBoxContainer/Button2
	quit_button.text = "Quit"
	quit_button.custom_minimum_size = Vector2(100, 25)
	
	var credits_button = $VBoxContainer/Button3
	credits_button.text = "Credits"
	credits_button.custom_minimum_size = Vector2(100, 25)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_3_pressed() -> void:
	pass


func _on_button_2_pressed() -> void:
	get_tree().quit()


func _on_button_4_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_scene.tscn")


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/title_screen.tscn")
	
	pass # Replace with function body.
