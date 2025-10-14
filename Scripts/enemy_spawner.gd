extends Node

var enemy: PackedScene

func _ready() -> void:
	enemy = preload("res://Scenes/Ennemy.tscn")
	
func _on_timer_timeout() -> void:
	var new_enemy = enemy.instantiate()
	get_tree().current_scene.add_child(new_enemy)
	
	var x = randf_range(-10, 10)
	var y = randf_range(-10, 10)
	var z = 0.51
	
	new_enemy.global_transform.origin = Vector3(x, z, y)
