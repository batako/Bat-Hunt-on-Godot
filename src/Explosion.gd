extends Sprite2D

# 演出速度
const SPEED = 37 * 2 # 37パターンで0.5秒

# 経過時間
var _pasttime = 0.0

# 更新処理
func _process(delta):
	# 経過時間を計算
	_pasttime += delta
	
	frame = int(_pasttime * SPEED)
	if frame >= 38:
		queue_free()
