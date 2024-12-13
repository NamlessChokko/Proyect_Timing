extends Timer

signal new_dash_phase(phase: String)

var dash_phases_container: Array = ["start", "hold", "back", "reset", "none"]
var dash_phases_time: Array = [0.5, 1, 0.5, 0.3]

var start_looping: bool = false
var current_phase_index: int = 0


func _ready() -> void:
	print("dash_phases_times initialized") # Debug line


func phase_loop() -> void:
	if start_looping:
		wait_time = dash_phases_time[current_phase_index]
		start()
	else:
		stop()
		current_phase_index = dash_phases_container.size() - 1 
		emit_signal("new_dash_phase", dash_phases_container[current_phase_index])


func _on_player_dash_dash_loop_sign(looping: bool) -> void:
	start_looping = looping
	if looping:
		current_phase_index = 0  
		phase_loop()
	else:
		phase_loop()  


func _on_timeout_phase_loop() -> void:
	if start_looping:
		emit_signal("new_dash_phase",dash_phases_container[current_phase_index])
		current_phase_index += 1
		if current_phase_index >= dash_phases_container.size() - 1:
			current_phase_index = 0
		wait_time = dash_phases_time[current_phase_index]
		start()
