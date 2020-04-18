extends StaticBody2D


func draw(points):
	var line = $Line
	$CollisionShape.shape = ConcavePolygonShape2D.new()
	var shape = $CollisionShape.shape
	
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
