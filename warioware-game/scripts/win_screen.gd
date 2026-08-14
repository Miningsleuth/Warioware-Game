extends Node2D

@export var fall_texture: Texture2D
@export var spawn_interval: float = 0.3
@export var fall_speed: float = 250.0

func _ready() -> void:
	var timer = Timer.new()
	timer.wait_time = spawn_interval
	timer.autostart = true
	timer.timeout.connect(_spawn_piece)
	add_child(timer)

func _spawn_piece() -> void:
	var piece = TextureRect.new()
	piece.texture = fall_texture
	piece.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	piece.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	piece.size = Vector2(100, 100)
	piece.position = Vector2(randf_range(0, 1152), -150)
	add_child(piece)

func _process(delta: float) -> void:
	for child in get_children():
		if child is TextureRect:
			child.position.y += fall_speed * delta
			if child.position.y > 700:
				child.queue_free()
