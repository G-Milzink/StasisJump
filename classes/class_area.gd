@icon("uid://b746ifsjo471f")
extends Area3D
class_name _AreaControl

var firstRun: bool = true

var allBodiesNeedingCodes: Array
var allPossibleCodeCarriers: Array

func _process(delta: float) -> void:
	if firstRun:
		firstRun = false
		for body in self.get_overlapping_bodies():
			if body.is_in_group("willAskForCode"):
				allBodiesNeedingCodes.append(body)
		for body in self.get_overlapping_bodies():
			if body.is_in_group("canCarryCode"):
				allPossibleCodeCarriers.append(body)
		distributeCodes()

func distributeCodes():
	for lockedBody in allBodiesNeedingCodes:
		var codeCarrier = allPossibleCodeCarriers.pick_random()
		allPossibleCodeCarriers.erase(codeCarrier)
		codeCarrier.getCode()
		lockedBody.interface.lockScreen.code = codeCarrier.getCode()
	print(allPossibleCodeCarriers)
