extends Node


var nextClearanceLevel: int = 1:
	get:
		var previousValue: int  = nextClearanceLevel
		nextClearanceLevel += 1
		return previousValue
