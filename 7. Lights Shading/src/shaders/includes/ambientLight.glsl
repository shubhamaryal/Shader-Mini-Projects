vec3 ambientLight(vec3 lightColor, float lightIntensity) {
    // return vec3(0.0, 0.0, 0.0);
    return lightColor * lightIntensity;
}