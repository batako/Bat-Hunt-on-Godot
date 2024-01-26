extends Node2D

const ENEMY_INSTANCE_BASE_NAME = "Enemy"

# 画面中央にノードを移動
func move_to_screen_center():
	# ビューポートのサイズを取得
	var viewport_size = get_viewport().size
	# ビューポートの中心点を計算
	var center = viewport_size / 2
	# ノードの位置をビューポートの中心に設定
	position = center
