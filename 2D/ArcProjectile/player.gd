extends Sprite2D


@onready var main_scene: Node2D = get_parent()

@export var projectile_data: ProjectileData = null
@export var enemy: Sprite2D
@export var shoot_cooldown := 1.0

var shoot_time := 0.0


func _process(delta: float) -> void:
	shoot_time += delta
	if shoot_time >= shoot_cooldown:
		shoot_projectile()
		shoot_time -= shoot_cooldown


func shoot_projectile():
	if projectile_data:
		var projectile := Projectile.new(projectile_data, self, enemy)
		main_scene.add_child(projectile)
