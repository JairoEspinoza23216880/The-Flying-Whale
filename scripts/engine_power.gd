extends VSlider


func _ready() -> void:
	# Inicializamos el Global con el valor que tenga el slider al arrancar
	self.value_changed.connect(_on_value_changed)
	Global.potencia_motor = value/100

func _on_value_changed(new_value: float) -> void:
	# Actualizamos el contrato global
	Global.potencia_motor = new_value/100
