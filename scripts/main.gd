extends Node2D

@export var decay_speed := 200.0

@onready var camera  := $GameCamera
@onready var tilemap := $TileMap

var decay_wall_x  := -200.0
var tile_decay    := {}
var cached_cells  := []  # ← add this here

func _ready():
	cached_cells = tilemap.get_used_cells(0)
	camera.zoom = Vector2(3.0, 3.0)  # higher = more zoomed in, lower = more zoomed out

func _process(delta):
	camera.global_position = $player.global_position
	decay_wall_x += decay_speed * delta
	_apply_decay_to_tiles()

func _apply_decay_to_tiles():
	for cell in cached_cells:
		if not tilemap.get_cell_source_id(0, cell) == -1:
			var world_pos: Vector2 = tilemap.map_to_local(cell)
			var dist_behind: float = decay_wall_x - world_pos.x
			var factor: float = clamp(inverse_lerp(0.0, 600.0, dist_behind), 0.0, 1.0)
			tile_decay[cell] = factor
			if factor >= 1.0:
				cached_cells.erase(cell)
				tilemap.erase_cell(0, cell)
