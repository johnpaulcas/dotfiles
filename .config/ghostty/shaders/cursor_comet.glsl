// cursor_comet.glsl
// Calm cursor: the caret itself never animates (no lag while typing).
// On bigger jumps, a faint tapered tail in the cursor colour sweeps from the
// old spot and quickly retracts into the caret. Small moves (typing) get nothing.
//
// Colour follows Ghostty's cursor-color. Size follows Ghostty's cursor.
// Needs: custom-shader-animation = true  (so the tail can fade out)

// ---- tweakables ----------------------------------------------------------
const float DURATION      = 0.15;  // seconds for the tail to retract
const float OPACITY       = 0.35;  // tail strength at the caret end
const float MIN_JUMP      = 1.1;   // moves shorter than this × cursor height: no tail
// --------------------------------------------------------------------------

float seg(in vec2 p, in vec2 a, in vec2 b, inout float s, float d) {
    vec2 e = b - a;
    vec2 w = p - a;
    vec2 proj = a + e * clamp(dot(w, e) / dot(e, e), 0.0, 1.0);
    d = min(d, dot(p - proj, p - proj));
    float c0 = step(0.0, p.y - a.y);
    float c1 = 1.0 - step(0.0, p.y - b.y);
    float c2 = 1.0 - step(0.0, e.x * w.y - e.y * w.x);
    float allCond = c0 * c1 * c2;
    float noneCond = (1.0 - c0) * (1.0 - c1) * (1.0 - c2);
    s *= mix(1.0, -1.0, step(0.5, allCond + noneCond));
    return d;
}

// Signed distance to a quad (Inigo Quilez), same as cursor_smear.glsl.
float sdQuad(vec2 p, vec2 v0, vec2 v1, vec2 v2, vec2 v3) {
    float s = 1.0;
    float d = dot(p - v0, p - v0);
    d = seg(p, v0, v3, s, d);
    d = seg(p, v1, v0, s, d);
    d = seg(p, v2, v1, s, d);
    d = seg(p, v3, v2, s, d);
    return s * sqrt(d);
}

float startVertexFactor(vec2 a, vec2 b) {
    float c1 = step(b.x, a.x) * step(a.y, b.y);
    float c2 = step(a.x, b.x) * step(b.y, a.y);
    return 1.0 - max(c1, c2);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec4 base = texture(iChannel0, fragCoord / iResolution.xy);
    fragColor = base;

    float t = iTime - iTimeCursorChange;
    float progress = clamp(t / DURATION, 0.0, 1.0);
    if (progress >= 1.0) return;

    // Pixel space; xy = top-left corner, zw = size, y grows upward.
    vec4 cur  = iCurrentCursor;
    vec4 prev = iPreviousCursor;
    vec2 head = vec2(cur.x + cur.z * 0.5, cur.y - cur.w * 0.5);
    vec2 tail = vec2(prev.x + prev.z * 0.5, prev.y - prev.w * 0.5);
    vec2 delta = head - tail;

    // Skip small moves (normal typing / single-char moves).
    if (abs(delta.y) < 1.0 && abs(delta.x) < cur.w * MIN_JUMP) return;

    // Tail end retracts toward the caret with an ease-out.
    float e = 1.0 - pow(1.0 - progress, 3.0);
    vec2 tailNow = mix(tail, head, e);
    vec2 tailTopLeft = vec2(prev.x, prev.y) + (tailNow - tail);

    // Swept quad between the retracting tail and the caret.
    float vf = startVertexFactor(cur.xy, tailTopLeft);
    float ivf = 1.0 - vf;
    vec2 v0 = vec2(cur.x + cur.z * vf,  cur.y - cur.w);
    vec2 v1 = vec2(cur.x + cur.z * ivf, cur.y);
    vec2 v2 = vec2(tailTopLeft.x + cur.z * ivf, tailTopLeft.y);
    vec2 v3 = vec2(tailTopLeft.x + cur.z * vf,  tailTopLeft.y - cur.w);
    float d = sdQuad(fragCoord, v0, v1, v2, v3);
    float cover = 1.0 - smoothstep(-0.75, 0.75, d);

    // Taper: transparent at the tail, strongest at the caret.
    vec2 axis = head - tailNow;
    float len2 = max(dot(axis, axis), 1.0);
    float along = clamp(dot(fragCoord - tailNow, axis) / len2, 0.0, 1.0);
    float taper = along * along;

    float alpha = cover * taper * OPACITY * (1.0 - progress);
    fragColor = vec4(mix(base.rgb, iCurrentCursorColor.rgb, alpha), base.a);
}
