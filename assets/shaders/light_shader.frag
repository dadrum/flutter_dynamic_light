#include <flutter/runtime_effect.glsl>

precision mediump float;

out vec4 fragColor;

uniform float uSizeX;
uniform float uSizeY;
uniform float uTextureSizeX;
uniform float uTextureSizeY;
uniform float uShadowXOffset;
uniform sampler2D image;

void main() {
    vec2 iResolution = vec2(uSizeX, uSizeY);
    vec2 iTextureSize = vec2(uTextureSizeX, uTextureSizeY);
    vec2 fragCoord = FlutterFragCoord();
    vec2 uv = fragCoord / iResolution.xy;

    // Получаем цвет текущего пикселя
    vec4 color = texture(image, uv);

    // Преобразуем координаты текстуры в пиксельные
    vec2 pixelCoord = uv * iTextureSize;

    vec2 topuv1 = vec2(fragCoord.x - uShadowXOffset * 0.1, fragCoord.y - 2) / iResolution.xy;
    vec4 topcolor1 = texture(image, topuv1);
    vec2 topuv2 = vec2(fragCoord.x - uShadowXOffset * 0.1, fragCoord.y - 5) / iResolution.xy;
    vec4 topcolor2 = texture(image, topuv2);

    vec2 bottomuv1 = vec2(fragCoord.x - uShadowXOffset * 0.15, fragCoord.y - 2.5) / iResolution.xy;
    vec4 bottomcolor1 = texture(image, bottomuv1);
    vec2 bottomuv2 = vec2(fragCoord.x - uShadowXOffset * 0.3, fragCoord.y - 5) / iResolution.xy;
    vec4 bottomcolor2 = texture(image, bottomuv2);

    vec2 bottomuv3 = vec2(fragCoord.x + uShadowXOffset * 0.3, fragCoord.y + 5) / iResolution.xy;
    vec4 bottomcolor3 = texture(image, bottomuv3);

    //    fragColor = vec4(finalColor, color.a);
    if (color.a == 0 && topcolor1.a > 0) {
        color = vec4(color.rgb, 0.3);
    }
    if (color.a == 0 && topcolor2.a > 0) {
        color = vec4(color.rgb, 0.3);
    }

    if (color.a > 0 && bottomcolor1.a == 0) {
        color = color * 1.3;
    }

    if (color.a > 0 && bottomcolor2.a == 0) {
        color = color * 1.3;
    }

    if (color.a > 0 && bottomcolor3.a == 0) {
        color = color * 0.8;
    }

    float brightness1 = dot(color.rgb, vec3(0.2126, 0.7152, 0.0722)); // Яркость color1
    float brightness2 = dot(topcolor1.rgb, vec3(0.2126, 0.7152, 0.0722)); // Яркость color2

    if (brightness1 > brightness2 * 1.2 ) {
        color = color * 1.2;
    }

    fragColor = color;
}

