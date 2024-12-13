const express = require('express');
const http = require('http');
const { WebSocketServer } = require('ws');
const app = express();
const server = http.createServer(app);
const wss = new WebSocketServer({ noServer: true });

// Store active connections
const connectedUsers = new Map();

app.use(express.json());

// Login endpoint
app.post('/login', (req, res) => {
  const { username } = req.body;
  
  if (!username) {
    return res.status(400).json({ error: 'Username is required' });
  }
  
  // Check if user is already logged in
  if (connectedUsers.has(username)) {
    return res.status(400).json({ error: 'Username already taken' });
  }
  
  res.json({
    result: 'OK',
    message: 'Login successful',
    username
  });
});

// Function to broadcast messages to all users
function broadcastMessage(message, excludeUser = null) {
  connectedUsers.forEach((ws, username) => {
    if (username !== excludeUser && ws.readyState === ws.OPEN) {
      ws.send(message);
    }
  });
}

// Handle WebSocket connection
server.on('upgrade', (request, socket, head) => {
  const url = new URL(request.url, `http://${request.headers.host}`);
  const username = url.searchParams.get('username');

  if (!username) {
    socket.write('HTTP/1.1 401 Unauthorized\r\n\r\n');
    socket.destroy();
    return;
  }

  wss.handleUpgrade(request, socket, head, (ws) => {
    wss.emit('connection', ws, username);
  });
});

wss.on('connection', (ws, username) => {
  connectedUsers.set(username, ws);
  console.log(`User ${username} connected`);

  // Send message about new user connection
  const connectMessage = JSON.stringify({
    type: 'system',
    message: `${username} joined the chat`,
    sender: 'System',
    timestamp: new Date().toISOString()
  });
  broadcastMessage(connectMessage);

  ws.on('message', (message) => {
    try {
      // Parse received message
      const parsedMessage = JSON.parse(message);
      console.log(`Received message from ${username}:`, parsedMessage);

      // Check message type
      switch (parsedMessage.type) {
        case 'message':
          // Send message to all users
          broadcastMessage(message.toString(), null);
          break;
        // Can add other message types here
        default:
          console.log(`Unknown message type: ${parsedMessage.type}`);
      }
    } catch (error) {
      console.error('Error processing message:', error);
    }
  });

  ws.on('close', () => {
    connectedUsers.delete(username);
    console.log(`User ${username} disconnected`);

    // Send message about user disconnection
    const disconnectMessage = JSON.stringify({
      type: 'system',
      message: `${username} left the chat`,
      sender: 'System',
      timestamp: new Date().toISOString()
    });
    broadcastMessage(disconnectMessage);
  });

  // Handle connection errors
  ws.on('error', (error) => {
    console.error(`WebSocket error for user ${username}:`, error);
    connectedUsers.delete(username);
  });
});

server.listen(8080, () => {
  console.log('Server is running on http://localhost:8080');
});