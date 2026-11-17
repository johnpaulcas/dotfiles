// cursor_glide.glsl  — "Elastic Glide"
// Typing and single-character moves snap instantly (no lag behind letters).
// Bigger jumps make the caret itself slide to its new spot with a
// critically damped spring: fast start, soft landing, no bounce.
//
// Colour follows Ghostty's cursor-color. Size follows Ghostty's cursor.
// Needs: custom-shader-animation = true  (so the slide animates)

// ---- tweakables ----------------------------------------------------------
const float STIFFNESS = 24.0;  // higher = faster slide (try 18–32)
const float MIN_JUMP  = 0.75;  // horizontal moves shorter than this × height snap
// --------------------------------------------------------------------------

float sdBox(vec2 p, vec2 c, vec2 b) {
    vec2 d = abs(p - c) - b;
    return length(max(d, 0.0)) + min(max(d.x, d.y), 0.0);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 res = iResolution.xy;
    vec4 base = texture(iChannel0, fragCoord / res);
    fragColor = base;

    vec4 cur  = iCurrentCursor;
    vec4 prev = iPreviousCursor;
    vec2 hs = cur.zw * 0.5;
    vec2 c  = vec2(cur.x + hs.x, cur.y - hs.y);
    vec2 pc = vec2(prev.x + prev.z * 0.5, prev.y - prev.w * 0.5);
    vec2 delta = c - pc;

    bool isJump = abs(delta.y) > 0.5 || abs(delta.x) > cur.w * MIN_JUMP;
    if (!isJump) return;

    // Critically damped spring: k goes 1 -> 0 with no overshoot.
    float t = max(iTime - iTimeCursorChange, 0.0);
    float k = (1.0 + STIFFNESS * t) * exp(-STIFFNESS * t);
    if (k < 0.005) return;

    vec3 col = base.rgb;

    // Hide Ghostty's own caret at the destination while we slide,
    // by painting the background sampled just left of it.
    float dReal = sdBox(fragCoord, c, hs);
    float insideReal = 1.0 - smoothstep(-0.5, 0.5, dReal);
    vec3 bg = texture(iChannel0, vec2(cur.x - 2.0, fragCoord.y) / res).rgb;
    col = mix(col, bg, insideReal);

    // Draw the sliding caret.
    vec2 pos = c - delta * k;
    float d = sdBox(fragCoord, pos, hs);
    float inside = 1.0 - smoothstep(-0.5, 0.5, d);
    col = mix(col, iCurrentCursorColor.rgb, inside);

    fragColor = vec4(col, base.a);
}
