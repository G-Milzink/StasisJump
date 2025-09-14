extends _Object
class_name _Object_Log

@export var storyArea: String



func _enter_tree() -> void:
	propagate_call("setStoryAreaFrom_Object", [storyArea], true)


func _ready() -> void:
	super()
	interface.storyArea = storyArea


func setStoryAreaFrom_Object(area: String) -> void:
	storyArea = area
