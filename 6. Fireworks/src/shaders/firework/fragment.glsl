uniform sampler2D uTexture;
uniform vec3 uColor;

void main() {
    // vec4 textureColor = texture(uTexture, gl_PointCoord);
    float textureAlpha = texture(uTexture, gl_PointCoord).r;

    // Final Color 
    // gl_FragColor = vec4(1.0, 0.0, 1.0, 1.0);
    // gl_FragColor = textureColor;
    // gl_FragColor = vec4(vec3(1.0), textureAlpha);
    gl_FragColor = vec4(uColor, textureAlpha);

    #include <tonemapping_fragment>
    #include <colorspace_fragment>
}