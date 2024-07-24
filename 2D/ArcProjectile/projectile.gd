class_name Projectile extends Node2D


var sprite: Sprite2D

var data: ProjectileData
var target: Node2D
var start_position: Vector2
var end_position: Vector2
var control_point_1: Vector2
var control_point_2: Vector2

var time: float


func _init(projectile_data: ProjectileData, source_unit: Sprite2D, target_unit: Sprite2D) -> void:
	if not projectile_data:
		queue_free()
	data = projectile_data
	if source_unit:
		start_position = source_unit.global_position
		global_position = start_position
	if target_unit:
		end_position = target_unit.global_position
		target = target_unit


func _ready() -> void:
	sprite = Sprite2D.new()
	sprite.texture = load("res://asset/point_arrow_x64.png")
	add_child(sprite)
	control_point_1 = start_position + (data.control_1_scale * data.arc_strength * (1.0 + randf_range(-data.offset_strength, data.offset_strength)))
	control_point_2 = end_position + (data.control_2_scale * data.arc_strength * (1.0 + randf_range(-data.offset_strength, data.offset_strength)))


func _process(delta: float) -> void:
	if target:
		end_position = target.global_position
	
	var bezier_velocity := start_position.bezier_interpolate(control_point_1, control_point_2, end_position, time)
	
	if sprite:
		sprite.look_at(bezier_velocity)
	global_position = bezier_velocity
	
	time += delta * data.move_speed
	if time >= 1.0:
		queue_free()
