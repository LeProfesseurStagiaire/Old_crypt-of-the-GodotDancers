extends Node2D

var dir_h = 0
var dir_v = 0
onready var can_walk = true
onready var speed = get_tree().get_current_scene().speed
onready var s = $s
onready var distance = 64
var dir = Vector2()

signal move

func _ready():
	position = Vector2(32,(position.y - (s.texture.get_size().y/2) + 32))
	$s_shadow.position.y = s.texture.get_size().y/2

func _process(delta):
	if can_walk:
		if Input.is_action_pressed("ui_left"):
			dir = Vector2(-1,0)
		elif Input.is_action_pressed("ui_right"):
			dir = Vector2(1,0)
		elif Input.is_action_pressed("ui_up"):
			dir = Vector2(0,-1)
		elif Input.is_action_pressed("ui_down"):
			dir = Vector2(0,1)
		else : 
			dir = Vector2(0,0)
		if dir:
			can_walk = false
			var next_pos = Vector2(distance*dir.x,distance*dir.y)
			$position.interpolate_property(self,"position",position,position + next_pos,speed,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
			$s_scale.interpolate_property(s,"scale",s.scale * 1.1,s.scale,speed,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
			$s_color.interpolate_property(s,"modulate",s.modulate,Color(rand_range(0.4,0.6),rand_range(0.5,1),rand_range(0.5,1)),speed*3,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
			$position.start()
			$s_scale.start()
			$s_color.start()
			$jump.play("jump")
			$move.start(speed)
			emit_signal("move")

func miss_bpm():
	$move.stop()
	can_walk = false
	$move.start(speed*3)
	$s_color.interpolate_property(s,"modulate",s.modulate,Color(1,0,0),speed*3,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)

func _on_Timer_timeout():
	if can_walk == false:
		can_walk = true
		$s_color.interpolate_property(s,"modulate",s.modulate,Color(rand_range(0.4,0.6),rand_range(0.5,1),rand_range(0.5,1)),speed*3,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)