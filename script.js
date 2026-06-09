const carrusel = document.getElementById('carruselTrack')
const prevBtn = document.getElementById('prevBtn')
const nextBtn = document.getElementById('nextBtn')

function getScrollAmount() {
    const card = carrusel.querySelector('.card');
    return card.offsetWidth + 20;
}

nextBtn.addEventListener('click', () => {
    const paso = getScrollAmount();
    const maxScroll = carrusel.scrollWidth - carrusel.clientWidth;

    if (carrusel.scrollLeft >= maxScroll - 5){
        carrusel.scrollLeft = 0;
    } else {
        carrusel.scrollLeft += paso;
    }
    // carrousel.scrollLeft += getScrollAmount();
});
prevBtn.addEventListener('click', () => {
    const paso = getScrollAmount();

    if (carrusel.scrollLeft <= 0){
        carrusel.scrollLeft = carrusel.scrollWidth;
    } else {
        carrusel.scrollLeft -= paso;
    }
    // carrousel.scrollLeft -= getScrollAmount()
});