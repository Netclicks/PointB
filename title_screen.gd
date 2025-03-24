extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var title = $Title
	# Resizes node to match screen size
	var screensize = get_viewport().get_size()
	var background = $Background
	var start_button = $Start
	#background.custom_minimum_size = screensize


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_scene.tscn")



func _on_quit_pressed() -> void:
	get_tree().quit()
