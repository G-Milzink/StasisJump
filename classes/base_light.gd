class_name base_light
extends Node3D

@export var light: Light3D
@export var color: Color
@export_range(0.0, 1.0) var strength: float = 0.5
@export var shadows: bool = true

func _ready() -> void:
	light.light_color = color
	light.light_energy = strength
	light.shadow_enabled = shadows
