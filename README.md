# GymMan - Gym Management System (Flask Web Application)
**Author:** Isaac Stephens  
**Course:** CS 2300 — File Structures and Database Systems  
**Institution:** Missouri S&T

---

## Overview

GymMan is a full-stack **web-based Gym Management System** built using **Flask**, **MariaDB**, and standard web technologies.  
The project began as a planned desktop ImGui/Vulkan application but fully pivoted to a **web interface** to better support the scale and complexity of the database system.

This application provides a structured way for gym owners, staff, trainers, and members to manage essential gym operations, from member onboarding to trainer assignments to exercise tracking and financial reporting.

---

## Current Status

✔ Fully implemented Flask application  
✔ Complete relational database schema with 20+ tables  
`WIP` Role-based dashboards (Owner, Staff, Trainers, Member views)  
`WIP` CRUD operations for all major entities  
`WIP` Real exercise logging system (strength and cardio specialization models)  
`WIP` Payment system with summaries and revenue queries  
`WIP` Trainer–client relationship management  
✔ Load-more pagination, dynamic flash messages, form validation, and error handling  
✔ Deployed and tested locally and on server using Gunicorn + Nginx

---


## Core Features (Partially Implemented)

### **Member Management**
- Add, update, delete members  
- Add/remove phone numbers and emergency contacts  
- Track membership start dates, demographics, and contact info  
- View exercise history and payment history

### **Staff & Trainer Management**
- Register staff with SSN, name, role, employment date  
- Sub-type specific storage (trainer, contractor, hourly, salary, maintenance)  
- Register trainer certifications  
- Assign/unassign members to trainers  

### **Exercise Logging**
- Add strength or cardio exercise  
- Strength: weight, unit, sets, reps, RPE, notes  
- Cardio: avg heart rate, time, subtype  
  - Run → distance, laps  
  - Bike → distance, wattage  
- Modify or delete exercises  
- Full exercise history per member

### **Payments**
- Add new payments  
- View payment summary for each member  
- Compute total gym revenue  

### **Queries & Reports**
- Trainer client lists  
- Total payments per member  
- Maximum weight lifted  
- Average distance per member (runs)  
- Average RPE (per member or global)  
- Drill-down exercise history  
- Date-range filters  
- Dashboard metrics and summaries  

---

## Database Architecture

The database enforces:

- **Referential integrity** with ON DELETE CASCADE behaviors  
- **Super-type/sub-type modeling** for Staff and Exercises  
- **Specialized cardio subtypes (Runs, Bike_Rides)**  
- **Unique trainer–member pairings**  
- **Check constraints** for units, RPE ranges, positive distances, etc.  

A full ER and logical schema is included in `documentation/`:

![GymMan ER Diagram](documentation/GymMan_Relational_MySQLworkbench.png)

---

## Technology Stack

| Layer | Technologies |
|-------|--------------|
| **Frontend** | HTML, CSS, Jinja2 templates |
| **Backend** | Flask (Python 3.13) |
| **Database** | MariaDB |
| **Auth** | Flask sessions, hashed passwords |
| **Server Deployment** | Gunicorn, Nginx reverse proxy |
| **Misc** | Cloudflare Tunnels, Linux (Debian) |
