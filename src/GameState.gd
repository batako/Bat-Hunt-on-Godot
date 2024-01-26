# GameState.gd
extends Node

enum GameStates {
	INITIAL,
	IN_GAME,
	CLEARED
}

var current_state = GameStates.INITIAL

# コウモリのシーンのパス
const bat = preload("res://src/Bat.tscn")

func _ready():
	set_game_state(GameStates.INITIAL)

# タイトルの表示/非表示
func _set_title_visibility(is_visible: bool):
	# 現在のシーンを取得
	var current_scene = get_tree().current_scene

	# Titleノードを検索
	var title_node = current_scene.get_node("Title")

	# Titleノードが存在し、Node2Dかその派生クラスのインスタンスである場合
	if title_node and title_node is Node2D:
		# 引数に基づいてノードの可視性を設定
		title_node.visible = is_visible

# ゲームクリアラベルの表示/非表示
func _set_game_clear_label_visibility(is_visible: bool):
	# 現在のシーンを取得
	var current_scene = get_tree().current_scene
	
	# ゲームクリアラベルaノードを検索
	var game_clear_label_node = current_scene.get_node("GameClearLabel")

	# Titleノードが存在し、Node2Dかその派生クラスのインスタンスである場合
	game_clear_label_node.visible = is_visible

# コウモリを指定された数だけ生成
func _spawn_bats(number_of_bats: int):
	# 現在のシーンを取得
	var current_scene = get_tree().current_scene
	
	# ビューポートのサイズを取得
	var viewport_rect = current_scene.get_viewport_rect()
	
	var node_name = bat.get_path().get_file().get_basename()
	
	for i in range(number_of_bats):
		# コウモリのインスタンスを作成
		var bat_instance = bat.instantiate()
		
		# ランダムな位置を生成
		var random_x = randf_range(0.0, viewport_rect.size.x)
		var random_y = randf_range(0.0, viewport_rect.size.y)
		var random_position = Vector2(random_x, random_y)

		# コウモリのインスタンスに位置を設定
		bat_instance.position = random_position

		# コウモリに一意の名前を付ける
		bat_instance.name = node_name + str(i)

		# 現在のシーンにコウモリを追加
		current_scene.add_child(bat_instance)

# コウモリを削除
func _remove_all_bats():
	# 現在のシーンを取得
	var current_scene = get_tree().current_scene

	# 現在のシーンの子ノードを走査
	for child in current_scene.get_children():
		# 名前に'Bat'を含むノードを検索
		if 'Bat' in child.name:
			# ノードを削除
			child.queue_free()

func set_game_state(state):
	current_state = state
	
	match current_state:
		# スタート画面
		GameStates.INITIAL:
			_set_title_visibility(true)
			_set_game_clear_label_visibility(false)
			_remove_all_bats()
		# ゲーム画面
		GameStates.IN_GAME:
			_set_title_visibility(false)
			_set_game_clear_label_visibility(false)
			_spawn_bats(randi() % 9 + 1)
		# ゲームクリア画面
		GameStates.CLEARED:
			_set_title_visibility(false)
			_set_game_clear_label_visibility(true)
			_remove_all_bats()
