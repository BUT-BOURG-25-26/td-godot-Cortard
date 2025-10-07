class_name Player extends Node3D
var healthbar
@export var move_speed:float = 5
@export var health: int = 3

var move_inputs: Vector2

func _ready() -> void:
	healthbar = $SubViewport/HealthBar
	healthbar.max_value = health

func _process(delta:float) -> void:
	if Input.is_action_just_pressed("damage_player"):
		health -= 1
		healthbar.update(health)

func _physics_process(delta: float) -> void:
	read_move_inputs()
	move_inputs *= move_speed * delta
	if move_inputs != Vector2.ZERO:
		position += Vector3(move_inputs.x, 0.0, move_inputs.y)
	return

func read_move_inputs():
	move_inputs.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	move_inputs.y = Input.get_action_strength("move_backward") - Input.get_action_strength("move_forward")
	move_inputs = move_inputs.normalized()
	return
