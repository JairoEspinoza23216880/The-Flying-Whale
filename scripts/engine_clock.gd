extends TextureProgressBar


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Supongamos que Global.potencia va de 0.0 a 1.0 (el slider)
	# y que el empuje máximo son 500,000 N
	var empuje_actual = Global.potencia_motor * 500000
	
	# El semitoro visual (0 a 100%)
	value = Global.potencia_motor * 100
