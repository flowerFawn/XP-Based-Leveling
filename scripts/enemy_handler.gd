extends Node2D
class_name EnemyHandler

var current_quadtree:QuadTreeBucket
var current_leaves:Array[QuadTreeBucket]

func _ready() -> void:
	var quadtree_remake_timer:Timer = Timer.new()
	add_child(quadtree_remake_timer, false, Node.INTERNAL_MODE_FRONT)
	quadtree_remake_timer.timeout.connect(update_quadtree)
	quadtree_remake_timer.start(1)
	update_quadtree()

func update_quadtree() -> void:
	var all_enemies:Array[Enemy]
	all_enemies.assign(get_children())
	current_quadtree = form_quad_tree(all_enemies)
	current_leaves = get_leaves(current_quadtree)
	if Config.show_quadtree:
		queue_redraw()
	print("hmm")

func _physics_process(delta: float) -> void:
	var all_enemies:Array[Enemy]
	var leaves:Array[QuadTreeBucket]
	all_enemies.assign(get_children())
	if current_leaves.is_empty():
		return
	for leaf:QuadTreeBucket in current_leaves:
		for enemy:Enemy in leaf.enemies.filter(get_enemy_exists):
			enemy.do_movement(delta, leaf.enemies.filter(get_enemy_exists))
	#print(leaves.size())
			
func _draw() -> void:
	for leaf:QuadTreeBucket in current_leaves:
		draw_line(leaf.start, leaf.end, Color.BLACK)
		draw_line(leaf.start, Vector2(leaf.end.x, leaf.start.y), Color.BLACK)
		draw_line(leaf.start, Vector2(leaf.start.x, leaf.end.y), Color.BLACK)
		draw_line(leaf.end, Vector2(leaf.start.x, leaf.end.y), Color.BLACK)
		draw_line(leaf.end, Vector2(leaf.end.x, leaf.start.y), Color.BLACK)
	
	#for enemy:Enemy in all_enemies:
	#	enemy.do_movement(delta, all_enemies)
		
func get_leaves(bucket:QuadTreeBucket) -> Array[QuadTreeBucket]:
	var leaves:Array[QuadTreeBucket]
	if bucket != null:
		if bucket.children.is_empty():
			leaves.append(bucket)
		else:
			for child in bucket.children:
				leaves.append_array(get_leaves(child))
	return leaves
		
func form_quad_tree(all_enemies:Array[Enemy]) -> QuadTreeBucket:
	var root:QuadTreeBucket 
	if all_enemies.is_empty():
		return null
	all_enemies.assign(get_children())
	#I think untyped is faster than reassigning to a typed array from map?
	var all_enemy_x:Array = all_enemies.map(get_enemy_x)
	var all_enemy_y: Array = all_enemies.map(get_enemy_y)
	var start:Vector2 = Vector2(all_enemy_x.min(), all_enemy_y.min())
	var end:Vector2 = Vector2(all_enemy_x.max(), all_enemy_y.max())
	root = QuadTreeBucket.new(start, end, all_enemies)
	return root

func get_enemy_x(enemy:Enemy) -> float:
	return enemy.position.x


func get_enemy_y(enemy:Enemy) -> float:
	return enemy.position.y

func get_enemy_exists(enemy:Variant) -> bool:
	return is_instance_valid(enemy)

class QuadTreeBucket:
	const BUCKET_MAX:int = 10
	var start:Vector2 #top left corner
	var end:Vector2 #bottom right corner
	var enemies:Array[Enemy]
	var children:Array[QuadTreeBucket] #should have 4 or be empty
	
	func _init(given_start, given_end, possible_enemies:Array[Enemy]) -> void:
		start = given_start
		end = given_end
		print(start, end)
		enemies = possible_enemies.filter(is_enemy_in_bucket)
		if enemies.size() > BUCKET_MAX:
			enemies.clear()
			partition(possible_enemies)
			
	func partition(enemies:Array[Enemy]) -> void:
		children.resize(4)
		#top left
		children[0] = QuadTreeBucket.new(start, start + 1/2.0 * (end - start), enemies)
		#top right
		children[1] = QuadTreeBucket.new(
			Vector2(start.x + 1/2.0 * (end.x - start.x), start.y), 
			Vector2(end.x, start.y + 1/2.0 * (end.y - start.y)), enemies)
		#bottom left
		children[2] = QuadTreeBucket.new(
			Vector2(start.x, start.y + 1/2.0 * (end.y - start.y)),
			Vector2(start.x + 1/2.0 * (end.x - start.x), end.y), enemies)
		#bottom right
		children[3] = QuadTreeBucket.new(start + 1/2.0 * (end - start), end , enemies)
	
	#this may technicailly lead to an enemy in two buckets? wgaf
	func is_enemy_in_bucket(enemy:Enemy) -> bool:
		if start.x <= enemy.position.x and enemy.position.x <= end.x:
			if start.y <= enemy.position.y and enemy.position.y <= end.y:
				return true
			else:
				return false
		else:
			return false
