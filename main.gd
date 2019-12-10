extends Node2D

onready var p = $player
var damier_pos = 0
var dam_c = Color(1, 0.84845, 0.253906, 0.494118)
var speed = 0.2

var time = 0
var shake_time = 0

func _process(delta):
	if shake_time > 0:
		$player/Camera2D.offset = Vector2(rand_range(2,10),rand_range(2,10))
		shake_time -= 1 * delta
	else:
		$player/Camera2D.offset = Vector2(0,0)
	time += 1*delta
	if time >= 0.4615:
		time = 0
		if damier_pos == 0:
			damier_pos = 64
			dam_c = Color(0.312195, 1, 0.253906, 0.494118)
		else:
			damier_pos = 0
			dam_c = Color(1, 0.84845, 0.253906, 0.494118)
		$damier/ParallaxBackground/ParallaxLayer/Sprite.position.x = damier_pos
		$damier/color_alpha.interpolate_property($damier/ParallaxBackground/ParallaxLayer/Sprite,"modulate",
		Color(dam_c.r,dam_c.g,dam_c.v,0.7),Color(dam_c.r,dam_c.g,dam_c.v,0.3),speed,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
		$damier/color_alpha.start()

func can_walk():
	if time >= 0.3 or time <= 0.1:
		return true