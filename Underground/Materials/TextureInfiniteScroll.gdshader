shader_type canvas_item;
render_mode world_vertex_coords;  // Defers the model-view transformation until after the vertex shader code runs

uniform sampler2D scrollTexture : filter_nearest, repeat_enable;
uniform vec2 texSize;
uniform float scale;
uniform vec2 position;

varying vec2 world_pos;  // Use vec3 instead for 3d shaders

void vertex() {
	// Called for every vertex the material is visible on.
	world_pos = (SCREEN_MATRIX * vec4(VERTEX, 0.0, 1.0)).xy;
}

void fragment() {
	vec2 uv = world_pos/(texSize/scale);
	COLOR = texture(scrollTexture,uv);//vec4(world_pos.x,world_pos.y,0,1);
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
