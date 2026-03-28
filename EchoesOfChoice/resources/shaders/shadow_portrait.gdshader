shader_type canvas_item;

void fragment() {
	vec4 c = texture(TEXTURE, UV);
	float gray = dot(c.rgb, vec3(0.299, 0.587, 0.114));
	// 60% desaturation — keeps clothing color hints, ghostly but not full grayscale
	vec3 muted = mix(c.rgb, vec3(gray), 0.6);
	COLOR = vec4(muted * 0.85, c.a * 0.8);
}
