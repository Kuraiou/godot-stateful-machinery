class_name MoodConditionGroup extends MoodCondition

## A Condition used to create grouping of potential conditions.

## If this is true, then the condition group evaluates to true only if
## all of the conditions evaluate to true (bitwise "and"). Otherwise, the
## condition evaluates to true if _any_ of the conditions evaluate to true
## (bitwise "OR").
@export var and_all_conditions: bool = true

func conditions() -> Array[MoodCondition]:
	return find_children("*", "MoodCondition", false) as Array[MoodCondition]

func _is_valid(target: Node, cache: Dictionary = {}) -> bool:
	if and_all_conditions:
		return conditions().all(_cond_is_valid.bind(cache, target))
	
	return conditions().any(_cond_is_valid.bind(cache, target))

## return whether a condition is valid based on bound inputs.
func _cond_is_valid(condition: MoodCondition, target: Node, cache: Dictionary = {}) -> bool:
	return condition._is_valid(target, cache)