const innercircle = document.getElementById("inner-circle");
const outerCircle = document.getElementById("outer-circle");

let currentSize = 140;

function getRandomColor() {
  return `#${Math.floor(Math.random() * 16777215).toString(16)}`;
}
  
innercircle.onmousedown = (e) => {
  e.preventDefault();

  let shiftX = e.clientX - innercircle.getBoundingClientRect().left;
  let shiftY = e.clientY - innercircle.getBoundingClientRect().top;

  const moveAt = (pageX, pageY) => {
    innercircle.style.left = pageX - shiftX + "px";
    innercircle.style.top = pageY - shiftY + "px";
  };

  const onMouseMove = (e) => {
    moveAt(e.pageX, e.pageY);
  };

  document.addEventListener("mousemove", onMouseMove);

  document.onmouseup = (e) => {
    document.removeEventListener("mousemove", onMouseMove);

    const innerRect = innercircle.getBoundingClientRect();
    const outerRect = outerCircle.getBoundingClientRect();

    const isInside =
      innerRect.left >= outerRect.left &&
      innerRect.right <= outerRect.right &&
      innerRect.top >= outerRect.top &&
      innerRect.bottom <= outerRect.bottom;

    if (isInside) {
      addnew();
      document.onmouseup = null;
    }
  };
};

function addnew() {
  if (currentSize > 5) {
    currentSize *= 0.8;
    const newInnerCircle = document.createElement("div");
    newInnerCircle.classList.add("circle");
    newInnerCircle.style.width = `${currentSize}px`;
    newInnerCircle.style.height = `${currentSize}px`;
    newInnerCircle.style.backgroundColor = getRandomColor();

    newInnerCircle.style.position = "absolute";
    newInnerCircle.style.top = "50%";
    newInnerCircle.style.left = "50%";
    newInnerCircle.style.transform = `translate(-50%, -50%)`;

    outerCircle.appendChild(newInnerCircle);

    innercircle.style.backgroundColor = getRandomColor();
    innercircle.style.left = "20px";
    innercircle.style.top = "20px";
    innercircle.style.width = "50px";
    innercircle.style.height = "50px";
  } else {
    // currentSize *= 0.8;
    const newInnerCircle = document.createElement("div");
    newInnerCircle.classList.add("circle");
    newInnerCircle.style.width = `${currentSize}px`;
    newInnerCircle.style.height = `${currentSize}px`;
    newInnerCircle.style.backgroundColor = innercircle.style.backgroundColor;

    newInnerCircle.style.position = "absolute";
    newInnerCircle.style.top = "50%";
    newInnerCircle.style.left = "50%";
    newInnerCircle.style.transform = `translate(-50%, -50%)`;

    outerCircle.appendChild(newInnerCircle);

    innercircle.style.backgroundColor = getRandomColor();
    innercircle.style.left = "20px";
    innercircle.style.top = "20px";
    innercircle.style.width = "50px";
    innercircle.style.height = "50px";
  }
}
