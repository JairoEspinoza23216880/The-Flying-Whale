extends Node2D

@export var fuerza_total_wind: float = 250000.0
@export var area: Area2D

# Coeficientes de impacto del viento según la cara del dirigible
const EFICIENCIA_VIENTO_FRONTAL: float = 0.2
const EFICIENCIA_VIENTO_LATERAL: float = 1.0

func _ready() -> void:
	area.body_entered.connect(_on_body_entered)
	area.body_exited.connect(_on_body_exited)

func _process(_delta: float) -> void:
	if area.has_overlapping_bodies():
		for body in area.get_overlapping_bodies():
			if body is CharacterBody2D:
				actualizar_viento_dirigible()

func actualizar_viento_dirigible() -> void:
	var angulo_radianes = global_rotation
	
	# Descomponemos la fuerza total en sus componentes X e Y usando trigonometría
	var viento_puro_x = cos(angulo_radianes) * fuerza_total_wind
	var viento_puro_y = sin(angulo_radianes) * fuerza_total_wind
	
	# Aplicamos los coeficientes aerodinámicos del dirigible por componentes
	var fuerza_final_x = viento_puro_x * EFICIENCIA_VIENTO_FRONTAL
	var fuerza_final_y = viento_puro_y * EFICIENCIA_VIENTO_LATERAL
	
	# Enviamos el Vector2 resultante al Global
	Global.viento_vector = Vector2(fuerza_final_x, fuerza_final_y)

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		actualizar_viento_dirigible()

func _on_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		# Al salir de la zona, el viento vuelve a ser cero
		Global.viento_vector = Vector2.ZERO
