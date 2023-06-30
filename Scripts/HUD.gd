extends CanvasLayer

signal start_game

var has_game_started = false

func _process(delta):
	if !has_game_started and Input.is_action_just_pressed("start_game"):
		$StartButton.hide()
		start_game.emit()
		has_game_started = true
	elif !has_game_started and Input.is_action_just_pressed("move_right"):
		get_tree().quit()

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

func show_game_over():
	$CloseBackground.show()
	show_message("Game over")
	
func game_over_two():
	$Message.hide()
	$CloseBackground.hide()
	$StartButton.show() 
	has_game_started = false

func update_score(score):
	$ScoreLabel.text = str(score)


func _on_message_timer_timeout():
	$Message.hide()

func _ready():
	$CloseBackground.hide()
