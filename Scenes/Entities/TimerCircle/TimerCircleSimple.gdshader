shader_type canvas_item;

uniform vec4 color : source_color = vec4(0.0, 1.0, 0.0, 1.0); 
uniform vec4 bg_color : source_color = vec4(0.1, 0.1, 0.1, 0.5);
uniform float val: hint_range(0.0, 1.0, 0.01) = 0.5;

uniform float radius: hint_range(0.0, 0.5, 0.01) = 0.45;
uniform float inner_radius: hint_range(0.0, 0.5, 0.01) = 0.35;

void fragment() {
	if (val == 0.0) {
		COLOR = vec4(0);
		discard;
	}

    vec2 uv = UV - vec2(0.5);

    float angle = atan(uv.x, -uv.y);
    if (angle < 0.0) {
        angle += 6.28318530718;
    }
    angle /= 6.28318530718;
    
    float arc = 1.0 - smoothstep(val - 0.005, val + 0.005, angle);
    
    float d = length(uv);
    float circle = 1.0 - smoothstep(radius - 0.005, radius + 0.005, d);
    float hole = smoothstep(inner_radius - 0.005, inner_radius + 0.005, d);
    float shape_mask = circle * hole;
    
    vec4 mixed_color = mix(bg_color, color, arc);
    
    COLOR = vec4(mixed_color.rgb, mixed_color.a * shape_mask);
}