function isAndroid() {
  return /Android/i.test(navigator.userAgent);
}
const dispatchedEvents = /* @__PURE__ */ new Set();
function dispatchNttEvent(eventType) {
  if (dispatchedEvents.has(eventType)) return;
  dispatchedEvents.add(eventType);
  const targetOrigin = isAndroid() ? "chrome://new-tab-takeover" : "chrome://newtab";
  window.parent.postMessage(
    { type: "richMediaEvent", value: eventType },
    targetOrigin
  );
}
function bindClickEvent(selector, handler) {
  const elements = document.querySelectorAll(selector);
  if (elements.length === 0) {
    console.warn(`No elements found for selector: ${selector}`);
    return;
  }
  elements.forEach((element) => element.addEventListener("click", handler));
}
function bindClickEvents(selectors, handler) {
  selectors.forEach((selector) => bindClickEvent(selector, handler));
}
function initParallax() {
  const DEFAULT_PARALLAX_DEPTH = 20;
  const DEFAULT_PARALLAX_TILT = 5;
  const DEFAULT_CONTENT_DEPTH = 10;
  const DEFAULT_CONTENT_TILT = 5;
  const TILT_DEPTH_FACTOR = 0.25;
  const POSITION_THRESHOLD = 1e-3;
  const LERP_SPEED = 0.1;
  const parallaxContainer = document.querySelector(
    ".parallax-container"
  );
  if (!parallaxContainer) {
    console.warn("Parallax container not found, failed to initialize.");
    return;
  }
  const parallaxDepth = parallaxContainer.dataset.parallaxDepth !== void 0 ? parseFloat(parallaxContainer.dataset.parallaxDepth) : DEFAULT_PARALLAX_DEPTH;
  const parallaxTilt = parallaxContainer.dataset.parallaxTilt !== void 0 ? parseFloat(parallaxContainer.dataset.parallaxTilt) : DEFAULT_PARALLAX_TILT;
  const parallaxLayers = document.querySelectorAll(".parallax-layer");
  if (!parallaxLayers.length) {
    console.warn("No parallax layers found, failed to initialize.");
    return;
  }
  const filteredParallaxLayers = Array.from(parallaxLayers).filter(
    (layer) => !layer.classList.contains("content")
  );
  filteredParallaxLayers.forEach((layer) => {
    const image = layer.dataset.image;
    if (image) layer.style.backgroundImage = `url(${image})`;
    layer.style.pointerEvents = "none";
  });
  const contentContainer = document.querySelector(".content-container");
  if (!contentContainer) {
    console.warn("Content container not found, failed to initialize.");
    return;
  }
  const contentDepth = contentContainer.dataset.parallaxDepth !== void 0 ? parseFloat(contentContainer.dataset.parallaxDepth) : DEFAULT_CONTENT_DEPTH;
  const contentTilt = contentContainer.dataset.parallaxTilt !== void 0 ? parseFloat(contentContainer.dataset.parallaxTilt) : DEFAULT_CONTENT_TILT;
  const contentLayers = document.querySelectorAll(".content");
  if (!contentLayers.length) {
    console.warn("No content layers found, failed to initialize.");
    return;
  }
  contentLayers.forEach((layer) => {
    layer.style.pointerEvents = "auto";
    layer.style.willChange = "transform";
  });
  let currentX = 0, currentY = 0;
  let targetX = 0, targetY = 0;
  let animationFrameId = null;
  const calculateTransform = (x, y, translateFactor, rotateFactor) => `translateX(${x * translateFactor}px) translateY(${y * translateFactor}px) rotateX(${y * rotateFactor}deg) rotateY(${x * rotateFactor}deg)`;
  function applyTransforms(elements, x, y, depth, tilt, tiltDepthFactor) {
    elements.forEach((layer, i) => {
      const translateFactor = depth * (i + 1);
      const rotateFactor = tilt + (i + 1) * tiltDepthFactor;
      layer.style.transform = calculateTransform(
        x,
        y,
        translateFactor,
        rotateFactor
      );
    });
  }
  const applyParallax = (x, y) => {
    applyTransforms(
      filteredParallaxLayers,
      x,
      y,
      parallaxDepth,
      parallaxTilt,
      TILT_DEPTH_FACTOR
    );
    applyTransforms(
      Array.from(contentLayers),
      x,
      y,
      contentDepth,
      contentTilt,
      TILT_DEPTH_FACTOR
    );
  };
  function maybeCancelAnimation() {
    if (animationFrameId !== null) {
      cancelAnimationFrame(animationFrameId);
      animationFrameId = null;
    }
  }
  const animate = () => {
    const deltaX = targetX - currentX;
    const deltaY = targetY - currentY;
    if (Math.abs(deltaX) < POSITION_THRESHOLD && Math.abs(deltaY) < POSITION_THRESHOLD) {
      animationFrameId = null;
      return;
    }
    currentX += deltaX * LERP_SPEED;
    currentY += deltaY * LERP_SPEED;
    applyParallax(currentX, currentY);
    animationFrameId = requestAnimationFrame(animate);
  };
  const normalizePosition = (x, y) => {
    const CENTER_OFFSET = 0.5;
    return {
      x: x / window.innerWidth - CENTER_OFFSET,
      y: y / window.innerHeight - CENTER_OFFSET
    };
  };
  const maybeApplyParallax = (x, y) => {
    const pos = normalizePosition(x, y);
    targetX = pos.x;
    targetY = pos.y;
    if (!animationFrameId) {
      animationFrameId = requestAnimationFrame(animate);
    }
  };
  if (window.matchMedia("(prefers-reduced-motion)").matches) {
    console.warn("User prefers reduced motion. Skipping animations.");
    return;
  }
  parallaxContainer.addEventListener(
    "pointermove",
    (event) => {
      maybeApplyParallax(event.clientX, event.clientY);
    },
    { passive: true }
  );
  document.addEventListener("visibilitychange", () => {
    if (document.hidden) {
      maybeCancelAnimation();
    }
  });
  window.addEventListener("blur", maybeCancelAnimation);
}
document.addEventListener("DOMContentLoaded", () => {
  initParallax();
  bindClickEvents([".button"], () => dispatchNttEvent("click"));
});
