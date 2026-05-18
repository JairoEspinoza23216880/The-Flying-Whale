extends Label

func _process(_delta: float) -> void:
	var fuerza_actual = Global.potencia_palanca*Global.POTENCIA_MOTOR_MAX
	var fuerza_maxima = Global.POTENCIA_MOTOR_MAX 

	text = "Fuerza: %d N\nMaxFuerza: %d N" % [fuerza_actual, fuerza_maxima]
