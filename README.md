# Travelify 🌍

**Travelify** is a web-based travel management system designed to make trip planning and ticket booking seamless for users. It is built using **Vanilla JavaScript**, **PHP**, and **MySQL**, delivering a lightweight and efficient user experience. 

This project incorporates both **user-friendly booking features** and **admin functionalities**, ensuring smooth operations for users and administrators alike.</br>
---

## Features 🚀

### User Features:
- **User Registration & Login**: 
  - Secure sign-up and login functionality using a MySQL database. 
  - User details include **name, phone number, Aadhar number (unique ID)**, and a **password**.
  
- **Route Selection**:
  - Explore predefined routes and destinations stored in the database. 
  - View details such as travel modes, prices, and availability.

- **Ticket Booking**:
  - Book tickets for your chosen route.
  - Supports multiple ticket bookings in a single transaction.
  - Generates a detailed bill on the checkout page (no real payment processing).

### Admin Features:
- **Booking Management**:
  - View and manage all bookings through an intuitive interface.
  - Access logs of tickets booked by users.

- **User Database**:
  - Admins can view details of registered users in the system.
  
- **Data Validation**:
  - Ensures that bookings are only made for registered users by verifying their **Aadhar number** and **phone number**.

---

## Tech Stack 💻

```AN UPFRONT DISCLOSURE: Do Not Try to Code such Big Websites Using PHP, when You have advanced and easy ways via JS based things!```

### Frontend:
- **HTML**: Structure of the website.
- **CSS**: Styling and responsive design.
- **Vanilla JavaScript**: Interactive and dynamic content.

### Backend:
- **PHP**: Handles server-side logic, authentication, and interactions with the database.
- **MySQL**: Database for managing user data, travel routes, bookings, and admin-related information.

### Tools:
- **XAMPP**: For integrating and running the PHP server and MySQL database.

---

## Installation 🛠️

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/yourusername/Travelify.git
   ```
2. **Set up XAMPP**:
   - Place the project files in the `htdocs` folder of your XAMPP installation.
   - Start the Apache and MySQL services.

3. **Database Setup**:
   - Import the SQL file (`TransportDB.sql`) provided in the repository into your MySQL server.
   - Update the database configuration in `config.php` with your MySQL credentials.

4. **Launch the Website**:
   - Open your browser and navigate to `http://localhost/Travelify`.

---

## Usage 👩‍💻

1. **For Users**:
   - Sign up or log in to access features.
   - Explore routes and travel options.
   - Book tickets and view a detailed bill.

2. **For Admins**:
   - Monitor bookings and user activity.

---

## Future Enhancements (WHAT WE WILL WORK FOR ADDING IN THE EXISTING WEBSITE) 🌟

- **Online Payment Integration**: Allow users to pay securely through the website.
- **Dynamic Route Updates**: Enable admins to add/edit travel routes and vehicles.
- **Notifications**: Email/SMS confirmations for bookings.
- **User Analytics**: Provide insights into popular routes and trends.

---

## Contribution 🤝

We welcome contributions from the community! Feel free to:
- Report issues
- Suggest new features
- Submit pull requests

---

## License 📜

This project is open-source and available under the [MIT License](LICENSE).

---

```NOTE: The Website Is Still in Development Process and Some Changes will be made in the coming time```

**Developed by [Devesh Acharya](https://github.com/deveshacharya), [Atharv Bidwai](https://github.com/AtharvBidwai) and Minor Edits in Code and Documentation by Yug Bhanushali**  
Sophomores, Computer Science Engineering
