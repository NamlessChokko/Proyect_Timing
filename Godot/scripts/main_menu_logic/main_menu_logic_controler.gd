extends Node
signal tutorial_combat_info(enemy_name: String)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Open: ", get_tree().current_scene.scene_file_path)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_play_button_button_up() -> void:
	print("Button \"play\" pressed...")
	emit_signal( "tutorial_combat_info", "dummy_boy" )
	var combat_tutorial: PackedScene = load("res://scenes/combat_tutorial/combat_tutorial.tscn")
	get_tree().change_scene_to_packed(combat_tutorial)


func _on_exit_button_button_up() -> void:
	print("Button \"exit\" pressed...")
	get_tree().quit(0)
