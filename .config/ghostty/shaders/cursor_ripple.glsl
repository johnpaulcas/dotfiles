// cursor_ripple.glsl  — "Landing Ripple"
// The caret never moves or lags. On bigger jumps, a faint rounded ring opens
// around the caret where it lands, and a ghost of the caret fades out where it left.
// Typing and single-character moves get no effect.
//
// Colour follows Ghostty's cursor-color. Size follows Ghostty's cursor.
// Needs: custom-shader-animation = true  (so the ripple can fade out)

// ---- tweakables (sizes are fractions of the cursor height) ---------------
const float RING_TIME    = 0.35;  // seconds for the ring to open and fade
const float RING_GROW    = 0.42;  // how far the ring opens
const float RING_WIDTH   = 0.07;  // ring line thickness
const float RING_OPACITY = 0.45;
const float GHOST_TIME   = 0.22;  // seconds for the ghost at the old spot to fade
const float GHOST_OPACITY = 0.40;
const float MIN_JUMP     = 0.75;  // horizontal moves shorter than this × height are "typing"
// --------------------------------------------------------------------------

float sdRoundBox(vec2 p, vec2 c, vec2 b, float r) {
    vec2 q = abs(p - c) - b + r;
    return length(max(q, 0.0)) + min(max(q.x, q.y), 0.0) - r;
}

float sdBox(vec2 p, vec2 c, vec2 b) {
    vec2 d = abs(p - c) - b;
    return length(max(d, 0.0)) + min(max(d.x, d.y), 0.0);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec4 base = texture(iChannel0, fragCoord / iResolution.xy);
    fragColor = base;

    float t = iTime - iTimeCursorChange;
    if (t > max(RING_TIME, GHOST_TIME)) return;

    // Pixel space; xy = top-left corner, zw = size, y grows upward.
    vec4 cur  = iCurrentCursor;
    vec4 prev = iPreviousCursor;
    vec2 hs = cur.zw * 0.5;
    vec2 c  = vec2(cur.x + hs.x, cur.y - hs.y);
    vec2 pc = vec2(prev.x + prev.z * 0.5, prev.y - prev.w * 0.5);
    vec2 delta = c - pc;
    float h = cur.w;

    bool isJump = abs(delta.y) > 0.5 || abs(delta.x) > h * MIN_JUMP;
    if (!isJump) return;

    vec3 col = base.rgb;
    vec3 tint = iCurrentCursorColor.rgb;
    float aa = 1.0;

    // Ghost at the old spot.
    float ge = clamp(t / GHOST_TIME, 0.0, 1.0);
    float dg = sdBox(fragCoord, pc, prev.zw * 0.5);
    float ghost = (1.0 - smoothstep(-aa, aa, dg)) * GHOST_OPACITY * (1.0 - ge);
    col = mix(col, tint, ghost);

    // Ring opening around the landing spot.
    float e = clamp(t / RING_TIME, 0.0, 1.0);
    float ease = 1.0 - pow(1.0 - e, 3.0);
    float grow = h * (0.08 + RING_GROW * ease);
    float radius = h * 0.18 + grow * 0.4;
    float dr = sdRoundBox(fragCoord, c, hs + grow, radius);
    float ring = 1.0 - smoothstep(h * RING_WIDTH * 0.5 - aa, h * RING_WIDTH * 0.5 + aa, abs(dr));
    col = mix(col, tint, ring * RING_OPACITY * (1.0 - e));

    fragColor = vec4(col, base.a);
}
