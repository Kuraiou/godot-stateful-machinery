@tool
class_name MoodTransitionTime extends MoodTransition

@export var time: float = 1

var _timer: SceneTreeTimer
var _already_triggered := false

func _is_valid() -> bool:
	if _timer:
		return false
		
	_setup_timer() # no await

	return _already_triggered

func _setup_timer()  -> void:
	if _timer:
		return
	
	var process_mood: MoodSelector.ProcessMoodOn = (get_parent() as MoodSelector).process_mood_on
	var process_physics: bool = process_mood == MoodSelector.ProcessMoodOn.PHYSICS

	# @TODO export var for process_always
	_timer = get_tree().create_timer(time, true, process_physics)
	await _timer.timeout
	_already_triggered = true
	_timer = null
