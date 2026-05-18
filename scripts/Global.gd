extends Node

# --- CONSTANTES FÍSICAS---
const GRAVEDAD = 9.81
const RHO_AIRE_ESTANDAR = 1.225
const RHO_GAS_HIDROGENO = 0.09
const MASA_DIRIGIBLE = 129260
const CARGA_DIRIGIBLE = 40000 #MAX = 75000 kg
const MASA_TOTAL_VUELO = MASA_DIRIGIBLE + CARGA_DIRIGIBLE
const VOLUMEN_MAX_GAS = 180000.0
const VOLUMEN_MIN_COMPRESION = 90000.0
const TASA_COMPRESOR_M3_S = 4500.0
const POTENCIA_MOTOR_MAX = 500000.0
const COEFICIENTE_DRAG_FRONTAL = 0.06
const COEFICIENTE_DRAG_VERTICAL = 0.6
const AREA_FRONTAL = 1963.5
const AREA_PANZA = 7900

# --- INPUTS ---
var dt: float = 0.016
var potencia_palanca: float = 0.0 # 0.0 a 1.0
var angulo_volante: float = 180.0 # 0 a 360 grados
var flujo_compresor: float = 0.0 # -1, 0, 1
var viento_vector: Vector2 = Vector2(0, 0)
var rho_aire_local: float = 1.225

# --- OUTPUTS ---
var posicion_xy: Vector2 = Vector2(1200, 450)
var v_vector: Vector2 = Vector2(0, 0)
var fuerza_neta_n: float = 0.0
var colision_check: bool = false
var sustentacion: float = 0
var fuerza_peso: float = 0
var volumen_gas_m3: float = 180000

func _ready() -> void:
	# Esperar a que todos los _ready() se carguen
	await get_tree().process_frame
	
	var rho_neta: float = rho_aire_local - RHO_GAS_HIDROGENO
	
	# Evitamos una división entre cero por si acaso
	if rho_neta * GRAVEDAD != 0:
		volumen_gas_m3 = fuerza_peso / (rho_neta * GRAVEDAD)

func _unhandled_input(event: InputEvent) -> void:
	# Salir con ESC
	if event.is_action_pressed("ui_cancel") or (event is InputEventKey and event.pressed and event.keycode == KEY_ESCAPE):
		get_tree().quit()
