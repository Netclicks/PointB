extends CanvasLayer
#@onready var player_move = get_node("/root/MainScene/Player/car_police")
func _ready() -> void:

	visible = false
	
	var vbox = $VBoxContainer
	vbox.size_flags_horizontal = Control.SIZE_FILL
	vbox.size_flags_vertical = Control.SIZE_FILL
	vbox.alignment = BoxContainer.ALIGNMENT_CENTER

	var label = $VBoxContainer/Label
	label.text = "You Died!"
	label.add_theme_font_size_override("font_size", 16)

	var button = $VBoxContainer/RetryButton
	button.text = "Retry"
	button.custom_minimum_size = Vector2(100, 25)
	
	var quit = $VBoxContainer/QuitButton
	quit.text = "Quit"
	quit.custom_minimum_size = Vector2(100, 25)

	#quit.connect("pressed", Callable(self, "_on_quit_button_pressed"))
	button.connect("pressed", Callable(self, "_on_retry_button_pressed"))
	
	vbox.position = Vector2(175, 100)

func _on_retry_button_pressed():
	get_tree().reload_current_scene()
	
func show_death_screen():
	visible = true


func _on_quit_button_pressed() -> void:
	get_tree().quit()
