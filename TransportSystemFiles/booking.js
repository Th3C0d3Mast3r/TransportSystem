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
  
    // Redirect to the booking portal page
    window.location.href = "booking-portal.html";
  });