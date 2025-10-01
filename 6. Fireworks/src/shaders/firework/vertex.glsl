uniform float uSize; 
uniform vec2 uResolution;
uniform float uProgress;

attribute float aSize;
attribute float aTimeMultipliers;

float remap(float value, float originMin, float originMax, float destinationMin, float destinationMax) {
    return destinationMin + (value - originMin) * (destinationMax - destinationMin) / (originMax - originMin);
}

void main() {
    float progress = uProgress * aTimeMultipliers;
    vec3 newPosition = position;

    // Exploding
    // float exploadingProgress = remap(uProgress, 0.0, 0.1, 0.0, 1.0);
    float exploadingProgress = remap(progress, 0.0, 0.1, 0.0, 1.0);
    exploadingProgress = clamp(exploadingProgress, 0.0, 1.0);
    // exploatingProgress = pow(exploatingProgress, 3.0);
    exploadingProgress = 1.0 - pow(1.0 - exploadingProgress, 3.0);
    newPosition *= exploadingProgress;

    // Falling 
    // float fallingProgress = remap(uProgress, 0.1, 1.0, 0.0, 1.0);
    float fallingProgress = remap(progress, 0.1, 1.0, 0.0, 1.0);
    fallingProgress = clamp(fallingProgress, 0.0, 1.0);
    fallingProgress = 1.0 - pow(1.0 - fallingProgress, 3.0);
    newPosition.y -= fallingProgress * 0.2;

    // Scaling
    // float sizeOpeningProgress = remap(uProgress, 0.0, 0.125, 0.0, 1.0);
    float sizeOpeningProgress = remap(progress, 0.0, 0.125, 0.0, 1.0);
    // float sizeClosingProgress = remap(uProgress, 0.125, 1.0, 1.0, 0.0);
    float sizeClosingProgress = remap(progress, 0.125, 1.0, 1.0, 0.0);
    float sizeProgress = min(sizeOpeningProgress, sizeClosingProgress);
    sizeProgress = clamp(sizeProgress, 0.0, 1.0);

    // Twinkling 
    // float twinklingProgress = remap(uProgress, 0.2, 0.8, 0.0, 1.0);
    float twinklingProgress = remap(progress, 0.2, 0.8, 0.0, 1.0);
    twinklingProgress = clamp(twinklingProgress, 0.0, 1.0);
    // float sizeTwinkling = sin(uProgress);
    // float sizeTwinkling = sin(uProgress) * 0.5 + 0.5;
    // float sizeTwinkling = sin(uProgress * 30.0) * 0.5 + 0.5;
    float sizeTwinkling = sin(progress * 30.0) * 0.5 + 0.5;
    sizeTwinkling = 1.0 - sizeTwinkling * twinklingProgress;

    // Final Position 
    // vec4 modelPosition = modelMatrix * vec4(position, 1.0);
    vec4 modelPosition = modelMatrix * vec4(newPosition, 1.0);
    vec4 viewPosition = viewMatrix * modelPosition;
    gl_Position = projectionMatrix * viewPosition; 

    // Final size
    // gl_PointSize = 20.0;
    // gl_PointSize = 50.0;
    // gl_PointSize = uSize * uResolution.y * aSize;
    // gl_PointSize = uSize * uResolution.y * aSize * sizeProgress;
    gl_PointSize = uSize * uResolution.y * aSize * sizeProgress * sizeTwinkling;
    gl_PointSize *= 1.0 / - viewPosition.z;

    if(gl_PointSize < 1.0)
        gl_Position = vec4(9999.9);
}