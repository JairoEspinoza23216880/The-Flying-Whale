extends CharacterBody2D

func _physics_process(delta):
	# 1. Simulación de Compresor (Volumen actual de gas)
	Global.volumen_gas_m3 += Global.flujo_compresor * Global.TASA_COMPRESOR_M3_S * delta
	Global.volumen_gas_m3 = clamp(Global.volumen_gas_m3, Global.VOLUMEN_MIN_COMPRESION, Global.VOLUMEN_MAX_GAS) [cite: 3, 67]

	# 2. Cálculo de Fuerzas (Vectores)
	# Empuje vectorial 360° [cite: 6]
	var rad = deg_to_rad(Global.angulo_volante)
	var fuerza_empuje = Vector2(cos(rad), sin(rad)) * (Global.potencia_palanca * Global.POTENCIA_MOTOR_MAX)
	
	# Sustentación Dinámica (Arquímedes: E = rho * V * g) [cite: 5]
	var fuerza_sustentacion = Vector2(0, -(Global.rho_aire_local * Global.volumen_gas_m3 * Global.GRAVEDAD))
	
	# Peso (P = m * g) [cite: 38, 47]
	var fuerza_peso = Vector2(0, Global.MASA_TOTAL_VUELO * Global.GRAVEDAD)
	
	# Resistencia al aire (Drag) [cite: 7, 64]
	var fuerza_drag = Vector2.ZERO
	if velocity.length() > 0.1:
		var f_drag_mag = 0.5 * Global.rho_aire_local * velocity.length_squared() * Global.AREA_FRONTAL * Global.COEFICIENTE_DRAG
		fuerza_drag = -velocity.normalized() * f_drag_mag
	
	# 3. Fuerza Neta y Aceleración (a = F / m) [cite: 2, 30]
	var fuerza_neta = fuerza_empuje + fuerza_sustentacion + fuerza_peso + fuerza_drag + Global.viento_vector
	var aceleracion = fuerza_neta / Global.MASA_TOTAL_VUELO
	
	# 4. Actualización de Velocidad (Integración de Euler) [cite: 8]
	velocity += aceleracion * delta
	
	# 5. Movimiento y Detección de Colisión [cite: 31]
	# move_and_collide devuelve datos si choca con algo
	var colision = move_and_collide(velocity * delta)
	
	# 6. Actualizar Contrato de Interfaz en Global
	Global.posicion_xy = global_position
	Global.v_vector = velocity
	Global.fuerza_neta_n = fuerza_neta.length()
	Global.colision_check = colision != null
