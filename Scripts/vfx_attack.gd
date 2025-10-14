class_name VFX extends Area3D 

@onready var flash = $Flash
@onready var sparks = $Sparks
@onready var shockwave = $Shockwave
@onready var flare = $Flare

func emit():
	flash.emitting = true
	flare.emitting = true
	shockwave.emitting = true
	sparks.emitting = true

func _on_shockwave_finished() -> void:
	queue_free()

func _on_body_entered(body: Node3D) -> void:
	if body is Ennemy:
		var ennemy: Ennemy = body
		ennemy.kill()
		queue_free()
