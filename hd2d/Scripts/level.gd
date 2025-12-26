class_name Level extends Node3D

@onready var _fade: ColorRect = %Fade
@onready var rooms: Array[Node] = $Rooms.get_children()

func room_transition(next_room : int) -> void:
	await _fade.to_black()
	for room in rooms.size():
		rooms[room].visible = room == next_room
	_fade.to_clear()
