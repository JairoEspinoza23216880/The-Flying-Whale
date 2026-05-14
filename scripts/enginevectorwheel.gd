extends Sprite2D

@export var handle: Area2D

var handled_handle: bool = false
var mouse_on: bool = false
var last_mouse_angle: float = 0.0
var wheel_engine_ratio: float = 50.0 #Vueltas de rueda x vuelta de motor

func _ready() -> void:
	handle.mouse_entered.connect(_on_mouse_entered)
	handle.mouse_exited.connect(_on_mouse_exited)
	

func _on_mouse_entered():
	mouse_on = true
	
func _on_mouse_exited():
	mouse_on = false

func _input(event):
	
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed and mouse_on:
				handled_handle = true
				# Guardamos la diferencia entre el ángulo del mouse y la rotación actual del volante
				last_mouse_angle = (get_global_mouse_position() - global_position).angle()
			elif not event.pressed:
				handled_handle = false
				
	if event is InputEventMouseMotion and handled_handle:
		var center = global_position
		var mouse_pos = get_global_mouse_position()
		var current_mouse_angle = (mouse_pos - center).angle()
		
		# Esta es la magia: calculamos la diferencia corta entre el ángulo anterior y el nuevo
		# 'angle_difference' limpia automáticamente los saltos de 180/-180
		var change = angle_difference(last_mouse_angle, current_mouse_angle)
		
		# Aplicamos el cambio a la rotación actual
		rotation += change # Usamos -= o += dependiendo de la orientación de tu sprite
		
		# Guardamos el ángulo actual para el siguiente frame
		last_mouse_angle = current_mouse_angle
		
		# Actualizamos el Global
		Global.angulo_volante = rad_to_deg(rotation) / wheel_engine_ratio
