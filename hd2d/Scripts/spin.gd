extends Node3D

@export var _spin_speed : float = 1
@export var _alpha_range : Vector2
@export var _height_range : Vector2
@export var _emission_range : Vector2
@export var _pulse_rate : float = 2
@onready var _pillar_material: StandardMaterial3D = $LightPillar.get_node("Pillar").mesh.get("surface_0/material")
@onready var _bottom_material: StandardMaterial3D = $Bottom.get_node("BottomCircle").mesh.get("surface_0/material")
@onready var _light: OmniLight3D = $OmniLight3D
var t : float
var sin_t : float

func _ready() -> void:
	t = randf_range(0, 100)
	rotation.y = randf_range(-PI, PI)

func _process(delta: float) -> void:
	t += delta * _pulse_rate
	rotation.y += _spin_speed * delta
	sin_t = (sin(t) + 1) / 2.0
	_light.light_energy = lerp(_emission_range.x, _emission_range.y, sin_t)
	_pillar_material.albedo_color.a = lerp(_alpha_range.x, _alpha_range.y, sin_t)
	_bottom_material.emission_energy_multiplier = lerp(_emission_range.x, _emission_range.y, sin_t)
	$LightPillar.scale.y = lerp(_height_range.x, _height_range.y, sin_t)
