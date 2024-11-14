window.addEventListener('scroll', () => {
    const airSection = document.getElementById('air-routes');
    const roadSection = document.getElementById('road-routes');

    if (airSection) {
        const airSectionTop = airSection.getBoundingClientRect().top;
        if (airSectionTop < window.innerHeight && airSectionTop > 0) {
            airSection.style.opacity = '1';
            airSection.style.transform = 'translateY(0)';
        } else {
            airSection.style.opacity = '0';
            airSection.style.transform = 'translateY(100px)';
        }
    }

    if (roadSection) {
        const roadSectionTop = roadSection.getBoundingClientRect().top;
        if (roadSectionTop < window.innerHeight && roadSectionTop > 0) {
            roadSection.style.opacity = '1';
            roadSection.style.transform = 'translateY(0)';
        } else {
            roadSection.style.opacity = '0';
            roadSection.style.transform = 'translateY(100px)';
        }
    }
});
