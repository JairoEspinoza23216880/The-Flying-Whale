extends VSlider

func _ready() -> void:
	self.value_changed.connect(_on_value_changed)
	value = 0.0

func _process(_delta: float) -> void:
	pass

func _on_value_changed(new_value: float) -> void:
	Global.flujo_compresor = new_value / 100.0
