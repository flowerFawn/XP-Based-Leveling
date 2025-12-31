extends Node


func _ready() -> void:
	pass
	
func play_sound(sound:AudioStream, position:Vector2 = Vector2.ZERO, pitch_variation:float = 1, volume_variation:float = 0) -> void:
	var audio_stream:AudioStream
	if pitch_variation != 1 or volume_variation != 0:
		var random_audio_stream = AudioStreamRandomizer.new()
		random_audio_stream.add_stream(-1, sound)
		random_audio_stream.random_pitch = pitch_variation
		random_audio_stream.random_volume_offset_db = volume_variation
		audio_stream = random_audio_stream
	else:
		audio_stream = sound
	if position.is_zero_approx():
		var audio_player:AudioStreamPlayer = AudioStreamPlayer.new()
		audio_player.max_polyphony = 25
		audio_player.stream = audio_stream
		add_child(audio_player)
		audio_player.play()
		await audio_player.finished
		audio_player.queue_free()
	else:
		var audio_player:AudioStreamPlayer2D = AudioStreamPlayer2D.new()
		audio_player.max_polyphony = 25
		audio_player.max_distance = 10000
		audio_player.stream = audio_stream
		GameInfo.projectile_holder.add_child(audio_player)
		audio_player.play()
		await audio_player.finished
		audio_player.queue_free()
	#GameInfo.projectile_holder.add_child()
