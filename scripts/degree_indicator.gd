extends Label

func _process(_delta: float) -> void:
	rotation = 0.0
	
	#Convertir el ángulo a un círculo limpio de 0 a 359 grados:
	var grados_limpios = posmod(int(-Global.angulo_volante), 360)

	text = "%d°" % [grados_limpios]
