extends Node2D

onready var can_walk = true
onready var main = get_tree().get_current_scene()
onready var speed = main.speed
onready var s = $s
onready var distance = 64
var dir = Vector2()

func _ready():
	position = Vector2(32,(position.y - (s.texture.get_size().y/2) + 45))
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
			if !main.can_walk():
				stop()

func stop():
	main.shake_time = 0.15
	can_walk = false
	$move.stop()
	$move.start(speed*4)
	$s_color.interpolate_property(s,"modulate",s.modulate,Color(1,0,0),speed*3,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
	$s_color.start()

func _on_Timer_timeout():
	if can_walk == false:
		can_walk = true
		$s_color.interpolate_property(s,"modulate",s.modulate,Color(rand_range(0.4,0.6),rand_range(0.5,1),rand_range(0.5,1)),speed*3,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
		$s_color.start()