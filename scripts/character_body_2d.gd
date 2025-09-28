extends CharacterBody2D

# ====== Health Settings ======
@export var max_health: int = 100
var health: int = max_health
@onready var health_bar: TextureProgressBar = $"../CanvasLayer/TextureProgressBar"

# ====== Movement Settings ======
@export var speed: float = 200.0
@export var jump_force: float = -400.0
@export var gravity: float = 900.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta

	var input_dir := Input.get_axis("left", "right")
	velocity.x = input_dir * speed

	if input_dir != 0:
		animated_sprite.flip_h = input_dir < 0

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_force

	if not is_on_floor():
		animated_sprite.play("jump")
	elif input_dir != 0:
		animated_sprite.play("run")
	else:
		animated_sprite.play("idle")

	move_and_slide()

# ====== Health Functions ======
func take_damage(amount: int) -> void:
	health -= amount
	health = clamp(health, 0, max_health)
	update_health_bar()

	if health <= 0:
		die()

func update_health_bar() -> void:
	health_bar.value = health

func die() -> void:
	print("Player Died")
	var ds = get_node("../CanvasLayer/DeathScreen")
	ds.visible = true


func _on_button_pressed() -> void:
	print("Restart clicked!")  # for debugging
	get_tree().reload_current_scene()
