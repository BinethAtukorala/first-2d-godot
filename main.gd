extends Node

@export var mob_scene: PackedScene

var score: int	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func game_over() -> void:
	$HUD.show_game_over()
	
	$MobTimer.stop()
	$ScoreTimer.stop()
	
func new_game() -> void:
	score = 0
	get_tree().call_group("mobs", "queue_free")
	
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	
	$Player.start($StartPosition.position)
	$StartTimer.start()	


func _on_mob_timer_timeout() -> void:
	var mob: RigidBody2D = mob_scene.instantiate()
	
	var mob_spawn_locaiton: PathFollow2D = $MobPath/MobSpawnLocation
	mob_spawn_locaiton.progress_ratio = randf()
	
	mob.position = mob_spawn_locaiton.position
	
	var direction = mob_spawn_locaiton.rotation + PI/2
	
	direction += randf_range(-PI/4, PI/4)
	mob.rotation = direction
	
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	
	add_child(mob)


func _on_score_timer_timeout() -> void:
	score += 1
	$HUD.update_score(score)


func _on_start_timer_timeout() -> void:
	$MobTimer.start()
	$ScoreTimer.start()
