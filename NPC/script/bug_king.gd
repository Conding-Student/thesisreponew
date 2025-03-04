extends KinematicBody2D

const deatheffect = preload("res://Effects/EnemyDeathEffect.tscn")

export var ACCELERATION = 300
export var MAX_SPEED = 50
export var FRICTION = 200
export var WANDER_TARGET_RANGE = 4

onready var playerDetectionZone = $PlayerDetectionZone
onready var sprite = $sprite
onready var animation = $AnimationPlayer
onready var softCollision = $SoftCollision
onready var wanderController = $WanderController
onready var stats = $Stats
onready var hurtbox = $Hurtbox

enum {
	IDLE,
	WANDER,
	CHASE
}

var velocity = Vector2.ZERO
var state = IDLE
var last_direction = Vector2.RIGHT  # Store the last movement direction
var knockback = Vector2.ZERO

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, FRICTION * delta)
	knockback = move_and_slide(knockback)
	match state:
		IDLE:
			play_idle_animation()
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			seek_player()
			if wanderController.get_time_left() == 0:
				update_wander()
		WANDER:
			seek_player()
			if wanderController.get_time_left() == 0:
				update_wander()
			accelerate_towards_point(wanderController.target_position, delta)
			if global_position.distance_to(wanderController.target_position) <= WANDER_TARGET_RANGE:
				update_wander()
		CHASE:
			var player = playerDetectionZone.player
			if player != null:
				#animation.play("attack")
				accelerate_towards_point(player.global_position, delta)
			else:
				state = IDLE
		
	if softCollision.is_colliding():
		velocity += softCollision.get_push_vector() * delta * 400
	velocity = move_and_slide(velocity)

func accelerate_towards_point(point, delta):
	var direction = global_position.direction_to(point)
	velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
	
	# Play the walk animation and flip the sprite based on horizontal movement
	if direction.length() > 0:  # Only update if there is movement
		animation.play("walk")  # Play the default walk animation

		# Flip the sprite horizontally based on the direction (left or right)
		if direction.x > 0:
			sprite.flip_h = false  # Moving right (no flip)
		elif direction.x < 0:
			sprite.flip_h = true   # Moving left (flipped horizontally)


func play_idle_animation():
	# Play the idle animation based on the last direction
	if abs(last_direction.x) > abs(last_direction.y):
		if last_direction.x > 0:
			animation.play("idle_right")
		else:
			animation.play("idle_left")
	else:
		if last_direction.y > 0:
			animation.play("idle_down")
		else:
			animation.play("idle_right")

func update_wander():
	state = pick_random_state([IDLE, WANDER])
	wanderController.start_wander_timer(rand_range(1, 3))

func pick_random_state(state_list):
	state_list.shuffle()
	return state_list.pop_front()

func seek_player():
	if playerDetectionZone.can_see_player():
		state = CHASE

func _on_Stats_no_health():
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
