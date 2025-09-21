varying vec3 vPosition;

uniform float uTime;

void main() {
    // Stripes
    // float stripes = vPosition.y;
    // float stripes = mod(vPosition.y * 20.0, 1.0);
    float stripes = mod((vPosition.y - uTime * 0.02) * 20.0, 1.0);
    stripes = pow(stripes, 3.0);

    // Final color 
    // gl_FragColor = vec4(1.0, 1.0, 0.0, 1.0);
    // gl_FragColor = vec4(vPosition, 1.0);
    // gl_FragColor = vec4(vec3(stripes), 1.0);
    gl_FragColor = vec4(vec3(1.0), stripes);

    #include <tonemapping_fragment>
    #include <colorspace_fragment>
} 