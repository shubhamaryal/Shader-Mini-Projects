uniform vec3 uColor;

varying vec3 vNormal;

// vec3 ambientLight(vec3 lightColor, float lightIntensity) {
//     // return vec3(0.0, 0.0, 0.0);
//     return lightColor * lightIntensity;
// }
#include "../includes/ambientLight.glsl"

vec3 directionalLight(vec3 lightColor, float lightIntensity, vec3 normal, vec3 lightPosition) {
    vec3 lightDirection = normalize(lightPosition);
    return lightColor * lightIntensity;
}

void main() {
    vec3 color = uColor;

    // Light 
    vec3 light = vec3(0.0);
    // light += ambientLight();
    // light += ambientLight(vec3(1.0), 0.2);
    // light += ambientLight(vec3(1.0, 0.0, 0.0), 0.2);
    // light += ambientLight(
    //     vec3(1.0),
    //     0.03
    // );
    // light += directionalLight(
    //     vec3(0.1, 0.1, 1.0),
    //     1.0
    // );
    light += directionalLight(
        vec3(0.1, 0.1, 1.0),
        1.0,
        vNormal,
        vec3(0.0, 0.0, 3.0)
    );
    color *= light;

    // Final color
    gl_FragColor = vec4(color, 1.0);
    #include <tonemapping_fragment>
    #include <colorspace_fragment>
}