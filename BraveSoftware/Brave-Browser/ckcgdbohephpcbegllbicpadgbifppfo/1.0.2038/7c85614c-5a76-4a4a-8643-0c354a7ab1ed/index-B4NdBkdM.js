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
function initCarousel() {
  const isScrollEndEventSupported = "onscrollend" in document.createElement("div");
  const maybeCarousel = document.querySelector(".carousel");
  if (!maybeCarousel) return;
  const carousel = maybeCarousel;
  if (!carousel.hasAttribute("data-animation-style")) {
    carousel.setAttribute("data-animation-style", "scroll");
  }
  const animationStyle = carousel.getAttribute("data-animation-style");
  const slides = document.querySelectorAll(".carousel-slide");
  if (!slides) return;
  let currentSlide = 0;
  const slideDisplayOrder = shuffleSlideDisplayOrder(
    carousel,
    slides
  );
  let autoplayInterval = null;
  let isFirstRun = true;
  setSlideFocalPoints();
  displaySlide(currentSlide);
  addEventListeners();
  maybeCreatePaginationDots();
  maybeUpdatePaginationDots(currentSlide);
  maybeStartAutoplay();
  function shuffleArray(array) {
    const shuffled_array = [...array];
    for (let i = shuffled_array.length; i > 1; i--) {
      const j = Math.floor(Math.random() * i);
      [shuffled_array[i - 1], shuffled_array[j]] = [
        shuffled_array[j],
        shuffled_array[i - 1]
      ];
    }
    return shuffled_array;
  }
  function shuffleSlideDisplayOrder(carousel2, slides2) {
    let slideDisplayOrder2 = Array.from(slides2, (_, i) => i);
    const displayOrder = carousel2.getAttribute("data-display-order") || "sequential";
    if (displayOrder === "shuffle") {
      slideDisplayOrder2 = shuffleArray(slideDisplayOrder2);
      const slidesArray = Array.from(slides2);
      slideDisplayOrder2.forEach((index) => {
        carousel2.appendChild(slidesArray[index]);
      });
    }
    return slideDisplayOrder2;
  }
  function setSlideFocalPoints() {
    document.querySelectorAll(".carousel-slide img").forEach((img) => {
      img.style.objectPosition = img.getAttribute("data-focal-point") || "center";
    });
  }
  function displaySlide(index) {
    if (index < 0 || index >= slides.length) return;
    const slideIndex = slideDisplayOrder[index];
    if (window.matchMedia("(prefers-reduced-motion: reduce)").matches) {
      carousel.scrollTo({
        left: index * carousel.clientWidth,
        behavior: "auto"
      });
      return;
    }
    if (animationStyle === "fade") {
      slides.forEach((slide, i) => {
        if (!isFirstRun) {
          slide.style.transition = "opacity 1s ease";
        }
        slide.classList.toggle("active", i === slideIndex);
      });
      isFirstRun = false;
    } else if (animationStyle === "scroll") {
      carousel.scrollTo({
        left: index * carousel.clientWidth,
        behavior: "smooth"
      });
    }
  }
  function nextSlide() {
    resetAutoplay();
    currentSlide = (currentSlide + 1) % slides.length;
    maybeUpdatePaginationDots(currentSlide);
    displaySlide(currentSlide);
  }
  function nextSlideWithUserInteraction() {
    nextSlide();
    dispatchNttEvent("interaction");
  }
  function prevSlide() {
    resetAutoplay();
    currentSlide = (currentSlide - 1 + slides.length) % slides.length;
    maybeUpdatePaginationDots(currentSlide);
    displaySlide(currentSlide);
  }
  function prevSlideWithUserInteraction() {
    prevSlide();
    dispatchNttEvent("interaction");
  }
  function maybeCreatePaginationDots() {
    const paginationDotsContainer = document.getElementById(
      "carousel-pagination-dots-container"
    );
    if (!paginationDotsContainer) return;
    slides.forEach((_, i) => {
      const pagination_dot = document.createElement("span");
      pagination_dot.classList.add("carousel-pagination-dot");
      pagination_dot.addEventListener("click", () => {
        resetAutoplay();
        currentSlide = i;
        maybeUpdatePaginationDots(currentSlide);
        displaySlide(currentSlide);
        dispatchNttEvent("interaction");
      });
      paginationDotsContainer.appendChild(pagination_dot);
    });
  }
  function maybeUpdatePaginationDots(index) {
    if (index < 0 || index >= slides.length) return;
    document.querySelectorAll(".carousel-pagination-dot").forEach((paginationDot, i) => {
      paginationDot.classList.toggle("active", i === index);
    });
  }
  function addEventListeners() {
    document.addEventListener("visibilitychange", handleVisibilityChange);
    carousel.addEventListener("scroll", handleScroll);
    carousel.addEventListener("scrollend", handleScrollEnd);
    bindClickEvent(".carousel-slide img", () => dispatchNttEvent("click"));
    bindClickEvent(".carousel-navigation.next", nextSlideWithUserInteraction);
    bindClickEvent(".carousel-navigation.prev", prevSlideWithUserInteraction);
  }
  function calculateAutoplayInterval() {
    const autoplay = carousel.getAttribute("data-autoplay");
    if (!autoplay) {
      return document.querySelector(".carousel-navigation-container") ? 0 : 3;
    }
    return Number(autoplay);
  }
  function maybeStartAutoplay() {
    const intervalInSeconds = calculateAutoplayInterval();
    if (intervalInSeconds > 0) {
      startAutoplay(intervalInSeconds);
    }
  }
  function startAutoplay(intervalInSeconds) {
    stopAutoplay();
    autoplayInterval = window.setInterval(nextSlide, intervalInSeconds * 1e3);
  }
  function stopAutoplay() {
    if (autoplayInterval) {
      clearInterval(autoplayInterval);
      autoplayInterval = null;
    }
  }
  function resetAutoplay() {
    stopAutoplay();
    maybeStartAutoplay();
  }
  function handleVisibilityChange() {
    document.visibilityState === "visible" ? maybeStartAutoplay() : stopAutoplay();
  }
  function handleScroll() {
    if (animationStyle !== "scroll") return;
    resetAutoplay();
    currentSlide = Math.round(carousel.scrollLeft / carousel.clientWidth);
    if (!isScrollEndEventSupported) {
      handleScrollEnd();
    }
  }
  function handleScrollEnd() {
    if (animationStyle !== "scroll") return;
    maybeUpdatePaginationDots(currentSlide);
  }
}
document.addEventListener("DOMContentLoaded", () => {
  initCarousel();
  bindClickEvent(".brand-button", () => dispatchNttEvent("click"));
});
