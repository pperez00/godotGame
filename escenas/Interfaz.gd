extends CanvasLayer

signal iniciar_juego

func mostrar_mensaje(texto):
	$Mensaje.text = texto
	$Mensaje.show()
	$MensajeTimer.start()
	
func game_over():
	mostrar_mensaje("Desaprobaste")
	yield($MensajeTimer, "timeout")
	$Button.show()
	$Mensaje.text = "¡Basta de TPsss!"
	$Mensaje.show()
	
func update_score(puntos):
	$ScoreLabel.text = str(puntos)


func _on_MensajeTimer_timeout():
	$Mensaje.hide()


func _on_Button_pressed():
	$Button.hide()
	emit_signal("iniciar_juego")
	
