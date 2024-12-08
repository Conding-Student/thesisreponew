extends KinematicBody2D

const PlayerHurtSound = preload("res://Player/PlayerHurtSound.tscn")

export var ACCELERATION = 500
export var MAX_SPEED = 80
export var ROLL_SPEED = 120
export var FRICTION = 500
export var cooldown_time = 2.0

onready var light = $Light2D
onready var buttonroll = $Controller/Control/BtnRoll
onready var buttonattack = $Controller/Control/BtnAttack
onready var button_timer = $ButtonTimer  # Reference to ButtonTimer

enum {
	MOVE,
	ROLL,
	ATTACK
}

var state = MOVE
var velocity = Vector2.ZERO
var roll_vector = Vector2.DOWN
var stats = PlayerStats
var button_cooldowns = {}  # Dictionary to track button cooldowns

onready var joystick = $Controller/joystick
onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var swordHitbox = $HitboxPivot/SwordHitbox
onready var hurtbox = $Hurtbox
onready var blinkAnimationPlayer = $BlinkAnimationPlayer

func _ready():
	randomize()
	stats.connect("no_health", self, "player_drain_health")
	animationTree.active = true
	swordHitbox.knockback_vector = roll_vector
	
	buttonattack.connect("pressed", self, "_on_button_pressed", [buttonattack])
	buttonroll.connect("pressed", self, "_on_button_pressed", [buttonroll])
	button_timer.connect("timeout", self, "_on_button_timer_timeout")  # Connect the timer signal
	
func _on_button_pressed(button):
	if state == MOVE:
		if button == buttonroll and state != ROLL:
			# Start roll action and cooldown
			state = ROLL
			button.visible = false
			button_cooldowns["roll"] = buttonroll  # Track roll button for cooldown
			button_timer.start(cooldown_time)
		elif button == buttonattack and state != ATTACK:
			# Start attack action and cooldown
			state = ATTACK
			button.visible = false
			button_cooldowns["attack"] = buttonattack  # Track attack button for cooldown
			button_timer.start(cooldown_time)

func _on_button_timer_timeout():
	# Re-enable button based on cooldown
	if "roll" in button_cooldowns:
		button_cooldowns["roll"].visible = true
		button_cooldowns.erase("roll")
	elif "attack" in button_cooldowns:
		button_cooldowns["attack"].visible = true
		button_cooldowns.erase("attack")
	
	state = MOVE  # Reset state to MOVE after cooldown ends

func _physics_process(delta):
	showing_light()
	Global.set_player_current_position(global_position)
	match state:
		MOVE:
			move_state(delta)
		ROLL:
			roll_state()
		ATTACK:
			attack_state()

func move_state(delta):
	# Get joystick input
	var input_vector = joystick.get_velo()
	
	if input_vector != Vector2.ZERO:
		roll_vector = input_vector
		swordHitbox.knockback_vector = input_vector
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationTree.set("parameters/Attack/blend_position", input_vector)
		animationTree.set("parameters/Roll/blend_position", input_vector)
		animationState.travel("Run")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	move()

func roll_state():
	# Start invincibility and perform roll
	hurtbox.start_invincibility(0.2)
	velocity = roll_vector * ROLL_SPEED
	animationState.travel("Roll")
	move()

func attack_state():
	# Stop movement and perform attack
	velocity = Vector2.ZERO
	animationState.travel("Attack")

func move():
	# Move the player based on velocity
	velocity = move_and_slide(velocity)

func roll_animation_finished():
	velocity = velocity * 0.8  # Slow down after roll
	state = MOVE  # Return to MOVE state after roll finishes

func attack_animation_finished():
	state = MOVE  # Return to MOVE state after attack finishes

func _on_Hurtbox_area_entered(area):
	stats.health -= area.damage
	hurtbox.start_invincibility(0.6)
	hurtbox.create_hit_effect()
	var playerHurtSound = PlayerHurtSound.instance()
	get_tree().current_scene.add_child(playerHurtSound)

func player_drain_health():
	queue_free()
	stats.health = 5
	SceneTransition.change_scene("res://intro/Game_over.tscn")

func showing_light():
	if GlobalCanvasModulate.get_current_trigger() == "night":
		light.visible = true
	else:
		light.visible = false

func _on_Hurtbox_invincibility_started():
	blinkAnimationPlayer.play("Start")

func _on_Hurtbox_invincibility_ended():
	blinkAnimationPlayer.play("Stop")
