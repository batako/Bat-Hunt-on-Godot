extends Area2D

# 移動速度
const MOVE_SPEED = 200

# 爆発オブジェクトを読み込んでおく
const Explosion = preload("res://src/Explosion.tscn")

# 画像サイズ
var _screen = Rect2()

# 移動量
var _velocity = Vector2()

# Spriteノード
var sprite_node

# 開始処理
func _ready():
	# 画面サイズを取得
	_screen = get_viewport_rect()
	
	# 移動速度を指定の範囲でランダムで決める。
	_velocity.x = randf_range(-1, 1)
	_velocity.y = randf_range(-1, 1)

	# Spriteノードを取得
	sprite_node = get_node("Sprite")

# 更新処理
func _process(delta):
	# 移動処理
	position += _velocity * MOVE_SPEED * delta
	
	# Spriteを左右反転
	if _velocity.x < 0:
		sprite_node.flip_h = true
	else:
		sprite_node.flip_h = false
	
	# 画面端での跳ね返り判定
	if position.x < 0:
		position.x = 0
		_velocity.x *= -1
	if position.y < 0:
		position.y = 0
		_velocity.y *= -1
	if position.x > _screen.size.x:
		position.x = _screen.size.x
		_velocity.x *= -1
	if position.y > _screen.size.y:
		position.y = _screen.size.y
		_velocity.y *= -1

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.is_pressed():
			# 爆発オブジェクトを作る
			var explosion = Explosion.instantiate()
			# 自分の位置に爆発を生成する
			explosion.position = position
			# ルートオブジェクトに登録する
			get_tree().root.add_child(explosion)
			
			queue_free()
