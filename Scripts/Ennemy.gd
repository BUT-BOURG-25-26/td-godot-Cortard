class_name Ennemy extends RigidBody3D

@export var speed : float = 3
@export var max_speed: float = 5.0
@export var acceleration: float = 20.0

var player : Player

var damageTimer : Timer
var canDoInstantCollisionDamage : bool
var collisionDamageTimer : Timer

func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
	damageTimer = $DamageTimer
	canDoInstantCollisionDamage = true
	collisionDamageTimer = $CollisionDamageTimer
	return

func _physics_process(delta: float) -> void:
	if not player:
		return

	var to_player = player.global_position - global_position
	var direction = to_player.normalized()

	var desired_velocity = direction * max_speed
	var force = (desired_velocity - linear_velocity) * acceleration

	apply_central_force(force)

	var look_target = Vector3(player.global_position.x, global_position.y, player.global_position.z)
	look_at(look_target, Vector3.UP)

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		if canDoInstantCollisionDamage :
			canDoInstantCollisionDamage = false
			collisionDamageTimer.start()
			_on_damage_timer_timeout()
		damageTimer.start()

func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.is_in_group("Player"):
		damageTimer.stop()

func _on_damage_timer_timeout() -> void:
	player.heal(-1)

func _on_collision_damage_timer_timeout() -> void:
	canDoInstantCollisionDamage = true
	
func kill():
	queue_free()
	if player :
		player.addKillCount(1)
