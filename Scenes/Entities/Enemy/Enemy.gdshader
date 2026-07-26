shader_type canvas_item;

uniform vec4 new_color: source_color = vec4(1.0, 0.0, 0.0, 1.0);
const vec3 green = vec3(0.04, 0.32, 0.00);
const float diff = 0.25; 

void fragment() {
    vec4 curr_color = texture(TEXTURE, UV);
    
    if (distance(curr_color.rgb, green) < diff) {
        float intensity = length(curr_color.rgb) / length(green);
        COLOR = vec4(new_color.rgb * intensity, curr_color.a);
    } else {
        COLOR = curr_color;
    }
}