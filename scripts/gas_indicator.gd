extends Label

func _process(_delta: float) -> void:
	var gas_actual = Global.volumen_gas_m3
	var gas_maximo = Global.VOLUMEN_MAX_GAS
	var porcentaje = (gas_actual / gas_maximo) * 100.0
	
	var sustentacion = Global.sustentacion
	var peso = Global.fuerza_peso
	
	var estado: String = ""
	
	if abs(sustentacion - peso) < 500.0:
		estado = "NEUTRA"
	elif sustentacion > peso:
		estado = "POSITIVA"
	else:
		estado = "NEGATIVA"
	
	var relacion_sp = sustentacion / peso if peso != 0 else 0.0
	
	text = "Gas: %d m³ (%s)\nInflado: %.1f%%\nRelación S/P: %.3f" % [
		gas_actual,
		estado,
		porcentaje,
		relacion_sp
	]
