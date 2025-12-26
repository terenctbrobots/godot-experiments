extends ColorRect

@export var _duration : float = 0.25
const CLEAR : Color = Color(0, 0, 0, 0)
var _tween : Tween

func _ready() -> void:
	show()

func to_black() -> Signal:
	return _tween_color(Color.BLACK)

func to_clear() -> Signal:
	return _tween_color(CLEAR)

func _tween_color(final : Color) -> Signal:
	if _tween and _tween.is_running():
		_tween.kill()
	_tween = create_tween()
	_tween.tween_property(self, "color", final, _duration)
	return _tween.finished
