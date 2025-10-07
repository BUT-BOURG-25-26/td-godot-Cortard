extends Node3D

var player : Player
var speed : float = 3

func _ready() -> void:
	player = $"../Player"
	print(player)
	return

func _physics_process(delta: float) -> void:
	var playerFollowMove = player.position - position
	playerFollowMove = playerFollowMove.normalized() * speed * delta
	position += playerFollowMove
