extends Node3D

var target
const RAY_LENGTH = 2000.0

@onready var player = get_tree().get_first_node_in_group("player")
@onready var camera = get_tree().get_first_node_in_group("playerCamera")

func _physics_process(delta):
	handleTargetHiglighting()

func handleTargetHiglighting():
	var new_target = castCursorRay()
	# Only do work when the hovered thing changes (including to null)
	if new_target != target:
		# unhighlight previous
		if target and is_instance_valid(target) and target.is_in_group("interactive"):
			target.isSelected = false
		target = new_target
		# highlight new
		if target and target.is_in_group("interactive"):
			print(target)
			target.isSelected = true

func castCursorRay():
	var space_state = get_world_3d().direct_space_state
	var mousepos = get_viewport().get_mouse_position()
	var origin = camera.project_ray_origin(mousepos)
	var end = origin + camera.project_ray_normal(mousepos) * RAY_LENGTH
	var query = PhysicsRayQueryParameters3D.create(origin, end)
	query.collide_with_areas = true
	var result = space_state.intersect_ray(query)
	if result:
		return result.collider
	return null
