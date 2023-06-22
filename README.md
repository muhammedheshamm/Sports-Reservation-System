# Sports Reservation System

This is a sports reservation system developed using the .NET Framework and MSSQL database. The system provides various features for different user roles including System Admin, Sports Association Manager, Club Representative, Stadium Manager, and Fan. Users can perform specific actions based on their assigned roles.

## Features

### 2.1 System Admin
- Add a new club using its name and location.
- Delete a club using its name.
- Add a new stadium using its name, location, and capacity.
- Delete a stadium using its name.
- Block a fan using their national ID number.

### 2.2 Sports Association Manager
- Register with a name, username, and password.
- Add a new match with a host club name, guest club name, start time, and end time.
- Delete a match with a host club name, guest club name, start time, and end time.
- View all upcoming matches (including host club name, guest club name, start time, and end time).
- View already played matches (including host club name, guest club name, start time, and end time).
- View pairs of club names that have never scheduled to play with each other.

### 2.3 Club Representative
- Register with a name, username, password, and the name of an already existing club.
- View all related information of the club they are representing.
- View all upcoming matches for the club they are representing (including host club name, guest club name, start time, and end time) with the stadium name that hosts the match (if available).
- View all available stadiums starting at a certain date (including stadium name, location, and capacity).
- Send a request to a stadium manager to host an upcoming match their club is hosting.

### 2.4 Stadium Manager
- Register with a name, username, password, and the name of an already existing stadium.
- View all related information of the stadium they are managing.
- View all requests they have received (including name of the sending club representative, name of the host club of the requested match, name of the guest club of the requested match, start time of the match, end time of the match, and the status of the request).
- Accept an already sent unhandled request.
- Reject an already sent unhandled request.

### 2.5 Fan
- Register with a name, username, password, national ID number, phone number, birth date, and address.
- View all matches that have available tickets starting at a given time (including host club name, guest club name, name of the stadium hosting the match, and the location of that stadium).
- Purchase a ticket for a match.

## Technologies Used
- .NET Framework
- MSSQL (Microsoft SQL Server)

## Getting Started
To get started with the sports reservation system, follow these steps:
1. Install the required dependencies, including .NET Framework and MSSQL Server.
2. Set up the MSSQL database and configure the connection string in the application.
3. Build and run the project.
4. Access the system through a web browser or a dedicated client application.
5. Create user accounts for different roles and start using the system based on the assigned roles.

## Feedback
If you have any feedback, please reach out to us at muhammedheshamm1@gmail.com.
