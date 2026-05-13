# Contrato de Interfaz LCA70T-H1
extends Node

# INPUTS (Escritos por UI)
var potencia_motor: float = 0.0     # 0.0 a 1.0
var angulo_volante: float = 0.0     # 0 a 360 grados
var flujo_compresor: float = 0.0    # -1, 0, 1

# OUTPUTS (Escritos por Físicas)
var posicion: Vector2
var velocidad: Vector2
var volumen_gas: float = 180000.0
var colisionado: bool = false
