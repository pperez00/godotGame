extends Node

export (PackedScene) var Tarea
var score

func _ready():
	randomize()
	
func nuevo_juego():
	score = 0
	$Player.inicio($PosicionInicio.position)
	$InicioTimer.start()
	$Interfaz.mostrar_mensaje("Ponganse a estudiar!")
	$Interfaz.update_score(score)
	$Musica.play()

func game_over():
	$ScoreTimer.stop()
	$TareaTimer.stop()
	$Interfaz.game_over()
	$SonidoLose.play()
	$Musica.stop()


func _on_InicioTimer_timeout():
	$TareaTimer.start()
	$ScoreTimer.start()


func _on_ScoreTimer_timeout():
	score += 1
	$Interfaz.update_score(score)


func _on_TareaTimer_timeout():
	# seleccionar un lugar aleatorio para que aparezcan los enemigos
	$Camino/EntradaTarea.set_offset(randi())
	var tp = Tarea.instance()
	add_child(tp) #se agrega como hijo de la escena mundo solo después de crearse
	var direccion = $Camino/EntradaTarea.rotation + PI / 2
	tp.position = $Camino/EntradaTarea.position
	#pi sobre 4 son 45 grados (godot usa radianes en lugar de grados)
	direccion += rand_range(-PI / 4, PI / 4)
	tp.rotation = direccion
	tp.set_linear_velocity(Vector2(rand_range(tp.velocidad_min, tp.velocidad_max), 0).rotated(direccion))
	
	
