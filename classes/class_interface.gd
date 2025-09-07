@icon("uid://c8ulrkgg0rfus")
extends Node3D
class_name _Interface


@export var control: Control
@export var animationPlayer: AnimationPlayer
@export var camera: Camera3D

func _ready() -> void:
	control.set_visible(self.visible)
	animationPlayer.play("default")


func open():
	control.set_visible(self.visible)
	camera.set_current(true)
	animationPlayer.play("activate")
