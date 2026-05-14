extends TextureProgressBar


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Calculamos el porcentaje basado en el volumen máximo
	var max_volumen = 180000.0
	var porcentaje = (Global.volumen_gas / max_volumen) * 100
	
	value = porcentaje
