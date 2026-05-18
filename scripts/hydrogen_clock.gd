extends TextureProgressBar

var max_volumen = Global.VOLUMEN_MAX_GAS
var min_volumen = Global.VOLUMEN_MIN_COMPRESION

func _process(_delta: float) -> void:
	var total_volumen = max_volumen - min_volumen
	var porcentaje = ((Global.volumen_gas_m3-min_volumen) / total_volumen) * 100
	
	value = porcentaje
