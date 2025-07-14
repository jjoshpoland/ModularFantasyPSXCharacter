shader_type spatial;
render_mode depth_prepass_alpha, shadows_disabled;

uniform sampler2D albedo : source_color, filter_nearest_mipmap_anisotropic, repeat_disable;
instance uniform vec2 offset;

void fragment() {

	ALBEDO = texture(albedo, UV + offset).rgb;
	ALPHA = texture(albedo, UV + offset).a;
	ALPHA_SCISSOR_THRESHOLD = 0.01;
}
