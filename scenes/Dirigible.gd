extends CharacterBody2D

@export var engine1: Sprite2D
@export var engine2: Sprite2D

func _ready() -> void:
	Global.angulo_volante = 0.0 
	
	# 2. Posicionamos los motores instantáneamente sin pasar por el lerp
	var angulo_inicial = deg_to_rad(Global.angulo_volante)
	engine1.rotation = angulo_inicial
	engine2.rotation = angulo_inicial
	
	velocity = Vector2.ZERO


func _process(delta: float) -> void:
	var rad_objetive_angle = deg_to_rad(Global.angulo_volante)
	
	var smooth = 5.0
	engine1.rotation = lerp_angle(engine1.rotation, rad_objetive_angle, smooth*delta)
	engine2.rotation = lerp_angle(engine2.rotation, rad_objetive_angle, smooth*delta)
	pass

func _physics_process(delta):
	# Simulación de Compresor (Volumen actual de gas)
	Global.volumen_gas_m3 += Global.flujo_compresor * Global.TASA_COMPRESOR_M3_S * delta
	Global.volumen_gas_m3 = clamp(Global.volumen_gas_m3, Global.VOLUMEN_MIN_COMPRESION, Global.VOLUMEN_MAX_GAS)

	# Cálculo de Fuerzas (Vectores)
	# Empuje vectorial 360° [cite: 6]
	var rad = deg_to_rad(Global.angulo_volante)
	var fuerza_empuje = Vector2(cos(rad), sin(rad)) * (Global.potencia_palanca * Global.POTENCIA_MOTOR_MAX)
	
	# Sustentación Dinámica (Arquímedes: E = rho * V * g)
	var rho_neta = Global.rho_aire_local - Global.RHO_GAS_HIDROGENO
	var fuerza_sustentacion = Vector2(0, -(rho_neta * Global.volumen_gas_m3 * Global.GRAVEDAD))
	Global.sustentacion = -fuerza_sustentacion[1]
	
	# Peso (P = m * g)
	var fuerza_peso = Vector2(0, Global.MASA_TOTAL_VUELO * Global.GRAVEDAD)
	Global.fuerza_peso = fuerza_peso[1]
	
# Resistencia al aire (Drag)
	var fuerza_drag = Vector2.ZERO
	
	# 1. Drag Horizontal (Avanzar/Retroceder) - Perfil Aerodinámico
	if abs(velocity.x) > 0.1:
		# Usamos el área de la punta (pequeña) y un coeficiente bajo
		var drag_x_mag = 0.5 * Global.rho_aire_local * (velocity.x * velocity.x) * Global.AREA_FRONTAL * Global.COEFICIENTE_DRAG_FRONTAL
		fuerza_drag.x = -sign(velocity.x) * drag_x_mag

	# 2. Drag Vertical (Subir/Bajar) - Perfil de la Panza/Lomo
	if abs(velocity.y) > 0.1:
		# Usamos el área lateral/panza (enorme) y un coeficiente más alto
		var drag_y_mag = 0.5 * Global.rho_aire_local * (velocity.y * velocity.y) * Global.AREA_PANZA * Global.COEFICIENTE_DRAG_VERTICAL
		fuerza_drag.y = -sign(velocity.y) * drag_y_mag
	
	# Fuerza Neta y Aceleración (a = F / m)
	var fuerza_neta = fuerza_empuje + fuerza_sustentacion + fuerza_peso + fuerza_drag + Global.viento_vector
	var aceleracion = fuerza_neta / Global.MASA_TOTAL_VUELO
	
	# Actualización de Velocidad
	velocity += aceleracion * delta
	
	# move_and_collide devuelve datos si choca con algo
	var colision = move_and_collide(velocity * delta)
	
	# Si chocamos con algo, ajustamos la velocidad matemática
	if colision:
		velocity = velocity.slide(colision.get_normal())
	
	# Actualizar Contrato de Interfaz en Global
	Global.posicion_xy = global_position
	Global.v_vector = velocity
	Global.fuerza_neta_n = fuerza_neta.length()
	Global.colision_check = colision != null
