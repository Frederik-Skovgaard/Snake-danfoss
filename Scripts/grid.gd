extends Node2D

func _draw() -> void:
	for i in Game.CELLS_AMOUNT.x:
			for j in Game.GRID_SIZE.x / Game.CELL_SIZE.x:
				draw_rect(Rect2(i * 64, j * 64 , Game.CELL_SIZE.x, Game.CELL_SIZE.y), Colors.BACKGROUD_COLOR)

	for i in Game.CELLS_AMOUNT.y:
		for j in Game.GRID_SIZE.y / Game.CELL_SIZE.y:
			if i >0:
				draw_rect(Rect2(i * 64 -32, j * 64 -32 , Game.CELL_SIZE.x, Game.CELL_SIZE.y), Colors.BACKGROUD_COLOR)
