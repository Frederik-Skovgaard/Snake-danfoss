class_name Snake extends Node2D

var head := BodyPart.new()
var bodyparts := [] as Array[BodyPart]

var curr_direction := Vector2.RIGHT
var next_direction := Vector2.RIGHT
var tween_move: Tween

var head_pos

@export var speed = 0.20
	
func _process(delta):	
	queue_redraw()
	print(head.get_rect())
	print(speed)
	
func _ready():
	prepering_snake()

func prepering_snake():
	head._set_curr_position(Vector2(0,32))
	next_direction = Vector2.RIGHT 
	
	head.size = Game.CELL_SIZE
	head.color = Colors.HEAD_COLOR 
	bodyparts.push_front(head)
	
	speed = 0.50

func _tween_loop():
	if tween_move != null:
		tween_move.kill()
	tween_move = create_tween().set_loops()
	tween_move.tween_callback(move).set_delay(speed)

func _draw():
	for bodyPart in bodyparts:
		draw_rect(bodyPart.get_rect(), bodyPart.color)


func _input(event):
	if event.is_action_pressed("move_left") and curr_direction != Vector2.RIGHT:
		next_direction = Vector2.LEFT
	if event.is_action_pressed("move_right") and curr_direction != Vector2.LEFT:
		next_direction = Vector2.RIGHT 
	if event.is_action_pressed("move_up") and curr_direction != Vector2.DOWN:
		next_direction = Vector2.UP 
	if event.is_action_pressed("move_down") and curr_direction != Vector2.UP:
		next_direction = Vector2.DOWN 


func move() -> void:
	curr_direction = next_direction
	var next_postition = head.curr_position + (curr_direction * Game.CELL_SIZE)
	head.curr_position = next_postition
	
	for i in range(1, bodyparts.size()):
		bodyparts[i].curr_position = bodyparts[i-1].prev_position
	
	
func grow() -> void:
	var bodypart := BodyPart.new()
	var last_bodypart := bodyparts.back() as BodyPart
	
	bodypart.curr_position = last_bodypart.curr_position
	bodypart.color = Colors.SNAKE_COLOR
	bodypart.size = Game.CELL_SIZE
		
	await get_tree().create_timer(speed + 0.1).timeout
	bodyparts.push_back(bodypart)
	
	speed -= 0.02
	_tween_loop()


func snake_colision():
	for BodyPart in bodyparts:
			if head.get_rect().intersection(BodyPart.get_rect()):
				if BodyPart.color != Colors.HEAD_COLOR:
					return true


func snake_out_of_border():
	var headColision = head.get_rect()
	if headColision.position.x < 0 or headColision.position.y < 32 or headColision.position.x > Game.GRID_SIZE.x or headColision.position.y >= Game.GRID_SIZE.y - 32:
		return true

func restart_snake():
	bodyparts.clear()
	prepering_snake()
