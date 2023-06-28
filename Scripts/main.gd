extends Node2D

var score
var head

func new_game():
	score = 0
	$HUD.update_score("Score: " + str(score))
	$HUD.show_message("Get Ready")
	
	$snake._tween_loop()

func game_over():
	$HUD.show_game_over()
	get_tree().paused = true
	await get_tree().create_timer(3).timeout
	get_tree().paused = false
	
	$HUD.game_over_two()
	game_reset()
	
func game_reset():
	$snake.bodyparts.clear()
	$snake.tween_move.kill()
	$snake.prepering_snake()
	$spawner_food.spawn_food()

func score_counter():
	if $snake != null:
		score = $snake.bodyparts.size() - 1
	else:
		score = 0
	$HUD.update_score("Score: " + str(score))

func _process(delta):
	score_counter()
	if $snake.snake_colision():
		game_over()
	
	if $snake.bodyparts.size() != 0 and $snake != null :
		head = $snake.bodyparts[0].get_rect()
		if $snake.snake_out_of_border():
			game_over()
