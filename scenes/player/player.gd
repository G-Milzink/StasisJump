extends CharacterBody3D
class_name _Player

#===================================================================================================

const SPEED = 2.25

var isBarking: bool = false

@onready var main : Node3D = get_tree().get_root().get_node("Main")
@onready var camera: Camera3D = get_tree().get_first_node_in_group("playerCamera")
@onready var pivot: Node3D = $Pivot
@onready var playerReach: Area3D = $PlayerReach
@onready var textDisplay: Label3D = $TextDisplay

#region RayCasting
var rayOrigin = Vector3()
var rayEnd = Vector3()
var mousePosition = Vector3()
var spaceState : PhysicsDirectSpaceState3D
var query :PhysicsRayQueryParameters3D
var intersection : Dictionary
var lookAtPosition = Vector3()
#endregion

#===================================================================================================

func _ready() -> void:
	playerReach.body_entered.connect(_on_body_entered_player_reach)
	playerReach.body_exited.connect(_on_body_exited_player_reach)
	playerReach.area_entered.connect(on_area_entered_player_reach)
	playerReach.area_exited.connect(on_area_exited_player_reach)
	textDisplay.set_modulate(ConfigSettings.interfaceTextColor)

func _physics_process(delta: float) -> void:
	apply_gravity(delta)
	if PlayerData.hasControl:
		rotate_player()
		calculate_velocity()
		move_and_slide()

#===================================================================================================

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

func apply_gravity(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta

func calculate_velocity():
	var input_dir := Input.get_vector("move_west", "move_east", "move_north", "move_south")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

func _on_body_entered_player_reach(body):
	if body.is_in_group("interactive"):
		body.isPlayerInReach = true

func _on_body_exited_player_reach(body):
	if body.is_in_group("interactive"):
		body.isPlayerInReach = false

func on_area_entered_player_reach(area):
	if area.is_in_group("interactive"):
		area.isPlayerInReach = true

func on_area_exited_player_reach(area):
	if area.is_in_group("interactive"):
		area.isPlayerInReach = false

func bark(barkText: String, barkDuration: float):
	if !isBarking:
		isBarking = true
		textDisplay.set_text(barkText)
		textDisplay.set_visible(true)
		await get_tree().create_timer(barkDuration).timeout
		textDisplay.set_visible(false)
		isBarking = false
