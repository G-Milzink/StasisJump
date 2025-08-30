extends Node




func generateCode():
	var code: String
	for i in 4:
		code += str(randi_range(0,9))
	return code
