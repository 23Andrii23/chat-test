# Flutter Chat App with WebSocket

This Flutter application and Node.js backend server demonstrate a simple real-time chat application using WebSocket communication.

## Features

- Real-time messaging using WebSocket.
- Simple and intuitive user interface.
- Ability to login and logout user.
- Ability to send and receive messages.


## Prerequisites

### Flutter App

Before running the app, make sure you have the following:

- Flutter installed on your development environment.
- A WebSocket server running. You can use a local server for testing.

### Node.js Backend

Before running the backend server, ensure you have the following:

- Node.js installed on your server.
- The required npm packages installed. You can install them by running:

  ```bash
  npm install express moment ws
  ```

## Getting Started

### Node.js Backend

1. Navigate to the project directory:

   ```bash
   cd node_server
   ```

2. Install dependencies:

   ```bash
   npm install
   ```

3. Start the server:

   ```bash
   node server.js
   ```

4. The server will be running at `http://localhost:8080`. You can customize the port in the code.



### Flutter App

1. Navigate to the project directory:

   ```bash
   cd frontend
   ```

2. Install dependencies:

   ```bash
   flutter pub get
   ```

3. Open the project in your preferred Flutter development environment.

4. Run the app on two devices or simulators/emulators.


