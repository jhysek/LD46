extends StaticBody2D

var shape
var line

func draw(points):
	line = $Line
	$CollisionShape.shape = ConcavePolygonShape2D.new()
	shape = $CollisionShape.shape
	
	line.clear_points()
	
	var segments = []
	for point in points:
		line.add_point(point)
		segments.append(point)

	var connected_segments = []
	var prev_point = null
	var prev_tuple_end = null
		
	for segment in segments:
		if prev_point == null and prev_tuple_end == null:
			prev_point = segment
		elif prev_tuple_end == null:
			connected_segments.append(prev_point)
			connected_segments.append(segment)
			prev_point = null
			prev_tuple_end = segment
		else:
			# Connecting segment
			connected_segments.append(prev_tuple_end)
			connected_segments.append(segment) 
			prev_tuple_end = null
			prev_point = segment 
	
	shape.segments = PoolVector2Array(connected_segments)
	$Timer.start()
	
	
func remove_first_segment():
	if shape.segments.size() > 0:
		line.remove_point(0)
		var segs = shape.segments
		
		segs.remove(0)
		segs.remove(0)
		shape.segments = segs
		
		$Timer.start()
	else: 
		queue_free()
		
	
func _on_Timer_timeout():
	$Timer.wait_time = 0.1
	remove_first_segment()
