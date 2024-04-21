extends Node
@export var coin_scene: PackedScene
@export var play_time = 30
signal game_over

var level: int
var screensize: Vector2
var playing
var score: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screensize = get_viewport().size
	new_game()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if playing and get_tree().get_nodes_in_group("coins").size() == 0:
		level += 1
		spawn_coins()
	
func new_game():
	level = 1
	playing = true
	score = 0
	spawn_coins()
	$GameTimer.wait_time = play_time
	$GameTimer.start()

func spawn_coins():
	for i in level + 4:
		var coin = coin_scene.instantiate()
		add_child(coin)
		coin.position = Vector2(randi_range(0, screensize.x), randi_range(0, screensize.y))
		
func end_game():
	game_over.emit()

func _on_game_timer_timeout() -> void:
	print('game over')
	end_game()
