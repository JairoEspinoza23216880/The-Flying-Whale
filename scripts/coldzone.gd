extends Node2D

@export var area: Area2D

# Densidad de aire frío (-15°C)
const RHO_AIRE_FRIO: float = 1.341

func _ready() -> void:
	area.body_entered.connect(_on_body_entered)
	area.body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		Global.rho_aire_local = RHO_AIRE_FRIO

func _on_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		Global.rho_aire_local = Global.RHO_AIRE_ESTANDAR
