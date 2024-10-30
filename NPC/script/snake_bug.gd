extends KinematicBody2D

const deatheffect = preload("res://Effects/EnemyDeathEffect.tscn")
export var bat_id: String = ""  # Unique ID for each bat
export var ACCELERATION = 300
export var MAX_SPEED = 50
export var FRICTION = 200
export var WANDER_TARGET_RANGE = 4
export var slime_id: String = ""  # Unique ID for each bat
onready var attack_Range = $attack_range
onready var playerDetectionZone = $PlayerDetectionZone
onready var sprite = $sprite
onready var animation = $AnimationPlayer
onready var softCollision = $SoftCollision
onready var wanderController = $WanderController
onready var stats = $Stats
onready var hurtbox = $Hurtbox
onready var hitbox = $Hitbox/CollisionShape2D  # Get the hitbox node
onready var hising_sounds = $AudioStreamPlayer

enum {
	IDLE,
	WANDER,
	CHASE,
	ATTACK
}

var velocity = Vector2.ZERO
var state = IDLE
var knockback = Vector2.ZERO

func _ready():
	# Check the state from the Global singleton
	if not Global.get_bat_state(slime_id):
		#print("Bat is dead on load, removing from scene: ID =", bat_id)  # Debugging print
		queue_free()  # If dead, remove from the scene
	else:
		#print("Bat is alive on load, initializing state: ID =", bat_id)  # Debugging print
		state = pick_random_state([IDLE, WANDER])  # Initialize state if alive

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, FRICTION * delta)
	knockback = move_and_slide(knockback)

	match state:
		IDLE:
			play_idle_animation()
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			check_wander()
			seek_player()

		WANDER:
			seek_player()
			check_wander()
			accelerate_towards_point(wanderController.target_position, delta)
			if global_position.distance_to(wanderController.target_position) <= WANDER_TARGET_RANGE:
				update_wander()

		CHASE:
			var player = playerDetectionZone.player
			if player != null:
				hising_sounds.play()
				animation.play("walk")
				if is_in_attack_range(player):
					state = ATTACK
				else:
					accelerate_towards_point(player.global_position, delta)
			else:
				state = IDLE

		ATTACK:
			var player = attack_Range.player
			if player != null:
				#if not animation.is_playing() or animation.current_animation != "attack":
					 # Play the attack animation

				if is_in_attack_range(player):
					animation.play("attack") 
					#activate_hitbox()  # Ensure hitbox is active during attack
				else:
					deactivate_hitbox()  # Deactivate hitbox when no longer in range
					state = CHASE  # Go back to chasing if out of attack range
			else:
				deactivate_hitbox()
				state = IDLE


	if softCollision.is_colliding():
		velocity += softCollision.get_push_vector() * delta * 400

	velocity = move_and_slide(velocity)

func accelerate_towards_point(point, delta):
	var direction = global_position.direction_to(point)
	velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
	if abs(velocity.x) > 0.1:
		sprite.flip_h = velocity.x < 0
	check_state_change()

func play_idle_animation():
	animation.play("idle")

func update_wander():
	state = pick_random_state([IDLE, WANDER])
	wanderController.start_wander_timer(rand_range(1, 3))

func pick_random_state(state_list):
	state_list.shuffle()
	return state_list.pop_front()

func seek_player():
	if playerDetectionZone.can_see_player():
		state = CHASE

func check_wander():
	if wanderController.get_time_left() == 0:
		update_wander()

func check_state_change():
	var player = attack_Range.player
	var playerchase = playerDetectionZone.player
	if player != null and is_in_attack_range(player):
		state = ATTACK
	elif playerchase != null:
		state = CHASE
	else:
		state = IDLE

func is_in_attack_range(player) -> bool:
	var collision_shape = attack_Range.get_node("CollisionShape2D")
	var shape = collision_shape.shape
	if shape is CircleShape2D:
		return global_position.distance_to(player.global_position) <= shape.radius
	return false

func _on_Stats_no_health():
	Global.set_bat_state(slime_id, false) 
	queue_free()
	var enemyDeathEffect = deatheffect.instance()
	get_parent().add_child(enemyDeathEffect)
	enemyDeathEffect.global_position = global_position

func _on_Hurtbox_area_entered(area):
	stats.health -= area.damage
	knockback = area.knockback_vector * 150
	hurtbox.create_hit_effect()
	hurtbox.start_invincibility(0.4)

func _on_Hurtbox_invincibility_ended():
	animation.play("Stop")

func _on_Hurtbox_invincibility_started():
	animation.play("Start")

# Activate and deactivate hitbox during the attack animation
func activate_hitbox():
	hitbox.disabled = false

func deactivate_hitbox():
	hitbox.disabled = true
