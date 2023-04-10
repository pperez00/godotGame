extends RigidBody2D

export (float) var velocidad_min
export (float) var velocidad_max


func _on_VisibilidadTarea_screen_exited():
	queue_free()
