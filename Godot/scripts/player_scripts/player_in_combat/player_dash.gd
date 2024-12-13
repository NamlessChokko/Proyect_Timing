extends Node

signal dash_direction_sign(direction: String)
signal dash_state_sign(state: String)

var dash_direction_container: Array = ["up", "down", "back", "diag_up", "diag_down", "none"]
var dash_state_container: Array = ["start", "hold", "back", "reset", "none"]
var states_times_container: Array = [0.1, 0.5, 0.2, 0.3]
var times_multiplier_container: Array = [1, 1, 1, 1]

var current_state: String = "none"
var new_state: String = "none"
var i: int = -1 
var can_dash: bool = true

func _ready() -> void:
	print("player_dash initialized")  # debug line

func _process(delta: float) -> void:
	if can_dash: 
		dash_state_detect()

func dash_direction_detect() -> String:
	for direction in dash_direction_container:
		if Input.is_action_pressed(direction):
			emit_signal("dash_direction_sign", direction)
			print("Dash direction: ", direction)
			return direction
	return "none"

func dash_state_detect() -> void:
	if current_state == "none":
		if dash_direction_detect() != "none":
			new_state = "start"
			i = -1  
			start_state_handling()
	else:
		start_state_handling()

func start_state_handling() -> void:
	can_dash = false  
	i += 1
	if i < dash_state_container.size():
		new_state = dash_state_container[i]
		emit_signal("dash_state_sign", new_state)
		print("Dash state: ", new_state)
		if new_state != "none":
			await pause_for_seconds(states_times_container[i] * times_multiplier_container[i])
		current_state = new_state
	else:
		new_state = "none"
		current_state = "none"
	can_dash = true  # Desbloquea la detección de estado después de terminar

func pause_for_seconds(duration: float) -> void:
	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = duration
	timer.one_shot = true
	timer.start()
	await timer.timeout
	timer.queue_free()
