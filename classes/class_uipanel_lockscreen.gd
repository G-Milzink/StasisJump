extends _UIPanel
class_name _UIPanel_Lockscreen

#===============================================================================

var numpadIsActive: bool = false
var currentDigit: int = 0
var code: String = "0451"
signal code_entered

@onready var numPad1: Button = $Control/GridContainer/NumPad1
@onready var numPad2: Button = $Control/GridContainer/NumPad2
@onready var numPad3: Button = $Control/GridContainer/NumPad3
@onready var numPad4: Button = $Control/GridContainer/NumPad4
@onready var numPad5: Button = $Control/GridContainer/NumPad5
@onready var numPad6: Button = $Control/GridContainer/NumPad6
@onready var numPad7: Button = $Control/GridContainer/NumPad7
@onready var numPad8: Button = $Control/GridContainer/NumPad8
@onready var numPad9: Button = $Control/GridContainer/NumPad9
@onready var numPadBack: Button = $Control/GridContainer/NumPadBack
@onready var numPad0: Button = $Control/GridContainer/NumPad0
@onready var digitsArray: Array[Label] = [
	$Control/Screen/Digit0,
	$Control/Screen/Digit1,
	$Control/Screen/Digit2,
	$Control/Screen/Digit3]

#===============================================================================

func _ready() -> void:
	initialSetup()
	re_setDigits()
	connectSignals()

#===============================================================================

func initialSetup():
	controlNode.set_modulate(ConfigSettings.interfaceBorderColor)

func re_setDigits() -> void:
	currentDigit = 0
	for i in digitsArray.size():
		digitsArray[i].set_text(".")
	numpadIsActive = true

func connectSignals():
	numPad1.button_down.connect(_on_numpad_button_down.bind(1))
	numPad2.button_down.connect(_on_numpad_button_down.bind(2))
	numPad3.button_down.connect(_on_numpad_button_down.bind(3))
	numPad4.button_down.connect(_on_numpad_button_down.bind(4))
	numPad5.button_down.connect(_on_numpad_button_down.bind(5))
	numPad6.button_down.connect(_on_numpad_button_down.bind(6))
	numPad7.button_down.connect(_on_numpad_button_down.bind(7))
	numPad8.button_down.connect(_on_numpad_button_down.bind(8))
	numPad9.button_down.connect(_on_numpad_button_down.bind(9))
	numPad0.button_down.connect(_on_numpad_button_down.bind(0))
	numPadBack.button_down.connect(_on_back_button_down)

func _on_numpad_button_down(value: int) -> void:
	if numpadIsActive:
		digitsArray[currentDigit].set_text(str(value))
		currentDigit+=1
		if currentDigit >= digitsArray.size():
			numpadIsActive = false
			await get_tree().create_timer(1.0).timeout
			compareInputToCode(code)

func _on_back_button_down() -> void:
	if currentDigit > 0:
		currentDigit-=1
		digitsArray[currentDigit].set_text(".")

func compareInputToCode(code: String) -> void:
	var input: String = ""
	for i in digitsArray.size():
		input += digitsArray[i].get_text()
	if input == code:
		emit_signal("code_entered")
	else:
		re_setDigits()
