class_name Food

var position := Vector2()
var size := Game.CELL_SIZE
var color := Colors.APPLE_COLOR

func get_rect() -> Rect2:
	return Rect2(position, size)
