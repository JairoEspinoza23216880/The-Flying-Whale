extends VSlider

func _ready() -> void:
	self.value_changed.connect(_on_value_changed)
	Global.potencia_palanca = value/100

func _on_value_changed(new_value: float) -> void:
	Global.potencia_palanca = new_value/100
