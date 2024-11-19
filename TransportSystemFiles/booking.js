document.getElementById("search-button").addEventListener("click", function () {
  const startLocation = document.getElementById("start-location").value;
  const destination = document.getElementById("destination").value;
  const transportMode = document.getElementById("transport").value;

  if (!startLocation || !destination || !transportMode) {
    alert("Please select all options!");
    return;
  }

  // Store the values in localStorage
  localStorage.setItem("startLocation", startLocation);
  localStorage.setItem("destination", destination);
  localStorage.setItem("transportMode", transportMode);

  // // Redirect to the booking portal page
  // window.location.href = "booking-portal.html";
});

document.getElementById('travel-form').addEventListener('submit', function (event) {
  event.preventDefault(); // Prevent default form submission

  const startLocation = document.getElementById('start-location').value;
  const destination = document.getElementById('destination').value;
  const transport = document.getElementById('transport').value;

  if (startLocation && destination && transport) {
      fetch('booking.php', {
          method: 'POST',
          headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
          body: `startLocation=${startLocation}&destination=${destination}&transport=${transport}`
      })
      .then(response => response.json())
      .then(data => {
          if (data.error) {
              alert(data.error);
          } else {
              // Store data in localStorage for use on bookTickets.html
              localStorage.setItem('travelOptions', JSON.stringify(data));
              window.location.href = 'booking.html'; // Redirect to booking page
          }
      })
      .catch(error => console.error('Error:', error));
  } else {
      alert('Please fill in all fields.');
  }
});
