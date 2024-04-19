//
// Conditional color or additive shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
	vec4 texColor = texture2D( gm_BaseTexture, v_vTexcoord );
	//in shaders, color integesr are turned into floats
	if ( texColor.r < 0.5 && texColor.g < 0.5 && texColor.b < 0.5 ) {
		vec4 tempColor = v_vColour + texColor;
		gl_FragColor = vec4(tempColor.r, tempColor.g, tempColor.b, texColor.a);
	} else {
		gl_FragColor = v_vColour * texColor;
	}
}
