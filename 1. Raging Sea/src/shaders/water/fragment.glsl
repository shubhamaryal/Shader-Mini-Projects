uniform vec3 uDepthColor;
uniform vec3 uSurfaceColor;
uniform float uColorOffset;
uniform float uColorMultiplier;

varying float vElevation;

void main() { 
    // vec3 color = mix(uDepthColor, uSurfaceColor, vElevation * 2.0 + 0.5); 
    float mixStrength = (vElevation + uColorOffset) * uColorMultiplier;
    vec3 color = mix(uDepthColor, uSurfaceColor, mixStrength );

    // gl_FragColor = vec4(0.5, 0.8, 1.0, 1.0);
    gl_FragColor = vec4(color, 1.0);
}