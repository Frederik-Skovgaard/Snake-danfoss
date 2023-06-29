# Classic Arcade Snake
It's snake
Start small eat fruit get bigger eat more fruit

# Project Details
| Platform | Language| Timeframe | Target Platoform|
|----------------|-------------|-----------|-----------|
| Godot| GDScript| June| Arcade |

# Shortcuts
**Change Log Updates**
* **Released**

	*  [Version 1.0.0](#Version-1.0.0)
		* [Changed](#Version-1.0.0/Changed)
* **Unreleased**
	* [Version 0.3.0](#Version-0.3.0)
		* [Added](#Version-0.3.0/Added)
	* [Version 0.2.1](#Version-0.2.1)
		* [Changed](#Version-0.2.1/Changed)
	* [Version 0.2.0](#Version-0.2.0)
		* [Added](#Version-0.2.0/Added)
		* [Changed](#Version-0.2.1/Changed)
	* [Version 0.1.0](#Version-0.1.0)
		* [Added](#Version-0.1.0/Added)


**Information**
* [System  Requirments](#System-Requirements)
* [Guide](#Guide)
	* [Movement](#Movement)
		 [Options](#Options)
* [Methods](#Method-Used)
	* [Snake Grow](#Snake-Grow)
	* [Apple Spawner](#Apple-Spawner)

# System Requirements 
**RAM:** 4GB
**Storage**: 1GB
**CPU:** Intel Pentium 4 2.00GHz
**GPU:** NVIDIA GeForce 6100

# Guide
### Movement
* **Up** 		 -  [ARROW-UP]
* **Down**	 -  [ARROW-DOWN]
* **Left**		 -   [ARROW-LEFT]
* **Right**	 -  [ARROW-RIGHT]


### Options
* **Quiet**		 -  [ARROW-UP]
* **Start** - [LEFT-CLICK]

# Methods
### Snake Grow
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

### Apple Spawner
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
				

# Change log
# [Released]
## [Version 1.0.0]
### Changed 
- [x] Fixed apples spawing inside the border
- [x] Changed start button to keyboard button press
# [Unreleased]
## [Version 0.3.0]
### Added
- [x] Score counter
- [x] Gamer over screen
- [x] Border for more arcade feel

## [Version 0.2.1]
### Changed
- [x] Fixed bug with food not disappearing
- [x] Fixed bug with food spawning in snake

## [Version 0.2.0]
### Added
- [x] Spawn apples on game board
- [x] Collision detection with apples & walls
### Change
- [x] Small improvements to the UI
- [x] Changed movement key's & function's


## [Version 0.1.0] 

### Added
- [x] Create Game Arena
- [x] Creating Snake entity
- [x] Snake entity movements
