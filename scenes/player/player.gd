extends CharacterBody3D

#RayCast variables:
var rayOrigin = Vector3()
var rayEnd = Vector3()
var mousePosition = Vector3()
var spaceState : PhysicsDirectSpaceState3D
var query :PhysicsRayQueryParameters3D
var intersection : Dictionary
var lookAtPosition = Vector3()

const SPEED = 2.25

@onready var main : Node3D = get_tree().get_root().get_node("Main")
@onready var pivot: Node3D = $Pivot
@onready var camera: Camera3D = get_tree().get_first_node_in_group("camera")


func _physics_process(delta: float) -> void:
	rotate_player()

	if not is_on_floor():
		velocity += get_gravity() * delta


	var input_dir := Input.get_vector("move_west", "move_east", "move_north", "move_south")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func rotate_player():
	spaceState = get_world_3d().direct_space_state
	mousePosition = get_viewport().get_mouse_position()
	
	rayOrigin = camera.project_ray_origin(mousePosition)
	rayEnd = rayOrigin + camera.project_ray_normal(mousePosition) * 2000
	
	query = PhysicsRayQueryParameters3D.create(rayOrigin, rayEnd)
	intersection = spaceState.intersect_ray(query)
	
	if intersection:
		lookAtPosition = intersection.position
		var direction = (lookAtPosition - pivot.global_transform.origin).normalized()
		direction.y = 0
		pivot.rotation.y = atan2(direction.x, direction.z)  
