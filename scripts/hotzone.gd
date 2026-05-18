extends Node2D

@export var area: Area2D

# Densidad del aire caliente (ej. a 50°C)
const RHO_AIRE_CALIENTE: float = 1.092 

func _ready() -> void:
	area.body_entered.connect(_on_body_entered)
	area.body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node2D) -> void:
	# Verificamos que lo que entró sea el dirigible
	if body is CharacterBody2D:
		Global.rho_aire_local = RHO_AIRE_CALIENTE

func _on_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		# Regresamos el mundo a la densidad normal
		Global.rho_aire_local = Global.RHO_AIRE_ESTANDAR
