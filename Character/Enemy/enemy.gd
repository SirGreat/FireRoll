extends "res://Character/Character.gd"

const KNOCKBACKSPEED = 200

export var Damage: int
export var DamageRange: int
export var CriticalChance: int
export var CriticalMultiplier: float
export var DetectionRadius: int
export var DropRate: int
export var BaseValue: int
export var ValueRange: int
var EXP

enum State {STATE_PATROL, STATE_CHASE, STATE_ATTACK, STATE_KNOCKBACK, STATE_DROPLOOT, STATE_DEAD}

var currentState
var knockback
var knockbackVector = Vector2()
var beforeKnockBackPos = Vector2()

onready var target = get_parent().get_node("Player")
onready var GOLD = preload("res://Items/Consumables/Coins.tscn")
var MAIN

var rng = RandomNumberGenerator.new()

signal DropLoot(gold, pos)
signal GiveEXP(EXP)

func _ready():
	add_to_group("Enemies")
	$Base/HealthBar.max_value = Health
	$Base/HealthBar.value = Health
	$Base/HealthBar.hide()
	MAIN = $".".get_parent().get_parent().get_parent()
	
	connect("DropLoot", MAIN, "dropLoot", [], CONNECT_ONESHOT)
	connect("GiveEXP", target, "addEXP", [], CONNECT_ONESHOT)
	
	rng.randomize()
	
func _physics_process(delta):
	checkDeath()
		
	match currentState:
		State.STATE_KNOCKBACK:
			
			# Get target pos
			var targetPos = target.position 
			# Get knockback dir vector
			knockbackVector = (targetPos - position).normalized()

			position -= knockbackVector * KNOCKBACKSPEED * delta
			if (position - beforeKnockBackPos).length() > knockback:
				currentState = State.STATE_CHASE
				
		State.STATE_DEAD:
			# Death
			#$AnimationPlayer.clear_queue()
			$AnimationPlayer.current_animation = "Death"
			yield($AnimationPlayer, "animation_finished")
			
			
			queue_free()
			
		State.STATE_DROPLOOT:
			# Drop loot
			dropLoot()
			currentState = State.STATE_DEAD
				
func checkDeath():
	if Health <= 0:
		if currentState != State.STATE_DEAD:
			currentState = State.STATE_DROPLOOT
		
		
func dropLoot():
	#print ("DROP LOOT")
	var variance = rng.randi_range(-ValueRange, ValueRange)
	var totalGold = BaseValue + variance
	emit_signal("DropLoot", totalGold, position)
	emit_signal("GiveEXP", EXP)
	
		
func hit(damage):
	beforeKnockBackPos = position
	currentState = State.STATE_KNOCKBACK
	#$"Knockback Timer".start()
	Health -= damage
	$AnimationPlayer.play("Take_Damage")
	$Base/HealthBar.show()
	$Base/HealthBar.value -= damage
	

