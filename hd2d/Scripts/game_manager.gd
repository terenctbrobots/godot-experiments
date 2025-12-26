extends Node3D

@onready var _fade: ColorRect = %Fade

func _ready() -> void:
	_fade.to_clear()
