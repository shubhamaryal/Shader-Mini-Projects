varying vec3 vPosition;
varying vec3 vNormal;

uniform float uTime;
uniform vec3 uColor;

void main() {
    // Normal 
    vec3 normal = normalize(vNormal);
    if(!gl_FrontFacing)
        normal *= -1.0;

    // Stripes
    // float stripes = vPosition.y;
    // float stripes = mod(vPosition.y * 20.0, 1.0);
    float stripes = mod((vPosition.y - uTime * 0.02) * 20.0, 1.0);
    stripes = pow(stripes, 3.0);

    // Fersnel 
    vec3 viewDirection = normalize(vPosition - cameraPosition); 
    // float fresnel = dot(viewDirection, vNormal);
    // float fresnel = dot(viewDirection, vNormal) + 1.0;
    float fresnel = dot(viewDirection, normal) + 1.0;
    fresnel = pow(fresnel, 2.0);

    // Fall off
    float falloff = smoothstep(0.8, 0.0, fresnel);

    // Holographic 
    float holographic = stripes * fresnel;
    holographic += fresnel * 1.25;
    holographic *= falloff;

    // Final color 
    // gl_FragColor = vec4(1.0, 1.0, 0.0, 1.0);
    // gl_FragColor = vec4(vPosition, 1.0);
    // gl_FragColor = vec4(vec3(stripes), 1.0);
    // gl_FragColor = vec4(vec3(1.0), stripes);
    // gl_FragColor = vec4(vNormal, 1.0);
    // gl_FragColor = vec4(vec3(1.0), fresnel);
    // gl_FragColor = vec4(vec3(1.0), holographic);
    gl_FragColor = vec4(uColor, holographic);

    #include <tonemapping_fragment>
    #include <colorspace_fragment>
} 