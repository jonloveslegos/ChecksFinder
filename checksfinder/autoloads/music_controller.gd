class_name MusicController extends Node


var is_playing: bool = false
var is_looping: bool = false
var is_stopping: bool = false

func start():
	$intro.volume_linear = 1.0
	$loop.volume_linear = 1.0
	$intro.play()
	is_playing = true

func _on_intro_finished() -> void:
	if not is_stopping:
		$loop.play()
		is_looping = true

func stop_gradually():
	is_stopping = true
	$AnimationPlayer.play("sound_fadeout")

func stop_immediately():
	$intro.stop()
	$loop.stop()
	is_stopping = false
	is_playing = false
	is_looping = false
	$intro.volume_linear = 1.0
	$loop.volume_linear = 1.0

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	stop_immediately()
