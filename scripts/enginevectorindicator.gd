extends Sprite2D

func _process(delta: float) -> void:
	var rad_objetive_angle = deg_to_rad(Global.angulo_volante)
	
	var smooth = 5.0
	rotation = lerp_angle(rotation, rad_objetive_angle, smooth*delta)
