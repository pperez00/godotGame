extends Area2D

export (int) var velocidad
var movimiento = Vector2()
var limite
signal golpe

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	limite = get_viewport_rect().size #obtengo el tamaño de la pantalla

func _process(delta):
	movimiento = Vector2() #reiniciar en cada frame
	
	if Input.is_action_pressed("ui_right"):
		movimiento.x += 1
	if Input.is_action_pressed("ui_left"):
		movimiento.x -= 1
	if Input.is_action_pressed("ui_up"):
		movimiento.y -= 1
	if Input.is_action_pressed("ui_down"):
		movimiento.y += 1
	
	if movimiento.length() > 0:
		movimiento = movimiento.normalized() * velocidad #normalizar la velocidad segun fps
		$SpritePlayer.play()
	else:
		$SpritePlayer.stop()
	
	position += movimiento * delta #actualizar los movimientos
	#limitamos el movimiento con la funcion clamp
	#clamp(posicion, min, max) 
	position.x = clamp(position.x, 0, limite.x)
	position.y = clamp(position.y, 0, limite.y)
	
	
	
	# Animaciones
	if movimiento.x != 0:
		$SpritePlayer.animation = "caminando"
		$SpritePlayer.flip_h = movimiento.x < 0
	elif movimiento.y < 0:
		$SpritePlayer.animation = "espalda"
	else:
		$SpritePlayer.animation = "frente"
	
	#lo que pasa cuando hay una colision
func _on_Player_body_entered(_body):
	hide()
	emit_signal("golpe")
	#$CollisionShape2D.disabled = true
	$CollisionShape2D.set_deferred("disabled", true)
	
func inicio(pos):
	position = pos
	
	
	show()
	$CollisionShape2D.disabled = false
	
