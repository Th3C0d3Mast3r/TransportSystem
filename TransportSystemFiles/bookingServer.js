const express = require('express');
const mysql = require('mysql2');
const bodyParser = require('body-parser');
const app = express();
const port = 3000;

// Middleware for parsing request bodies
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

// MySQL Database connection
const db = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'TransportDB'
});

db.connect((err) => {
  if (err) throw err;
  console.log('Connected to the database');
});

// API route to fetch available routes for different vehicles
app.get('/routes', (req, res) => {
  const modeType = req.query.modeType;
  let query;

  switch(modeType) {
    case 'BUS':
      query = 'SELECT * FROM busRoute';
      break;
    case 'CAB':
      query = 'SELECT * FROM cabRoute';
      break;
    case 'TRAIN':
      query = 'SELECT * FROM trainRoute';
      break;
    case 'PLANE':
      query = 'SELECT * FROM planeRoute';
      break;
    default:
      return res.status(400).json({ error: 'Invalid mode type' });
  }

  db.query(query, (err, results) => {
    if (err) {
      console.error(err);
      return res.status(500).json({ error: 'Database query failed' });
    }
    res.json(results);
  });
});

// API route to book a trip
app.post('/book', (req, res) => {
  const { userAadhar, travelMode, vehicleNo, ticketsBooked } = req.body;
  
  if (!userAadhar || !travelMode || !vehicleNo || !ticketsBooked) {
    return res.status(400).json({ error: 'All fields are required' });
  }

  // Fetch vehicle fare based on travel mode and vehicle number
  const fareQuery = `
    SELECT fareAC, fareNonAC FROM busRoute WHERE busNo = ?
    UNION
    SELECT fareMini, farePrime, fareSUV FROM cabRoute WHERE cabNo = ?
    UNION
    SELECT fareSleeper, fare3Tier, fare2Tier, fare1Class FROM trainRoute WHERE trainNo = ?
    UNION
    SELECT fareEconomy, fareFirstClass, farePrivate FROM planeRoute WHERE planeNo = ?
  `;

  db.query(fareQuery, [vehicleNo, vehicleNo, vehicleNo, vehicleNo], (err, fareResults) => {
    if (err || !fareResults.length) {
      return res.status(500).json({ error: 'Fare details not found' });
    }

    // Assuming fareDetails is an array with the fare prices
    const fareDetails = fareResults[0];
    let totalFare;

    // Logic to calculate the total fare based on the travel mode and number of tickets booked
    if (travelMode === 'AC') totalFare = fareDetails.fareAC * ticketsBooked;
    else if (travelMode === 'NON-AC') totalFare = fareDetails.fareNonAC * ticketsBooked;

    // Insert booking details into the bookingLog table
    const bookingQuery = `
      INSERT INTO bookingLog (userAadhar, travelMode, travelVehicle, vehicleNo, ticketsBooked, totalFare)
      VALUES (?, ?, ?, ?, ?, ?)
    `;
    db.query(bookingQuery, [userAadhar, travelMode, 'BUS', vehicleNo, ticketsBooked, totalFare], (err, result) => {
      if (err) {
        console.error(err);
        return res.status(500).json({ error: 'Booking failed' });
      }
      res.json({ message: 'Booking successful', bookingId: result.insertId });
    });
  });
});

// Start the server
app.listen(port, () => {
  console.log(`Server running on http://localhost:${port}`);
});
