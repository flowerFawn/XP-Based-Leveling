extends Node2D
class_name EnemyHandler

var current_quadtree:QuadTreeBucket
var current_leaves:Array[QuadTreeBucket]

func _ready() -> void:
	update_quadtree()

func update_quadtree() -> void:
	var all_enemies:Array[Enemy]
	all_enemies.assign(get_children())
	current_quadtree = form_quad_tree(all_enemies)
	current_leaves = get_leaves(current_quadtree)
	if Config.show_quadtree:
		queue_redraw()

func _physics_process(delta: float) -> void:
	var valid_enemies:Array[Enemy]
	var non_flying_enemies:Array[Enemy]
	if current_leaves.is_empty():
		return
	for leaf:QuadTreeBucket in current_leaves:
		valid_enemies = leaf.enemies.filter(get_enemy_exists)
		non_flying_enemies = valid_enemies.filter(get_enemy_not_flying)
		for enemy:Enemy in valid_enemies:
			enemy.do_movement(delta, valid_enemies)
			
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
	
func get_enemies_near_point(point:Vector2) -> Array[Enemy]:
	if current_quadtree:
		return current_quadtree.get_enemies_near_point(point).filter(get_enemy_exists)
	else:
		return []
		
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
	if end.x - start.x >= end.y - start.y:
		end.y = start.y + (end.x - start.x)
	else:
		end.x = start.x + (end.y - start.y)

	root = QuadTreeBucket.new(start, end, all_enemies)
	return root

func get_enemy_x(enemy:Enemy) -> float:
	return enemy.position.x


func get_enemy_y(enemy:Enemy) -> float:
	return enemy.position.y

func get_enemy_exists(enemy:Variant) -> bool:
	return is_instance_valid(enemy)
	
func get_enemy_not_flying(enemy:Enemy) -> bool:
	return not enemy.enemy_type.flying

class QuadTreeBucket:
	const BUCKET_MAX:int = 15
	var start:Vector2 #top left corner
	var end:Vector2 #bottom right corner
	var centre_x:float
	var centre_y:float
	var enemies:Array[Enemy]
	var children:Array[QuadTreeBucket] #should have 4 or be empty
	
	func _init(given_start, given_end, given_enemies:Array[Enemy]) -> void:
		start = given_start
		end = given_end
		centre_x = start.x + 1/2.0 * (end.x - start.x)
		centre_y = start.y + 1/2.0 * (end.y - start.y)
		if given_enemies.size() > BUCKET_MAX:
			partition(given_enemies)
		else:
			enemies = given_enemies
			
	func partition(enemies:Array[Enemy]) -> void:
		children.resize(4)
		#top left
		children[0] = QuadTreeBucket.new(
			start, start + 1/2.0 * (end - start), enemies.filter(is_enemy_in_partition.bind(&"NW")))
		#top right
		children[1] = QuadTreeBucket.new(
			Vector2(start.x + 1/2.0 * (end.x - start.x), start.y), 
			Vector2(end.x, start.y + 1/2.0 * (end.y - start.y)), enemies.filter(is_enemy_in_partition.bind(&"NE")))
		#bottom left
		children[2] = QuadTreeBucket.new(
			Vector2(start.x, start.y + 1/2.0 * (end.y - start.y)),
			Vector2(start.x + 1/2.0 * (end.x - start.x), end.y), enemies.filter(is_enemy_in_partition.bind(&"SW")))
		#bottom right
		children[3] = QuadTreeBucket.new(start + 1/2.0 * (end - start), end , enemies.filter(is_enemy_in_partition.bind(&"SE")))
	
	#this may technicailly lead to an enemy in two buckets? wgaf
	func is_enemy_in_bucket(enemy:Enemy) -> bool:
		if start.x <= enemy.position.x and enemy.position.x <= end.x:
			if start.y <= enemy.position.y and enemy.position.y <= end.y:
				return true
			else:
				return false
		else:
			return false
			
	func get_enemies_near_point(point:Vector2) -> Array[Enemy]:
		var enemies_near_point:Array[Enemy]
		if children.is_empty():
			return enemies
		else:
			enemies_near_point = children[partition_point_is_in(point)].get_enemies_near_point(point)
			if enemies_near_point.is_empty():
				return get_enemies_in_partitions()
			else:
				return enemies_near_point
			
	func get_enemies_in_partitions() -> Array[Enemy]:
		var enemies_in_partitions:Array[Enemy] = []
		for child:QuadTreeBucket in children:
			enemies_in_partitions.append_array(child.enemies)
		return enemies_in_partitions
		
			
	func partition_point_is_in(point:Vector2) -> int:
		if point.x < centre_x and point.y < centre_y:
			return 0
		elif centre_x <= point.x and point.y < centre_y:
			return 1
		elif point.x < centre_x and centre_y <= point.y:
			return 2
		elif centre_x <= point.x and centre_y <= point.y:
			return 3
		else:
			return 0
			
	func is_enemy_in_partition(enemy:Enemy, partition:StringName) -> bool:
		match partition:
			&"NW":
				if enemy.position.x < centre_x and enemy.position.y < centre_y:
					return true
			&"NE":
				if centre_x <= enemy.position.x and enemy.position.y < centre_y:
					return true
			&"SW":
				if enemy.position.x < centre_x and centre_y <= enemy.position.y:
					return true
			&"SE":
				if centre_x <= enemy.position.x and centre_y <= enemy.position.y:
					return true
			_:
				print("not a partition")
				return false
		return false
