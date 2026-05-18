extends Label

func _process(_delta: float) -> void:
	var vector = Global.viento_vector
	
	var f_viento_x: float = vector.x
	var f_viento_y: float = vector.y
	var angulo_radianes: float = vector.angle()
	
	var fuerza_viento: float = 0.0
	if abs(cos(angulo_radianes)) > 0.001:
		fuerza_viento = f_viento_x / cos(angulo_radianes)
	else:
		fuerza_viento = f_viento_y / sin(angulo_radianes)
		
	fuerza_viento = abs(fuerza_viento)
	
	var angulo_grados = rad_to_deg(vector.angle())
	var angulo_limpio = posmod(int(angulo_grados), 360)
	
	if fuerza_viento < 0.1:
		angulo_limpio = 0
		
	var vel_x = Global.v_vector.x
	var vel_y = -Global.v_vector.y
	
	text = "Densidad Aire: %.3f kg/m³\nFuerza Viento: %d N\nÁngulo Viento: %d°\nVelocidad X: %.1f m/s\nVelocidad Y: %.1f m/s" % [
		Global.rho_aire_local,
		fuerza_viento,
		angulo_limpio,
		vel_x,
		vel_y
	]
