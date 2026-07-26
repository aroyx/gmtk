shader_type canvas_item;

uniform vec4 new_color: source_color = vec4(1.0, 0.0, 0.0, 1.0);
const vec3 pink = vec3(0.984, 0.549, 0.675);
const float diff = 0.20;

void fragment() {
    vec4 curr_color = texture(TEXTURE, UV);
    
    if (distance(curr_color.rgb, pink) < diff) {
        float intensity = length(curr_color.rgb) / length(pink);
        COLOR = vec4(new_color.rgb * intensity, curr_color.a);
    } else {
        COLOR = curr_color;
    }
}