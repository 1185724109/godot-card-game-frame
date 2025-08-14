extends Control
var is_mouse_inside := false
func _process(delta: float) -> void:
	var mouse_pos := get_global_mouse_position()
	var rect := get_global_rect()
	var currently_inside := rect.has_point(mouse_pos)
	if currently_inside != is_mouse_inside:
		is_mouse_inside = currently_inside
		if is_mouse_inside:
			emit_signal("mouse_entered")
		else:
			emit_signal("mouse_exited")
