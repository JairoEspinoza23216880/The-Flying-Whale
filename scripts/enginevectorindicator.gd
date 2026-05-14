extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var rad_objetive_angle = deg_to_rad(Global.angulo_volante)
	
	var smooth = 5.0
	rotation = lerp_angle(rotation, rad_objetive_angle, smooth*delta)
