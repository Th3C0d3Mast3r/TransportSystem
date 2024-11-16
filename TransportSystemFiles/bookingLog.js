// Fetch routes based on selected mode
function fetchRoutes() {
    const modeType = document.getElementById('modeSelect').value;
    fetch(`/routes?modeType=${modeType}`)
      .then(response => response.json())
      .then(data => displayRoutes(data))
      .catch(error => console.error('Error fetching routes:', error));
  }
  
  // Display the available routes
  function displayRoutes(routes) {
    const container = document.getElementById('routesContainer');
    container.innerHTML = '';
    routes.forEach(route => {
      const div = document.createElement('div');
      div.innerHTML = `
        <p>Route: ${route.route}</p>
        <p>Vehicle No: ${route.busNo || route.cabNo || route.trainNo || route.planeNo}</p>
        <button onclick="showBookingForm('${route.busNo || route.cabNo || route.trainNo || route.planeNo}')">Book Now</button>
      `;
      container.appendChild(div);
    });
  }
  
  // Show the booking form
  function showBookingForm(vehicleNo) {
    const form = document.getElementById('bookingForm');
    form.style.display = 'block';
    form.vehicleNo = vehicleNo;
  }
  
  // Handle booking the trip
  function bookTrip(event) {
    event.preventDefault();
    const userAadhar = document.getElementById('userAadhar').value;
    const ticketsBooked = document.getElementById('ticketsBooked').value;
    const vehicleNo = event.target.vehicleNo;
  
    const data = {
      userAadhar,
      travelMode: 'AC', // Assume 'AC' for simplicity
      vehicleNo,
      ticketsBooked
    };
  
    fetch('/book', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(data)
    })
    .then(response => response.json())
    .then(data => alert('Booking successful: ' + data.bookingId))
    .catch(error => console.error('Error booking trip:', error));
  }
  