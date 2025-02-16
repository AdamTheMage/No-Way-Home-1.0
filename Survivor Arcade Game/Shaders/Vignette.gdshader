shader_type canvas_item;

uniform float Vignette_intensity = 0.4 ;
uniform float Vignette_opacity : hint_range (0.0, 1.0) = 0.5;
uniform vec4 Vignette_rgb : source_color = vec4(0.0, 0.0, 0.0, 1);

uniform sampler2D screen_vec : hint_screen_texture;

float Vignette(vec2 uv) {
	uv *= 1.0 - uv.xy;
	float Vignette = uv.x * uv.y * 15.0 ;
	return pow (Vignette, Vignette_intensity * Vignette_opacity);
	}
	
void fragment() {
	vec4 color = texture(screen_vec, SCREEN_UV);
	vec4 text = texture(TEXTURE, UV);
	
	text.rgba *= (Vignette_rgb.rgba);
	text.rgba *= (1.0 - Vignette(UV));
	
	COLOR = vec4((text.rgb) * color.rgb, text.a);
}