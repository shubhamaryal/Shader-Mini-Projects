uniform vec3 uColor;

varying vec3 vNormal;
varying vec3 vPosition;

// vec3 ambientLight(vec3 lightColor, float lightIntensity) {
//     // return vec3(0.0, 0.0, 0.0);
//     return lightColor * lightIntensity;
// }
#include "../includes/ambientLight.glsl"

// vec3 directionalLight(vec3 lightColor, float lightIntensity, vec3 normal, vec3 lightPosition, vec3 viewDirection, float specularPower) {
//     vec3 lightDirection = normalize(lightPosition);
//     // vec3 lightReflection = reflect(lightDirection, normal);
//     vec3 lightReflection = reflect(- lightDirection, normal);

//     // Shading 
//     float shading = dot(normal, lightDirection);
//     shading = max(0.0, shading);

//     // Specular 
//     // float specular = dot(lightReflection, lightDirection);
//     float specular = - dot(lightReflection, viewDirection);
//     specular = max(0.0, specular);
//     // specular = pow(specular, 20.0);
//     // specular = pow(specular, 19.0);
//     // specular = pow(specular, 20.0);
//     specular = pow(specular, specularPower);

//     // return lightColor * lightIntensity;
//     // return vec3(shading);
//     // return lightColor * lightIntensity * shading;
//     // return vec3(specular);
//     // return lightColor * lightIntensity * shading + specular;
//     // return lightColor * lightIntensity * shading + lightColor * specular;
//     // return lightColor * lightIntensity * shading + lightColor * lightIntensity * specular;
//     return lightColor * lightIntensity * (shading + specular);
// }
#include "../includes/directionalLight.glsl"

// vec3 pointLight(vec3 lightColor, float lightIntensity, vec3 normal, vec3 lightPosition, vec3 viewDirection, float specularPower, vec3 position, float lightDecay) {
//     vec3 lightDelta = lightPosition - position;
//     float lightDistance = length(lightDelta);
//     // vec3 lightDirection = normalize(lightPosition);
//     vec3 lightDirection = normalize(lightDelta);
//     vec3 lightReflection = reflect(- lightDirection, normal);

//     // Shading 
//     float shading = dot(normal, lightDirection);
//     shading = max(0.0, shading);

//     // Specular 
//     float specular = - dot(lightReflection, viewDirection);
//     specular = max(0.0, specular);
//     specular = pow(specular, specularPower);

//     // Decay 
//     // float decay = 1.0 - lightDistance * 0.3;
//     float decay = 1.0 - lightDistance * lightDecay;
//     decay = max(0.0, decay);

//     // return lightColor * lightIntensity * (shading + specular);
//     // return vec3(decay);
//     return lightColor * lightIntensity * decay * (shading + specular);
// }
#include "../includes/pointLight.glsl"

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
    // light += directionalLight(
    //     vec3(0.1, 0.1, 1.0),
    //     1.0,
    //     normal,
    //     vec3(0.0, 0.0, 3.0),
    //     viewDirection
    // );
    light += directionalLight(
        vec3(0.1, 0.1, 1.0),
        1.0,
        normal,
        vec3(0.0, 0.0, 3.0),
        viewDirection,
        20.0
    );
    // light += directionalLight(
    //     vec3(0.1, 0.1, 1.0),
    //     5.0,
    //     normal,
    //     vec3(0.0, 0.0, 3.0),
    //     viewDirection,
    //     20.0
    // );

    // light += pointLight(
    //     vec3(1.0, 0.1, 0.1),
    //     1.0,
    //     normal,
    //     vec3(0.0, 2.5, 0.0),
    //     viewDirection,
    //     20.0
    // );
    // light += pointLight(
    //     vec3(1.0, 0.1, 0.1),
    //     1.0,
    //     normal,
    //     vec3(0.0, 2.5, 0.0),
    //     viewDirection,
    //     20.0,
    //     vPosition
    // );
    light += pointLight(
        vec3(1.0, 0.1, 0.1),
        1.0,
        normal,
        vec3(0.0, 2.5, 0.0),
        viewDirection,
        20.0,
        vPosition,
        0.25
    );
    light += pointLight(
        vec3(0.1, 1.0, 0.5),
        1.0,
        normal,
        vec3(2.0, 2.0, 2.0),
        viewDirection,
        20.0,
        vPosition,
        0.2
    );
    color *= light;

    // Final color
    gl_FragColor = vec4(color, 1.0);
    #include <tonemapping_fragment>
    #include <colorspace_fragment>
}