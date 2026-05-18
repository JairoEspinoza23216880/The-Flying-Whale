extends Camera2D

var altura_fija: float

# Registro de la altura a mantener
func _ready() -> void:
	altura_fija = global_position.y

# Corrección para que la altura no cambie
func _process(_delta: float) -> void:
	global_position.y = altura_fija
