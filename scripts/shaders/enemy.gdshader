shader_type canvas_item;
instance uniform bool harmed = false;
instance uniform float death_fade_threshold : hint_range(0.0, 1.0, 0.1);
uniform sampler2D death_noise;
void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	if (harmed){
	COLOR.rgb = vec3(1.0, 0.0, 0.0);
	}
	if (death_fade_threshold > 0.05) {
		float fade_val = texture(death_noise, UV).r;
		if (fade_val < death_fade_threshold - 0.1) {
			COLOR.a = 0.0;
		} else if (fade_val < death_fade_threshold) {
			COLOR.rgb = vec3(0.3, 0.3, 0.3);
		}
	}
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
