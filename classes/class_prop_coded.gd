extends Prop
class_name Prop_Coded

#===============================================================================

@export var canReceiveCode: bool = true
@export_multiline var intialMessage: Array[String] = [
	"Use this to wrap the ",
	"*code*",
	" in a proper sentence"
]

var hasCode: bool = false
var code: String = ""

#===============================================================================

func _ready() -> void:
	super()

#===============================================================================

func getCode() -> String:
	canReceiveCode = false
	if !hasCode:
		code = RandomGen.generateCode()
	return code
