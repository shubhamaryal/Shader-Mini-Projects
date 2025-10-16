uniform vec3 uColor;

varying vec3 vNormal;
varying vec3 vPosition;

// vec3 ambientLight(vec3 lightColor, float lightIntensity) {
//     // return vec3(0.0, 0.0, 0.0);
//     return lightColor * lightIntensity;
// }
#include "../includes/ambientLight.glsl"

vec3 directionalLight(vec3 lightColor, float lightIntensity, vec3 normal, vec3 lightPosition, vec3 viewDirection) {
    vec3 lightDirection = normalize(lightPosition);
    // vec3 lightReflection = reflect(lightDirection, normal);
    vec3 lightReflection = reflect(- lightDirection, normal);

    // Shading 
    float shading = dot(normal, lightDirection);
    shading = max(0.0, shading);

    // Specular 
    // float specular = dot(lightReflection, lightDirection);
    float specular = - dot(lightReflection, lightDirection);
    specular = max(0.0, specular);
    specular = pow(specular, 20.0);
    // specular = pow(specular, 19.0);

    // return lightColor * lightIntensity;
    // return vec3(shading);
    // return lightColor * lightIntensity * shading;
    return vec3(specular);
}

void main() {
    vec3 normal = normalize(vNormal);
    // vec3 viewDirection = vPosition - cameraPosition;
    vec3 viewDirection = normalize(vPosition - cameraPosition);
    vec3 color = uColor;

    // Light 
    vec3 light = vec3(0.0);
    // light += ambientLight();
    // light += ambientLight(vec3(1.0), 0.2);
    // light += ambientLight(vec3(1.0, 0.0, 0.0), 0.2);
    light += ambientLight(
        vec3(1.0),
        0.03
    );
    // light += directionalLight(
    //     vec3(0.1, 0.1, 1.0),
    //     1.0
    // );
    // light += directionalLight(
    //     vec3(0.1, 0.1, 1.0),
    //     1.0,
    //     vNormal,
    //     vec3(0.0, 0.0, 3.0)
    // );
    // light += directionalLight(
    //     vec3(0.1, 0.1, 1.0),
    //     1.0,
    //     vNormal,
    //     vec3(0.0, 0.0, 3.0),
    //     viewDirection
    // );
    light += directionalLight(
        vec3(0.1, 0.1, 1.0),
        1.0,
        normal,
        vec3(0.0, 0.0, 3.0),
        viewDirection
    );
    color *= light;

    // Final color
    gl_FragColor = vec4(color, 1.0);
    #include <tonemapping_fragment>
    #include <colorspace_fragment>
}