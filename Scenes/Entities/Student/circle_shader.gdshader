shader_type canvas_item;

uniform vec4 start_color : source_color = vec4(0.0, 1.0, 0.0, 1.0); // Green
uniform vec4 end_color   : source_color = vec4(1.0, 0.0, 0.0, 1.0); // Red

// 0.0 = green, 1.0 = red
uniform float progress : hint_range(0.0, 1.0);

void fragment() {
    vec4 tex = texture(TEXTURE, UV);

    vec4 tint = mix(start_color, end_color, progress);

    COLOR = tex * tint;
}