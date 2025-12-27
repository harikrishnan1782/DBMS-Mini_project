# Horizon Airways – DBMS Mini Project

A complete airline management mini-project built using Node.js, Express, MySQL, and EJS.  
This system demonstrates database design, CRUD operations, workflows, and real-world DBMS concepts.

---

## Project Overview
Horizon Airways is a simplified airline management system that manages:

- Airports  
- Routes  
- Users & Roles  
- Bookings  
- Flight Management  
- Admin Operations  

The project follows proper DBMS normalization, ER design, and MySQL relational constraints.

---

## Folder Structure

Horizon-airways/
│── db/                # Database connection, queries
│── public/            # Static files (CSS, images)
│── views/             # EJS templates (frontend UI)
│── Work_Flow_Imgs/    # Workflow diagrams & screenshots
│── server.js          # Main backend server
│── config.js          # Database configuration
│── simple.js          # Basic test script
│── test-server.js     # Server testing
│── package.json       
│── package-lock.json

## Tech Stack
- Backend: Node.js, Express  
- Frontend: EJS, HTML, CSS  
- Database: MySQL  
- Tools: Git, VS Code, Postman 

## Database Schema
Major entities:

- `users`
- `roles`
- `airports`
- `routes`
- `flights`
- `bookings`

Includes primary keys, foreign keys, cascading rules, and normalized structure.
## Features
- User authentication  
- Role-based access  
- Add/View Flights  
- Manage Airports and Routes  
- Ticket Booking simulation  
- MySQL relational integrity  
- ER diagram workflow  -- i used AIRED web page to generate
## How to Run

### 1. Install Dependencies
```bash
npm install
Configure MySQL

Update your credentials in config.js:

module.exports = {
    host: "localhost",
    user: "root",
    password: "",
    database: "airways"
}
3. Start the Server
node server.js


