shader_type canvas_item;
uniform sampler2D noise;
uniform float threshold : hint_range(0.0, 1.0, 0.05);

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 value = texture(noise, UV);
	if (value.r < threshold) {
		COLOR.a = 0.0;
	} else if (value.r < threshold + 0.03) {
		COLOR = vec4(0.0, 0.0, 0.0, 1.0);
		COLOR.r += 0.5;
		COLOR.r = texture(noise, UV + 0.3).r * 1.6;
		if (COLOR.r > 0.8) {
			COLOR.g = texture(noise, UV + 0.3).g * 0.8;
		}
	} else if (value.r < threshold + 0.08) {
		COLOR.rgb = vec3(0.0, 0.0, 0.0);
	}
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
