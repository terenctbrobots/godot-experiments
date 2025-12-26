shader_type canvas_item;

uniform vec2 scroll;
uniform float speed = 1.0;
uniform float wave_height = 16.0;

void fragment() {
    COLOR = texture(
		TEXTURE, 
		vec2(
			UV.x - TIME / scroll.x + sin(round(UV.y * 211.0 / 2.0) + TIME * speed) / 211.0 * wave_height,
			UV.y - TIME / scroll.y
		)
	);
}