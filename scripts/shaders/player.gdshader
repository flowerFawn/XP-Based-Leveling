shader_type canvas_item;
uniform bool harmed = false;
void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	if (harmed){
	COLOR.rgb = vec3(1.0, 0.0, 0.0);
	}
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
