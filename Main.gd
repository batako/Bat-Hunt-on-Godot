extends Area2D

func _process(delta):
	if GameState.current_state == GameState.GameStates.IN_GAME:
		var cnt = 0
		for child in get_children():
			if Common.ENEMY_INSTANCE_BASE_NAME in child.name:
				cnt += 1

		if cnt == 0:
			GameState.set_game_state(GameState.GameStates.CLEARED)

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.is_pressed():
			match GameState.current_state:
				# スタート画面
				GameState.GameStates.INITIAL:
					GameState.set_game_state(GameState.GameStates.IN_GAME)
				# ゲームクリア画面
				GameState.GameStates.CLEARED:
					GameState.set_game_state(GameState.GameStates.IN_GAME)
