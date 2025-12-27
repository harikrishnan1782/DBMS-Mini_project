const express = require('express');
const bodyParser = require('body-parser');
const mysql = require('mysql2');
const path = require('path');

console.log('✅ Starting Horizon Airways server...');

const app = express();

// ==========================================
//              1. MIDDLEWARE
// ==========================================
app.set('view engine', 'ejs');
app.set('views', './views'); 
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());
app.use(express.static('public')); 

// Temporary In-Memory Storage for Booking Flow
let tempBookingData = {}; 

// ==========================================
//           2. DATABASE CONNECTION
// ==========================================
const db = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: 'root',       // CHECK THIS: Your MySQL Password
    database: 'airways',    // Your Database Name
    multipleStatements: true
});

db.connect((err) => {
    if (err) {
        console.error('❌ Database connection failed: ' + err.stack);
        return;
    }
    console.log('✅ Connected to MySQL Database (airways).');
});

// ==========================================
//           3. PUBLIC & HOME ROUTES
// ==========================================

// HOME PAGE (Smart Routing with Upcoming Flights)
app.get('/', (req, res) => {
    const userId = req.query.uid; 

    // 1. Fetch Airports for Dropdowns
    db.query('SELECT * FROM airports ORDER BY city', (err, airports) => {
        if (err) return res.send("Database Error");

        // 2. Fetch Upcoming Flights (Next 6 departures)
        const flightQuery = `
            SELECT f.*, 
                   a1.city as source_city, a1.airport_code as source_code,
                   a2.city as dest_city, a2.airport_code as dest_code
            FROM flights f
            JOIN routes r ON f.route_id = r.route_id
            JOIN airports a1 ON r.source_airport_id = a1.airport_id
            JOIN airports a2 ON r.destination_airport_id = a2.airport_id
            WHERE f.departure_time >= NOW()
            ORDER BY f.departure_time ASC
            LIMIT 6`;

        db.query(flightQuery, (err, upcomingFlights) => {
            if (err) console.error("Flight Fetch Error:", err);
            const flights = upcomingFlights || [];

            if (userId) {
                // LOGGED IN USER -> Show home.ejs
                db.query('SELECT * FROM users WHERE user_id = ?', [userId], (err, users) => {
                    if(users.length > 0) {
                        res.render('home', { 
                            airports: airports, 
                            user: users[0],
                            upcomingFlights: flights // Sending flights to EJS
                        });
                    } else {
                        res.render('index', { airports: airports, upcomingFlights: flights });
                    }
                });
            } else {
                // GUEST USER -> Show index.ejs
                res.render('index', { 
                    airports: airports,
                    upcomingFlights: flights // Sending flights to EJS
                });
            }
        });
    });
});

// SEARCH FLIGHTS
app.post('/search', (req, res) => {
    const { source, destination, date } = req.body;
    
    const query = `
        SELECT f.*, ac.model, ac.total_seats, 
               a1.city as source_city, a1.airport_code as source_code,
               a2.city as dest_city, a2.airport_code as dest_code
        FROM flights f
        JOIN routes r ON f.route_id = r.route_id
        JOIN aircraft ac ON f.aircraft_id = ac.aircraft_id
        JOIN airports a1 ON r.source_airport_id = a1.airport_id
        JOIN airports a2 ON r.destination_airport_id = a2.airport_id
        WHERE r.source_airport_id = ? 
        AND r.destination_airport_id = ? 
        AND DATE(f.departure_time) = ?`;

    db.query(query, [source, destination, date], (err, flights) => {
        if (err) console.error(err);

        db.query('SELECT * FROM airports WHERE airport_id IN (?, ?)', [source, destination], (err, airports) => {
            const src = airports.find(a => a.airport_id == source);
            const dst = airports.find(a => a.airport_id == destination);
            
            res.render('flights', { 
                flights: flights, 
                source: src, 
                destination: dst, 
                travel_date: date,
                userId: user_id,
                user_name: user_name    
           });
        });
    });
});

// ==========================================
//           4. BOOKING FLOW
// ==========================================

// STEP 1: REVIEW BOOKING
app.get('/book/:id', (req, res) => {
    // Check for User ID in URL (passed from Home/Search)
    const userId = req.query.uid || 1; // Default to User 1 for demo

    db.query('SELECT * FROM users WHERE user_id = ?', [userId], (err, users) => {
        const query = `
            SELECT f.*, a1.city AS source_city, a1.airport_code as source_code,
                   a2.city AS dest_city, a2.airport_code as dest_code,
                   (ac.total_seats - (SELECT COUNT(*) FROM bookings WHERE flight_id = f.flight_id)) as available_seats
            FROM flights f
            JOIN routes r ON f.route_id = r.route_id
            JOIN airports a1 ON r.source_airport_id = a1.airport_id
            JOIN airports a2 ON r.destination_airport_id = a2.airport_id
            JOIN aircraft ac ON f.aircraft_id = ac.aircraft_id
            WHERE f.flight_id = ?`;

        db.query(query, [req.params.id], (err, result) => {
            res.render('booking', { flight: result[0], user: users[0] });
        });
    });
});

// STEP 2: PAYMENT PAGE
app.post('/payment', (req, res) => {
    // Get flight_id, seats AND user_id from the Booking Form
    const { flight_id, seats, user_id } = req.body;
    
    // Use the passed user_id or fallback to 1
    const userId = user_id || 1; 

    db.query('SELECT * FROM flights WHERE flight_id = ?', [flight_id], (err, flights) => {
        const flight = flights[0];
        const total = flight.base_fare * seats;

        // Store in temp memory
        tempBookingData = { flight_id, seats, userId, total_amount: total };

        // Fetch User Name for Card Display
        db.query('SELECT full_name FROM users WHERE user_id = ?', [userId], (err, users) => {
            res.render('payment', { 
                bookingData: {
                    total_amount: total,
                    seats: seats,
                    flight: flight,
                    passenger_name: users[0].full_name
                }
            });
        });
    });
});

// STEP 3: CONFIRM & SAVE
app.post('/confirm_booking', (req, res) => {
    const { userId, flight_id, seats, total_amount } = tempBookingData;

    if (!flight_id) return res.redirect('/'); 

    const bookingQuery = 'INSERT INTO bookings (user_id, flight_id, seats_booked, total_amount, booking_status) VALUES (?, ?, ?, ?, "Confirmed")';
    
    db.query(bookingQuery, [userId, flight_id, seats, total_amount], (err, result) => {
        if (err) return res.send("Booking Error");

        const bookingId = result.insertId;
        const paymentQuery = 'INSERT INTO payments (booking_id, amount_paid, payment_method, payment_status) VALUES (?, ?, "Credit Card", "Completed")';
        
        db.query(paymentQuery, [bookingId, total_amount], () => {
            
            const ticketQuery = `
                SELECT b.booking_id, b.seats_booked, b.total_amount, 
                       f.flight_number, f.departure_time,
                       a1.city as source_city, a2.city as dest_city
                FROM bookings b
                JOIN flights f ON b.flight_id = f.flight_id
                JOIN routes r ON f.route_id = r.route_id
                JOIN airports a1 ON r.source_airport_id = a1.airport_id
                JOIN airports a2 ON r.destination_airport_id = a2.airport_id
                WHERE b.booking_id = ?`;

            db.query(ticketQuery, [bookingId], (err, ticket) => {
                res.render('success', { booking: ticket[0] });
            });
        });
    });
});

// VIEW TICKET
app.get('/ticket/:id', (req, res) => {
    const ticketQuery = `
        SELECT b.*, f.flight_number, f.departure_time,
                a1.city as source_city, a2.city as dest_city,
                a1.airport_code as source_code, a2.airport_code as dest_code,
                u.full_name as passenger_name
        FROM bookings b
        JOIN flights f ON b.flight_id = f.flight_id
        JOIN routes r ON f.route_id = r.route_id
        JOIN airports a1 ON r.source_airport_id = a1.airport_id
        JOIN airports a2 ON r.destination_airport_id = a2.airport_id
        JOIN users u ON b.user_id = u.user_id
        WHERE b.booking_id = ?`;

    db.query(ticketQuery, [req.params.id], (err, result) => {
        res.render('ticket', { booking: result[0] });
    });
});

// CANCEL BOOKING
app.post('/cancel/:id', (req, res) => {
    // In a real app, you'd check which user owns the booking first
    // For demo, we just redirect to the dashboard of User 1 (or grab session)
    db.query("UPDATE bookings SET booking_status = 'Cancelled' WHERE booking_id = ?", [req.params.id], () => {
        res.redirect('/dashboard?uid=1');
    });
});

// ==========================================
//           5. AUTHENTICATION
// ==========================================

app.get('/login', (req, res) => {
    res.render('login', { error: null });
});

app.post('/login', (req, res) => {
    const { email, password } = req.body;
    db.query('SELECT * FROM users WHERE email = ? AND password = ?', [email, password], (err, results) => {
        if (results.length > 0) {
            // Redirect to Home with UID to show personalized dashboard link
            res.redirect(`/?uid=${results[0].user_id}`);
        } else {
            res.render('login', { error: "Invalid Email or Password" });
        }
    });
});

app.get('/register', (req, res) => {
    res.render('register', { error: null });
});

app.post('/register', (req, res) => {
    const { name, email, password } = req.body;
    db.query('INSERT INTO users (full_name, email, password, role_id) VALUES (?, ?, ?, 1)', [name, email, password], (err) => {
        if (err) {
            res.render('register', { error: "Email exists" });
        } else {
            res.redirect('/login');
        }
    });
});

app.get('/dashboard', (req, res) => {
    const userId = req.query.uid || 1; 
    
    const query = `
        SELECT b.booking_id, b.booking_date, b.booking_status, 
               f.flight_number, f.departure_time,
               a1.city as source_city, a1.airport_code as source_code,
               a2.city as dest_city, a2.airport_code as dest_code
        FROM bookings b
        JOIN flights f ON b.flight_id = f.flight_id
        JOIN routes r ON f.route_id = r.route_id
        JOIN airports a1 ON r.source_airport_id = a1.airport_id
        JOIN airports a2 ON r.destination_airport_id = a2.airport_id
        WHERE b.user_id = ?
        ORDER BY b.booking_date DESC`;

    db.query(query, [userId], (err, bookings) => {
        res.render('dashboard', { bookings: bookings || [], user: { user_id: userId } });
    });
});

app.get('/logout', (req, res) => {
    res.redirect('/');
});

// ==========================================
//           6. ADMIN PORTAL
// ==========================================

app.get('/admin/login', (req, res) => {
    res.render('admin-login', { error: null });
});

app.post('/admin/login', (req, res) => {
    const { username, password } = req.body;
    if (username.trim() === "admin" && password.trim() === "admin123") {
        res.redirect('/admin/dashboard'); 
    } else {
        res.render('admin-login', { error: "Invalid Credentials" });
    }
});

app.get('/admin/dashboard', (req, res) => {
    const q1 = `SELECT DATE_FORMAT(payment_date, '%Y-%m') as month, SUM(amount_paid) as revenue FROM payments GROUP BY month ORDER BY month DESC LIMIT 6;`;   
    const q2 = `SELECT b.booking_id, u.full_name as customer_name, f.flight_number, a1.city as source_city, a2.city as dest_city, b.booking_date, b.seats_booked, b.total_amount, b.booking_status FROM bookings b JOIN users u ON b.user_id = u.user_id JOIN flights f ON b.flight_id = f.flight_id JOIN routes r ON f.route_id = r.route_id JOIN airports a1 ON r.source_airport_id = a1.airport_id JOIN airports a2 ON r.destination_airport_id = a2.airport_id ORDER BY b.booking_date DESC LIMIT 5;`;
    const q3 = `SELECT (SELECT COALESCE(SUM(amount_paid), 0) FROM payments) as total_revenue, (SELECT COUNT(*) FROM bookings) as total_bookings, (SELECT COUNT(*) FROM users) as total_customers, (SELECT COUNT(*) FROM flights WHERE flight_status = 'Scheduled') as total_flights;`;

    db.query(q1 + q2 + q3, (err, results) => {
        res.render('admin-dashboard', { 
            admin: { username: "Admin" },
            monthlyRevenue: results[0],
            recentBookings: results[1],
            stats: results[2][0]
        });
    });
});

app.get('/admin/logout', (req, res) => {
    res.redirect('/admin/login');
});

// ==========================================
//           7. START SERVER
// ==========================================
const PORT = 3333;
app.listen(PORT, () => {
    console.log(`✅ Server running at http://localhost:${PORT}`);
});