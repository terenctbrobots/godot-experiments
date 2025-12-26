extends OmniLight3D

@export var _energy_levels : Array[float]
var _current_energy_level : int

func flicker() -> void:
	_current_energy_level += 1
	_current_energy_level %= _energy_levels.size()
	light_energy = _energy_levels[_current_energy_level]
