document.getElementById('signInForm').addEventListener('submit', function (event) {
    event.preventDefault(); // Prevent default form submission

    // Predefined user credentials
    const users = {
        Devesh: "AD001",
        Atharv: "AD002",
        Yug: "AD003"
    };

    // Get user inputs
    const aadharInput = document.getElementById('aadharInput').value.trim();
    const passwordInput = document.getElementById('passwordInput').value.trim();

    // Check credentials
    if (users[aadharInput] === passwordInput) {
        // Redirect to admin-dashboard.html if valid
        window.location.href = "admin-dashboard.html";
    } else {
        // Display an error alert if invalid
        alert("Invalid Aadhar Number or Password");
    }
});