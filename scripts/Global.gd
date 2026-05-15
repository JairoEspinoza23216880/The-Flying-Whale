extends Node

# --- CONSTANTES FÍSICAS---
const GRAVEDAD = 9.81 [cite: 38]
const RHO_AIRE_ESTANDAR = 1.225 [cite: 38]
const MASA_TOTAL_VUELO = 204260.0 # 129260 + 75000 kg [cite: 47]
const VOLUMEN_MAX_GAS = 180000.0 [cite: 48]
const VOLUMEN_MIN_COMPRESION = 90000.0 [cite: 67]
const TASA_COMPRESOR_M3_S = 1500.0 [cite: 61]
const POTENCIA_MOTOR_MAX = 25000.0 [cite: 59]
const COEFICIENTE_DRAG = 0.02 [cite: 64]
const AREA_FRONTAL = 1963.5 [cite: 50]

# --- INPUTS ---
var dt: float = 0.016 [cite: 12]
var potencia_palanca: float = 0.0 # 0.0 a 1.0 [cite: 13, 22]
var angulo_volante: float = 180.0 # 0 a 360 grados [cite: 14, 23]
var flujo_compresor: float = 0.0 # -1, 0, 1 [cite: 15, 24]
var viento_vector: Vector2 = Vector2(10, -5) [cite: 16, 25]
var rho_aire_local: float = 1.225 [cite: 17, 26]

# --- OUTPUTS ---
var posicion_xy: Vector2 = Vector2(1200, 450) [cite: 29]
var v_vector: Vector2 = Vector2(0, 0) [cite: 29]
var volumen_gas_m3: float = 175000.0 [cite: 29]
var fuerza_neta_n: float = 0.0 [cite: 30]
var colision_check: bool = false [cite: 31]
