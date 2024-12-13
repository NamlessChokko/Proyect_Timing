extends Node

var combat_data: Dictionary = load("res://data/combat_data/dummy_boy_data.JSON").as_dict()


func _ready() -> void:
	var combat_info_emisor = get_node("res://scenes/main_menu/main_menu.tscn")
	combat_info_emisor.connect("tutorial_combat_info", self, "_on_tutorial_combat_info")
	
	# Definir la variable que contiene el nombre del archivo
	var combat_info_emisor_data = "dummy_boy_data"  # Ejemplo de cómo se define
	var combat_data = load("res://data/combat_data/" + combat_info_emisor_data + ".JSON").as_dict()

	# Usar combat_data
	print(combat_data)
