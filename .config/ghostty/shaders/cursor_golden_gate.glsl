// cursor_golden_gate.glsl
// A take on the macOS 27 (Golden Gate) Spotlight caret:
// solid white bar with a soft champagne-gold glow.
//  - idle: soft fade blink (like macOS)
//  - typing: stays solid, and glides smoothly to its new spot
//
// The bar keeps Ghostty's own cursor size (cursor-style + adjust-cursor-thickness).
// Needs: custom-shader-animation = true  (so the blink runs while focused)

// ---- tweakables ----------------------------------------------------------
const vec3  CORE_COLOR    = vec3(1.0);                  // solid white bar
const vec3  GLOW_COLOR    = vec3(0.902, 0.784, 0.541);  // #E6C88A champagne gold
const float GLOW_RADIUS   = 4.5;   // px, tight glow
const float SOFT_RADIUS   = 11.0;  // px, faint outer glow
const float GLOW_STRENGTH = 0.30;  // tight glow strength
const float SOFT_STRENGTH = 0.08;  // outer glow strength
const float GLIDE_TIME    = 0.08;  // seconds to slide to the new position (jumps only)
const float GLIDE_MIN_JUMP = 1.1;  // moves shorter than this × cursor height snap instantly
const float SOLID_AFTER_TYPING = 0.6; // stays solid this long after a keystroke
const float BLINK_PERIOD  = 1.06;  // seconds per blink cycle (macOS-like)
const float BLINK_FADE    = 0.15;  // fraction of the cycle spent fading in/out
// --------------------------------------------------------------------------

float sdBox(vec2 p, vec2 c, vec2 halfSize) {
    vec2 d = abs(p - c) - halfSize;
    return length(max(d, 0.0)) + min(max(d.x, d.y), 0.0);
}

float easeOutCubic(float x) {
    return 1.0 - pow(1.0 - x, 3.0);
}

// 1 = visible, 0 = hidden. Solid while typing, then on/off with soft fades.
float blinkAmount(float t) {
    if (t < SOLID_AFTER_TYPING) return 1.0;
    float c = fract((t - SOLID_AFTER_TYPING) / BLINK_PERIOD);
    // first half on, second half off, with soft edges
    float fadeOut = 1.0 - smoothstep(0.5 - BLINK_FADE, 0.5, c);
    float fadeIn  = smoothstep(1.0 - BLINK_FADE, 1.0, c);
    return max(fadeOut, fadeIn);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 res = iResolution.xy;
    vec4 base = texture(iChannel0, fragCoord / res);

    // Cursor rects in pixels: xy = top-left, zw = size (y grows upward).
    vec4 cur  = iCurrentCursor;
    vec4 prev = iPreviousCursor;
    vec2 halfSize   = cur.zw * 0.5;
    vec2 realCenter = vec2(cur.x + halfSize.x, cur.y - halfSize.y);
    vec2 prevCenter = vec2(prev.x + prev.z * 0.5, prev.y - prev.w * 0.5);

    float t = max(iTime - iTimeCursorChange, 0.0);

    // Smooth glide from the previous position to the real one, but only for
    // bigger jumps. Normal typing (a cell or two on the same line) snaps
    // instantly so the caret never lags behind the letter just typed.
    // Cell width isn't exposed, so use the cursor height as a proxy (~2 cells).
    vec2 delta = realCenter - prevCenter;
    float isTyping = step(abs(delta.y), 1.0) * step(abs(delta.x), cur.w * GLIDE_MIN_JUMP);
    float g = easeOutCubic(clamp(t / GLIDE_TIME, 0.0, 1.0));
    g = mix(g, 1.0, isTyping);
    vec2 center = mix(prevCenter, realCenter, g);

    float vis = blinkAmount(t);

    vec3 col = base.rgb;

    // Hide Ghostty's own cursor at the real spot (we draw our own),
    // by painting the background sampled just left of it.
    float dReal = sdBox(fragCoord, realCenter, halfSize);
    float insideReal = 1.0 - smoothstep(-0.5, 0.5, dReal);
    vec3 bgReal = texture(iChannel0, vec2(cur.x - 2.0, fragCoord.y) / res).rgb;
    col = mix(col, bgReal, insideReal);

    // Draw the bar at its animated position.
    float d = sdBox(fragCoord, center, halfSize);
    float inside = 1.0 - smoothstep(-0.5, 0.5, d);
    col = mix(col, CORE_COLOR, inside * vis);

    // Gold glow hugging the bar, a little stronger toward the bottom.
    float yN = clamp((fragCoord.y - (center.y - halfSize.y)) / max(cur.w, 1.0), 0.0, 1.0);
    float lowerBias = mix(1.0, 0.65, yN);
    float o = max(d, 0.0);
    float glow = exp(-o / GLOW_RADIUS) * GLOW_STRENGTH
               + exp(-o / SOFT_RADIUS) * SOFT_STRENGTH;
    glow *= vis * lowerBias * (1.0 - inside);
    col += GLOW_COLOR * glow;

    fragColor = vec4(min(col, vec3(1.0)), base.a);
}
