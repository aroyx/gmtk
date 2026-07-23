shader_type canvas_item;

// stolen directly from my code :) https://www.shadertoy.com/view/NXXGz4

uniform vec4 color : source_color;
uniform vec4 bg_color : source_color;

uniform float val: hint_range(0.0, 1.0, 0.01);

void fragment() {
	vec2 uv = UV - vec2(0.5);
	vec2 gridc = fract(uv * 7.0 + vec2(1));
	float dist = length(uv);
	float a = distance(gridc, vec2(.5)); 
    float r = 0.6;
	float b = smoothstep(r - .4, r - .2, dist);
    float c = smoothstep(r - .0, r - .5, dist);
	
	// the arc    
    float angle = atan(uv.x, -uv.y);
    if (angle < 0.0) {
        angle += 6.28318530718;
    }
    angle /= 6.28318530718;
    
	float v = val * 1.1;
    float arc = 1.0 - smoothstep(v - 0.1, v, angle);
	
	float k = clamp(c * b, 0.1, 0.5);
	float bg = smoothstep(0.11, 0.15, k);
	 
	float d = clamp(k * arc, 0.0, 0.9) - 0.2;
    d *= 1.7;
	float e = 1. - smoothstep(d, d+0.08, a);
    
	float alpha =  max(bg * bg_color.a, e);
	vec3 colo = mix(bg_color.rgb, color.rgb, e);
	
    COLOR = vec4(colo * alpha, alpha);
}
