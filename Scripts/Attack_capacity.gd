extends Node3D

var vfx_impact: PackedScene

func _ready() -> void :
	vfx_impact = preload("res://Scenes/vfx_impact.tscn")

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var camera = get_viewport().get_camera_3d()
		if camera:
			var mouse_pos = event.position
			var from = camera.project_ray_origin(mouse_pos)
			var to = from + camera.project_ray_normal(mouse_pos) * 1000.0
			
			var ray_query = PhysicsRayQueryParameters3D.create(from, to)
			ray_query.exclude = [self]
			
			var space_state = get_viewport().get_world_3d().direct_space_state
			var result = space_state.intersect_ray(ray_query)
			
			if result:
				var collision_point = result.position
				var vfx_instance = vfx_impact.instantiate()
				get_tree().current_scene.add_child(vfx_instance)
				vfx_instance.global_transform.origin = collision_point
