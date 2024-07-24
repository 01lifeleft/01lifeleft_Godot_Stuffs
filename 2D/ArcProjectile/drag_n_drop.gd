extends Node


@onready var master: Sprite2D = get_parent()

var is_dragging := false
var drag_offset := Vector2.ZERO


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				if master.get_rect().has_point(master.to_local(event.global_position)):
					is_dragging = true
					drag_offset = master.global_position - event.global_position
			else:
				is_dragging = false
	elif event is InputEventMouseMotion:
		if is_dragging:
			master.global_position = event.global_position + drag_offset
