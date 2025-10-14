class_name Player extends CharacterBody3D
var healthbar
var label
var gameOver

@export var move_speed:float = 500
@export var jumpSpeed:float = 5
@export var health: int = 3

var killCounter: int = 0

var move_inputs: Vector2

func _ready() -> void:
	healthbar = $SubViewport/HealthBar
	label = $"../UI/nbKills"
	gameOver = "res://Scenes/GameOver.tscn"
	healthbar.max_value = health

func _process(delta:float) -> void:
	if Input.is_action_just_pressed("damage_player"):
		heal(-1)

func _physics_process(delta: float) -> void:
	read_move_inputs()
	move_inputs *= move_speed * delta
	if move_inputs != Vector2.ZERO:
		velocity.x = move_inputs.x
		velocity.z = move_inputs.y
	else :
		velocity.x = 0
		velocity.z = 0
		
	if Input.is_action_just_pressed("jump") && is_on_floor():
		velocity.y += jumpSpeed
	velocity.y += get_gravity().y * delta
	
	move_and_slide()
	
	if global_position.y < -2 :
		_on_death()

func read_move_inputs():
	move_inputs.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	move_inputs.y = Input.get_action_strength("move_backward") - Input.get_action_strength("move_forward")
	move_inputs = move_inputs.normalized()
	return

func heal(value: int) :
	health += value
	if health <= 0 :
		_on_death()
		return
	healthbar.update(health)
	return

func addKillCount(nb: int) :
	killCounter += nb
	if label :
		label.text = "Kills : %d" % killCounter

func _on_death() -> void:
	queue_free()
	get_tree().change_scene_to_file(gameOver)
