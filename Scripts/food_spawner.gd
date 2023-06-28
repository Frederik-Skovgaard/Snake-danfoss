extends Node2D

var food := Food.new()

@onready var snake := %snake as Snake

func _ready():
	spawn_food()


func _process(delta):
	queue_redraw()
	if snake != null:
		if food.get_rect().intersects(snake.bodyparts[0].get_rect()):
			snake.grow()
			spawn_food()
	else:
		spawn_food()

func _draw():
	draw_rect(food.get_rect(), food.color)
	
func spawn_food() -> void:
	var is_on_occupied_position = true
	
	while is_on_occupied_position:
		var random_position = Vector2()
		random_position.x = randi_range(0, Game.GRID_SIZE.x - Game.CELL_SIZE.x)
		random_position.y = randi_range(0, Game.GRID_SIZE.y - Game.CELL_SIZE.y)
		
		for BodyPart in snake.bodyparts:
			while random_position.x == BodyPart.get_rect().position.x and random_position.y == BodyPart.get_rect().position.y:
				random_position.x = randi_range(0, Game.GRID_SIZE.x - Game.CELL_SIZE.x)
				random_position.y = randi_range(0, Game.GRID_SIZE.y - Game.CELL_SIZE.y)
			
		while random_position.y < 32 or random_position.y > 416:
			random_position.x = randi_range(0, Game.GRID_SIZE.x - Game.CELL_SIZE.x)
			random_position.y = randi_range(0, Game.GRID_SIZE.y - Game.CELL_SIZE.y)
		
		food.position = random_position.snapped(Game.CELL_SIZE)
		
		if snake != null:
			if food.get_rect().intersects(snake.bodyparts[0].get_rect()):
					is_on_occupied_position = true
					break
			else :
				is_on_occupied_position = false
				
